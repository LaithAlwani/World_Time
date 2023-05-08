import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:circle_flags/circle_flags.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'GB'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'GR'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'EG'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'KE'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'US'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'US'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'KR'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'ID'),
  ];

  @override
  Widget build(BuildContext context) {

    void updateTime(index) async{
      WorldTime instance = locations[index];
      await instance.getTime();
      Navigator.pop(context, {
        'location': instance.location,
        'time':instance.time,
        'flag': instance.flag,
        'isDayTime': instance.isDayTime,
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose Location'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleFlag(locations[index].flag),
              ),
            ),
          );
        },
      ),
    );
  }
}
