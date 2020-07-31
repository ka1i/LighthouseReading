import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: initBody()
    );
  }
  Widget initBody() {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.indigo,
      Colors.pinkAccent,
      Colors.blue,
    ];
    return new Container(
      padding: const EdgeInsets.all(0.0),
      decoration: new BoxDecoration(
        color: Colors.black,
      ),
      child: new ListView(
        padding: const EdgeInsets.all(5.0),
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new _UserAvatar(userAvatar: 'assets/image/Avatar.png',),
              new _LoginGroupForm(),
              new _LoginGithub(),
              new _RegisterAccount(),
              new _AssistantCopyRight(copyrightSize: 9,),
            ],
          ),
        ],
      ),
    );
  }

}

class _UserAvatar extends StatelessWidget {
  final String userAvatar;
  _UserAvatar({@required this.userAvatar,});
  @override
  Widget build(BuildContext context) {
    return (new Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            child: new CircleAvatar(
              backgroundImage: AssetImage(userAvatar),
              backgroundColor: Colors.transparent,
              radius: 40.0,
            ),
          ),
          new SizedBox(
            height: 10,
          ),
          new Text(
            "Sign in to GitHub",
            style: new TextStyle(
              fontFamily: "ADELE",
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ));
  }
}

class _InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  _InputFieldArea({this.hint, this.obscure, this.icon});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            width: 0.5,
            color: Colors.white24,
          ),
        ),
      ),
      child: new TextFormField(
        obscureText: obscure,
        style: const TextStyle(
          fontFamily: 'ADELE',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        decoration: new InputDecoration(
          icon: new Icon(
            icon,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 14.0),
          contentPadding: const EdgeInsets.only(
              top: 40.0, right: 30.0, bottom: 30.0, left: 3.0),
        ),
      ),
    ));
  }
}
class _LoginGroupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new _InputFieldArea(
                  hint: "Username or email address",
                  obscure: false,
                  icon: Icons.person_outline,
                ),
                new _InputFieldArea(
                  hint: "Password",
                  obscure: true,
                  icon: Icons.lock_outline,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class _LoginGithub extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      alignment: FractionalOffset.center,
      child: SizedBox(
        width: 320.0,
        height: 60.0,
        child: new RaisedButton(
          //color: const Color.fromRGBO(247, 64, 106, 1.0),
          color: Color.fromRGBO(81, 81, 81, 1.0),
          child: new Text(
            'Sign in',
            style: new TextStyle(
              color: Colors.white,
              fontFamily: 'ADELE',
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.9,
            ),
          ),
          onPressed: (){
            print("login is click.");
          },
          shape: StadiumBorder(),
          elevation: 24,
          splashColor: Colors.black,
        ),
      ),
    );
  }
}

class _RegisterAccount extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return (new Container(
      child: new FlatButton(
          padding: const EdgeInsets.only(top: 90),
          onPressed: null,
          child: new Column(
            children: <Widget>[
              new Text(
                "Don't have an account?\nRegistered in Github",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: new TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'ADELE',
                    letterSpacing: 0.5,
                    color: Colors.white,
                    fontSize: 13.0
                ),
              ),
            ],
          )
      ),
    ));
  }
}

class _AssistantCopyRight extends StatelessWidget{
  final double copyrightSize;
  _AssistantCopyRight({@required this.copyrightSize});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (new Container(
      alignment: Alignment.bottomCenter,
      child: new FlatButton(
        padding: const EdgeInsets.only(top: 35),
        onPressed: null,
        child: new Text(
          "Power by UESTC-2017.1101.Mardan & \nCopyright © 2017 - 2021 Mardan. All Rights Reserved.",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: new TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
              color: Colors.white,
              fontSize: 9.0),
        ),
      ),
    ));
  }
}