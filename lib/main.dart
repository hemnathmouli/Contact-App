import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/contact.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UptimePages();
  }

}

class _UptimePages extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UpTime',
      routes: <String, WidgetBuilder>{
        '/contacts': (BuildContext context) => new contactNew(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: HomePage(),
        floatingActionButton: new SetNavigation(),
      ),

    );
  }
}