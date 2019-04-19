import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:github/common/utils/color_loader.dart';

class LoginWindow extends StatefulWidget {
  const LoginWindow({Key key}) :super(key: key);
  @override
  LoginWindowState createState() => new LoginWindowState();
}

class LoginWindowState extends State<LoginWindow> with TickerProviderStateMixin{

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
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
          body: initBody()
      ),
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
        image: new DecorationImage(image: new ExactAssetImage('assets/image/login_background.jpg'),fit: BoxFit.cover),
      ),
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
        child: new ListView(
          padding: const EdgeInsets.all(5.0),
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new _UserAvatar(userAvatar: 'assets/image/main_avatar.jpg',),
                new _LoginGroupForm(),
                new _LoginGithub(),
                new Offstage(offstage: true,child: new ColorLoader(colors: colors,duration: Duration(milliseconds: 1200),),),
                new _RegisterAccount(),
                new _AssistantCopyRight(copyrightSize: 9,),
              ],
            ),
          ],
        ),
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
      padding: const EdgeInsets.only(top: 80.0,bottom: 30.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            child: new CircleAvatar(
              backgroundImage: AssetImage(userAvatar),
              radius: 50.0,
            ),
          )
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
          color: Colors.white,
        ),
        decoration: new InputDecoration(
          icon: new Icon(
            icon,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
          contentPadding: const EdgeInsets.only(
              top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
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
                  hint: "Emall Address",
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
          color: const Color.fromRGBO(247, 64, 106, 1.0),
          child: new Text(
            'Login',
            style: new TextStyle(
              color: Colors.white,
              fontFamily: 'ADELE',
              fontSize: 22.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.9,
            ),
          ),
          onPressed: (){
            /*/*https://api.github.com/graphql*/*/
            Navigator.popAndPushNamed(context,'/Main');
          },
          shape: StadiumBorder(),
          elevation: 24,
          splashColor: Colors.blueGrey,
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
        child: new Text(
          "Don't have an account? \nRegistered in Github",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: new TextStyle(
              fontWeight: FontWeight.w300,
              fontFamily: 'ADELE',
              letterSpacing: 0.5,
              color: Colors.white,
              fontSize: 12.0),
        ),
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
          "Power by UESTC.Mardan & \nCopyright © 2017 - 2021 Mardan. All Rights Reserved.",
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