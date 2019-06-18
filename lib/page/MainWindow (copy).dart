import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Github/common/avatarHeader.dart';
import 'package:Github/common/sidebar.dart';

import 'dart:ui';


class MainWindow extends StatefulWidget {
  MainWindow({Key key}) : super(key: key);

  @override
  _MainWindowState createState() => new _MainWindowState();
}// with TickerProviderStateMixin

class _MainWindowState extends State<MainWindow> {

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }


  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Are You Sure?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () async{await pop();},
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }


  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

   return new WillPopScope(
     onWillPop: _onWillPop,
     child: new Container(
       decoration: new BoxDecoration(
         gradient: new LinearGradient(
           begin: Alignment.topRight,
           end: new Alignment(0.0, 1.0), // 10% of the width, so there are ten blinds.
           colors: [
             const Color(0xFFC5C5C5),
             const Color(0xFFFFFFFF),
           ], // whitish to gray
           tileMode: TileMode.clamp, // repeats the gradient over the canvas
         ),
       ),
       child: new Stack(
         children: <Widget>[
           new ClipPath(
             clipper: new ArcClipper(),
             child: new SafeArea(
               child: new Stack(
                children: <Widget>[
                  new Image.network(
                    'https://avatars1.githubusercontent.com/u/45752767?v=4',
                    fit: BoxFit.cover,
                    width: _width,
                    height: _height / 2.5,
                    colorBlendMode: BlendMode.clear,
                  ),
                  new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 3,sigmaY: 3),
                    child: new Container(
                      color: Colors.white.withOpacity(0.1),
                      width: _width,
                      height: _height / 2.5,
                    ),
                  ),
                ],
               ),
             ),
           ),
           new Padding(
             padding: new EdgeInsets.only(top: _height / 3.3, left: _width / 20),
             child: new Material(
               child: new CircleAvatar(
                   backgroundImage: new NetworkImage(
                     'https://avatars1.githubusercontent.com/u/45752767?v=4',
                   ),
                   radius: _height / 12),
               elevation: 15.0,
               color: Colors.transparent,
               borderRadius:
               new BorderRadius.all(new Radius.circular(_height / 12)),
             ),
           ),
           new Scaffold(
             appBar: new PreferredSize(
                 child: new AppBar(
                   title: new Text("Mardan Assistant",style: new TextStyle(fontFamily: 'ADELE',color: Colors.black),),
                   centerTitle: true,
                   backgroundColor: Colors.transparent,
                   leading: new Icon(Icons.list,),
                   elevation: 0,
                   actions: <Widget>[
                     new IconButton(
                         icon: new Icon(Icons.search),
                         onPressed: () =>debugPrint('test action'))
                   ],
                 ),
                 preferredSize: Size(100.0, 50.0)
             ),
             backgroundColor: Colors.transparent,
             body: UserProfile(),
           ),
         ],
       ),
     ),
   );
  }

}
class UserProfile extends StatelessWidget{

  @override
 Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return new Container(
      child: new Stack(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(left:_width / 30,right: _width / 30),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new SizedBox(
                  height: _height / 30,
                ),
                new Text(
                  'Ka1i',
                  style: new TextStyle(
                      fontFamily: 'ADELE',fontWeight: FontWeight.w900,
                      fontSize: 22.0, color: Colors.white),
                ),
                new SizedBox(
                  height: _height / 100,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, 3 * size.height / 4);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
