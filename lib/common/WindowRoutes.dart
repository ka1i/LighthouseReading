import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:Github/page/LoginWindow.dart';
import 'package:Github/page/MainWindow.dart';


void main(){
  //debugPaintSizeEnabled=true;
  runApp(new App());
  PaintingBinding.instance.imageCache.maximumSize = 100;
}
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Mardan Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new LoginWindow(),
      onGenerateRoute: (RouteSettings setting){
        switch(setting.name){
          case '/Login':
            return new AssistantRoute(
              builder: (_)=>new LoginWindow(),
              settings: setting,
            );
          case '/Main':
            return new AssistantRoute(
              builder: (_)=>new MainWindow(),
              settings: setting,
            );
        }
      },
    );
  }
}

class AssistantRoute<T> extends MaterialPageRoute<T>{
  AssistantRoute({WidgetBuilder builder,RouteSettings settings})
      :super(builder:builder,settings:settings);

  @override
  Widget buildTransitions(BuildContext context,Animation<double> animation,
      Animation<double> second,Widget child){
    if(settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation,child: child,);
  }
}