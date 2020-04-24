import 'dart:convert';

import 'package:http/http.dart';
import 'package:bircoin_ticker/price_screen.dart';
import 'package:bircoin_ticker'
    '/coin_data.dart';

class Sikkadata{

  String NeteorkURl="https://rest.coinapi.io/v1/exchangerate"; // this is the our Network urls...

  String APIKey="BF8F5FCE-6040-4600-93D8-F3B8F915A4C9";

 Future fetchdata( String selectedCurrency) async
 {


Map<String ,String> cryptoPrices={};
// this is the our dictionary like Map Where it is the store the key and value data's

for(String crypto in cryptoList)
  {
    String requesturl='$NeteorkURl/$crypto/$selectedCurrency?apikey=$APIKey';

    Response response=await get(requesturl);
    if(response.statusCode==200)
      {

        var decodeData=jsonDecode(response.body);
        double price = decodeData['rate']; // this is store the price from the decooded by the json variable
        cryptoPrices[crypto]=price.toStringAsFixed(0);// cryptoPrices use for store the value inside the cryptoPrices Map data..
        // to StringAsFixed use for the  get the nearest value of the Decimal number

      }
    else
      {
        print(response.statusCode);
        throw'Problem with the get request';
      }


  }


return cryptoPrices;


 }


}

