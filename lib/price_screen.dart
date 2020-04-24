import 'dart:io';
import 'package:bircoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiver/io.dart';
import 'package:bircoin_ticker/network/networkAPI.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String defaultvalue;
  String selectedCurrency = 'AUD';

// this widget  is use for the android widgets
  Widget androidropdown() {
    return DropdownButton<String>(
        value: defaultvalue,
        items: currenciesList.map((String dropdowns) {
          return DropdownMenuItem<String>(
            value: dropdowns,
            child: Text(dropdowns),
          );
        }).toList(),
        // this is the onchanged code..
        onChanged: (String dropdowns) {
          setState(() {
            defaultvalue = dropdowns;
            selectedCurrency =
                defaultvalue; // this is the return the selected value from the dropdown option by users.
            print(defaultvalue);
          });
        },
        //  value: dropvalue,
        focusColor: Colors.yellowAccent,
        isDense: true,
        style: TextStyle(color: Colors.white, fontSize: 20.0),
        elevation: 10,
        icon: Icon(Icons.add),
        hint: new Text("Selet your choice..",
            style: TextStyle(color: Colors.deepOrange)));
  }

// this widget are use for the ios widgets..
  Widget dropdown() // widget use for write the code of the widget inside the widget ....
  {
    List<Text> pickerlist() {
      List<Text> currency = [];

      for (String cur in currenciesList) {
        currency.add(Text(cur));
      }
      return currency;
    }

    return CupertinoPicker(
      squeeze: 1,
      diameterRatio: 20,
      itemExtent: 32,
      backgroundColor: Colors.blue,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          print(
              selectedCurrency); // this is the return the selected Currenct from the user
        });
      },
      children: pickerlist(),
    );
  }

// here we decide  the ios and android dropdown widget set according to the device...

  Widget checkdevice() {
    if (Platform.isAndroid) {
      return dropdown();
    }
    if (Platform.isAndroid) {
      return androidropdown();
    }
  }
  Map<String, String> coinValues = {}; // here we store the data
  bool isWaiting = false;

  void getData() async // this method are use for the get data all network data
  {
    isWaiting=true;
    // here we get the data
    try{

      var Data= await Sikkadata().fetchdata(selectedCurrency);
      isWaiting=false;
      setState(() {
        coinValues=Data;

      });
    }
    catch(e)
    {

    print(e);
    }



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }




  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: crypto,
          selectedCurrency: selectedCurrency,
         // value: isWaiting ? '?' : coinValues[crypto],
          value: isWaiting ?'?':coinValues[crypto],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }










  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? dropdown() : androidropdown(),
          ),
        ],
      ),
    );
  }
}


class CryptoCard extends StatelessWidget {
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
