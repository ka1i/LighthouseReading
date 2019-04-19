import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';


class AvatarHeader extends StatefulWidget {

  const AvatarHeader({
    Key key,
    @required this.accountUser,
    @required this.accountName,
    @required this.accountEmail,
  }) : super(key: key);

  final String accountUser;

  final String accountName;

  final String accountEmail;

  AvatarHeaderState createState() => new AvatarHeaderState();
}
class AvatarHeaderState extends State<AvatarHeader>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: <Widget>[
        new Container(
          height: 150,
          decoration: BoxDecoration(
            //color: Color.fromRGBO(81, 81, 81, 1),
            color: Colors.black26,
          ),
        ),
        new Positioned(top: 22.0,left: 12.0,child: new CircleAvatar(backgroundImage: new NetworkImage('https://avatars1.githubusercontent.com/u/45752767?v=4'), radius: 35.0,),),
        new Positioned(top: 90.0,left: 10,child: new Text('login: ka1i',style: const TextStyle(fontFamily: 'ADELE', color: Colors.blueGrey,fontSize: 22))),
        new Positioned(top: 115.0,left: 10,child: new Text('name: Mardan',style: const TextStyle(fontFamily: 'ADELE', color: Colors.blueGrey,fontSize: 16))),
        new Positioned(top: 130.0,left: 10,child: new Text('emial: 13086617863@126.com',style: const TextStyle(fontFamily: 'ADELE', color: Colors.blueGrey,fontSize: 16))),
      ],
    );
  }
}
