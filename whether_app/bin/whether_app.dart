import 'dart:convert';

import 'package:http/http.dart' as http;



void main(List<String> arguments) {
  
  final getWeatherApi = GetWeatherApi();
  getWeatherApi.getWeatherInfo('eade7296937e470682064552231805', 'Taraz');

  final getCity = GetCityName();
  getCity.getWeatherInfo('AIzaSyDSc3bK2uacejfepEMiJlrVw9DFC8WVonI', 'Taraz');
}

class GetWeatherApi {
  getWeatherInfo(final key, final cityName) async {
    final url =
        'https://api.weatherapi.com/v1/current.json?key=$key&q=$cityName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      print('api қате шықты');
      return;
    }

    final Map<String, dynamic> jsonResponse =
        Map.castFrom(jsonDecode(response.body));

     final currentData = jsonResponse['location'];
     final country = jsonResponse['current'];

    print("Region : ${currentData['region']} \nTemp C : ${country['temp_c']} ");
  }
}

class GetCityName {
  getWeatherInfo(final key, final cityName) async {
    String ? place_idKerek;
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$cityName&language=en&types=%28cities%29&key=$key';
    final response = await http.get(Uri.parse(url));



    if (response.statusCode != 200 ) {
      print('api қате шықты');
      return;
    }


    final Map<String, dynamic> jsonResponse =
        Map.castFrom(jsonDecode(response.body));

    final predictionsData = jsonResponse['predictions'];

    

    for (var prediction in jsonResponse['predictions']) {
      String description = prediction['description'];
      String place_id = prediction['place_id'];

      if (description.contains("Kazakhstan")){
        print("Description : $description \nPlace Id : $place_id" );
        place_idKerek = place_id; 
        print("/////////////////////\n//////////////////");
      }
    
      
    }
      
    final url2 =
        'https://maps.googleapis.com/maps/api/place/details/json?&place_id=$place_idKerek&key=$key';
    final response2 = await http.get(Uri.parse(url2));

    if (response2.statusCode != 200 ) {
      print('api қате шықты');
      return;
    }
    final Map<String, dynamic> jsonResponse2 =
        Map.castFrom(jsonDecode(response2.body));

    final predictionsData2 = jsonResponse2['result'];
    print("URL is : ${predictionsData2["url"]}");
  }
}