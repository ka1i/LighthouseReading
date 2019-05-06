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

class _MainWindowState extends State<MainWindow> with SingleTickerProviderStateMixin{

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
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return new WillPopScope(
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: new Alignment(0.0, 1.0), // 10% of the width, so there are ten blinds.
            colors: [
              const Color(0x81818166),
              const Color(0x818100),
            ], // whitish to gray
            //tileMode: TileMode.clamp, // repeats the gradient over the canvas
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
                      filter: new ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: new Container(
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                              colors: <Color>[
                                const Color.fromRGBO(162, 146, 199, 0.6),
                                const Color.fromRGBO(51, 51, 51, 0.8),
                              ],
                              stops: [0.2, 1.0],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(0.0, 1.0)
                          ),
                        ),
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
                    title: new Text("Mardan Assistant\nGithub",textAlign: TextAlign.center,softWrap: true,style: new TextStyle(fontFamily: 'ADELE',),),
                    centerTitle: true,
                    backgroundColor: Color.fromRGBO(84, 84, 84, 0.0),
                    elevation: 24.0,
                    actions: <Widget>[
                      new IconButton(
                          icon: new Icon(Icons.search),
                          onPressed: () =>debugPrint('test action'))
                    ],
                  ),
                  preferredSize: Size(100.0, 50.0)),
              backgroundColor: Colors.transparent,

              body: new Container(
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
                          new Row(
                            children: <Widget>[
                              new _Label(
                                label: 'Mardan',
                                forecolor: Colors.white.withOpacity(0.4),
                              ),
                              new _Label(
                                label: '成都',
                                forecolor: Colors.white.withOpacity(0.4),
                              ),
                              new _Label(
                                label: '13086617863@126.com',
                                forecolor: Colors.white.withOpacity(0.4),
                              ),
                            ],
                          ),
                          new SizedBox(
                            height: _height / 50,
                          ),
                          new Row(
                            children: <Widget>[
                              new Text(
                                'Respositories',
                                style: new TextStyle(
                                    fontSize: 10.0, color: Colors.white),
                              ),
                              new SizedBox(
                                width: _width / 50,
                              ),
                              new Text(
                                '9  ',
                                style: new TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              new SizedBox(
                                width: _width / 50,
                              ),
                              new Text(
                                'public_repos',
                                style: new TextStyle(
                                    fontSize: 10.0, color: Colors.white),
                              ),
                              new SizedBox(
                                width: _width / 50,
                              ),
                              new Text(
                                '8  ',
                                style: new TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              new SizedBox(
                                width: _width / 30,
                              ),
                              new Text(
                                'total_private_repos',
                                style: new TextStyle(
                                    fontSize: 10.0, color: Colors.white),
                              ),
                              new SizedBox(
                                width: _width / 30,
                              ),
                              new Text(
                                '1  ',
                                style: new TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          new SizedBox(
                            height: _height / 30,
                          ),
                          new Row(
                            children: <Widget>[
                              new SizedBox(
                                width: _width / 2.5,
                              ),
                              new Text(
                                'created_at',
                                style: new TextStyle(
                                    fontFamily: 'ADELE',fontSize: 16.0, color: Colors.white),
                              ),
                              new SizedBox(
                                width: _width / 50,
                              ),
                              new Text(
                                '2018-12-10T07:58:44Z  ',
                                style: new TextStyle(
                                    fontFamily: 'ADELE',fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              new SizedBox(
                                width: _width / 2.5,
                              ),
                              new Text(
                                'updated_at',
                                style: new TextStyle(
                                    fontFamily: 'ADELE',fontSize: 16.0, color: Colors.white),
                              ),
                              new SizedBox(
                                width: _width / 30,
                              ),
                              new Text(
                                '2019-02-12T11:25:16Z  ',
                                style: new TextStyle(
                                    fontFamily: 'ADELE',fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          new SizedBox(height: _height/8,),
                          new Expanded(
                            child: new SizedBox(
                              height: _height / 4,
                              child: new ListView(
                                children: <Widget>[
                                  new _FollwingList(
                                    title: "Yoga classes with Emily33",
                                    subtitle: "要不吃烧烤去吧",
                                    image: 'assets/image/Avatar.png',
                                    username: "Mardan",
                                    star: 11,
                                    res: 28,
                                    code: 'js',
                                  ),
                                  new _FollwingList(
                                    title: "Breakfast with Harry",
                                    subtitle: "9 - 10am ",
                                    image: 'assets/image/Avatar.png',
                                    username: "Mardan",
                                    star: 11,
                                    res: 28,
                                    code: 'ruby',
                                  ),
                                  new _FollwingList(
                                    title: "Yoga classes with Emily33",
                                    subtitle: "7 - 8am Workout",
                                    image: 'assets/image/Avatar.png',
                                    username: "Mardan",
                                    star: 11,
                                    res: 28,
                                    code: 'python',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(
                          top: _height / 3.5, left: _width / 2.2),
                      child: new Row(
                        children: <Widget>[
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                'Followers',
                                style: new TextStyle(
                                    fontFamily: 'ADELE',
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              new Text(
                                '3',
                                style: new TextStyle(
                                    fontFamily: 'ADELE',
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          new SizedBox(
                            width: _width / 25,
                          ),
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                'Follwing',
                                style: new TextStyle(
                                    fontFamily: 'ADELE',
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              new Text(
                                '6',
                                style: new TextStyle(
                                    fontFamily: 'ADELE',
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          new SizedBox(
                            width: _width / 25,
                          ),
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                'Stars',
                                style: new TextStyle(
                                    fontFamily: 'ADELE',
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              new Text(
                                '122',
                                style: new TextStyle(
                                    fontFamily: 'ADELE',
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              drawer: _initDrawer(),
            )
          ],
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  Widget _initDrawer(){
    return Sidebar(
      child: new ListView(
        children: <Widget>[
          new AvatarHeader(
            accountUser: 'ka1i',
            accountName: 'Mardan',
            accountEmail: '13086617863@126.com',
          ),
          new _DrawerList(
            leading: Icons.home,
            title: 'Home',
          ),
          new _DrawerList(
            leading: Icons.notifications,
            title: 'Notifications',
          ),
          new _DrawerList(
            leading: Icons.camera,
            title: 'Dynamics',
          ),
          new _DrawerList(
            leading: Icons.notification_important,
            title: 'Issues',
          ),
          new Divider(color: Colors.lime,),
          new _DrawerList(
            leading: Icons.settings,
            title: 'Setting',
          ),
          new _DrawerList(
            leading: Icons.person,
            title: 'About',
          ),
        ],
      ),
    );
  }
}


class _DrawerList extends StatelessWidget{
  final IconData leading;
  final String title;

  _DrawerList({
    @required this.leading,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 35.0,
      child: new MaterialButton(
        onPressed: () {
          debugPrint('/${title}');
          //_clicklist();
          Navigator.of(context).pushNamed('/${title}');
        },
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(leading,size: 24,color: Color.fromARGB(81, 81, 81, 1),),
            new SizedBox(width: 20.0,),
            new Text(
              title,
              style: new TextStyle(
                fontFamily: 'ADELE',
                fontWeight: FontWeight.w900,
                fontSize: 18,
                //color: Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String label;
  final Color forecolor;
  final Color fontcolor;
  _Label({this.label,this.forecolor,this.fontcolor});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: new EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
      child: Text(
        label,
        style: new TextStyle(fontFamily: 'ADELE',fontWeight: FontWeight.w900,fontSize: 12.0, color: fontcolor),
      ),
      decoration: new BoxDecoration(
          color: forecolor,
          borderRadius: BorderRadius.all(new Radius.circular(8.0))),
      margin: EdgeInsets.only(right: 4.0),
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

class _FollwingList extends StatelessWidget {
  final EdgeInsets margin;
  final String title;
  final String subtitle;
  final int star;
  final int res;
  final String username;
  final String code;
  final String image;
  _FollwingList({this.margin, this.subtitle,this.code, this.title,this.star,this.res,this.username, this.image});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(3),
      //height: 160,
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          top: new BorderSide(
              width: 1.0, color: const Color.fromRGBO(204, 204, 204, 0.3)),
          bottom: new BorderSide(
              width: 1.0, color: const Color.fromRGBO(204, 204, 204, 0.3)),
        ),
      ),
      child: new Row(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(
                left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
            width: 60.0,
            height: 60.0,
            decoration:
            new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                image: new ExactAssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new SizedBox(
                height: 5.0,
              ),
              new Row(
                children: <Widget>[
                  new Text(
                    title,
                    style:
                    new TextStyle(fontFamily: 'ADELE',fontSize: 17.0, fontWeight: FontWeight.w700),
                  ),
                  new _Label(
                    label: code,
                    forecolor: Colors.black.withOpacity(0.1),
                    fontcolor: Colors.blueGrey,
                  ),
                ],
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 5.0),
                child: new Text(
                  subtitle,
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,fontFamily: 'mini',
                      fontWeight: FontWeight.w500),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 5.0,),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Icon(Icons.star,size: 14,color: Color.fromARGB(81, 81, 81, 1),),
                    new Text(
                      star.toString(),
                      style: new TextStyle(
                          color: Color.fromARGB(81, 81, 81, 1),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                    new SizedBox(width: 40,),
                    new Icon(
                      Icons.accessibility,
                      size: 14,color: Color.fromARGB(81, 81, 81, 1),),
                    new Text(
                      res.toString(),
                      style: new TextStyle(
                          color: Color.fromARGB(81, 81, 81, 1),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                    new SizedBox(width: 40,),
                    new Icon(Icons.person,size: 14,color: Color.fromARGB(81, 81, 81, 1),),
                    new Text(
                      username,
                      style: new TextStyle(
                          color: Color.fromARGB(81, 81, 81, 1),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              new SizedBox(
                height: 5.0,
              ),
            ],
          )
        ],
      ),
    ));
  }
}