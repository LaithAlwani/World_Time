import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location; // location name of ui
  String time =''; //time in the location
  String flag; //url to asset flag icon
  String url; //location url for api endpoint

  WorldTime ({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{
    try{
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/${url}"));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //create DateTime object
      DateTime now  = DateTime.parse(datetime);
      now = now.subtract(Duration(hours:int.parse(offset)));

      //set the time property
      time = DateFormat.jm().format(now);
    }

    catch (e) {
      print('caught error: $e');
      time ='Could not get time';
    }


  }
}

