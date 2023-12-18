


class Weather {
  final String CityName;
  final double temperature;
  final String mainCondation;

  Weather({
    required this.CityName,    
    required this.temperature,
   required this.mainCondation, 
   });


factory Weather.fromJson(Map<String,dynamic>json){
  return Weather(
    CityName: json['name'],
  temperature: json['main']['temp'].toDouble(),
  mainCondation: json['weather'][0]['main'],
  );
}


}
