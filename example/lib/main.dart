import 'package:flutter/material.dart';
import 'package:simpleappbar/simpleappbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        context: context,
        title: Text('Simple appbar'),
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50.0,
            color: Colors.black,
            margin: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "${index + 1}",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
