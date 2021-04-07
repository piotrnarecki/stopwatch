import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Timer',
      theme: ThemeData(
        // This is the theme of your application
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Flutter Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _timer = 0;
  int _laps = 0;
  final _savedLaps = <int>{};
  static const oneSec = const Duration(seconds: 1);

  //new Timer.periodic(oneSec, (Timer t) => print('hi!'));

  Timer myTimer;

  void _startTimer() {
    myTimer = new Timer.periodic(oneSec, (timer) {
      _timer = _timer + 1;
      setState(() {
        _timer = _timer;
      });
    });
  }

  void _stopTimer() {
    if (myTimer.isActive) {
      myTimer.cancel();
    }
    setState(() {});
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _timer = 0;
      _savedLaps.clear();
      _laps = _savedLaps.length;
    });
  }

  void _lapTimer() {
    setState(() {
      _savedLaps.add(_timer);
      _laps = _savedLaps.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(icon: Icon(Icons.list), onPressed: _showLaps),
          ],
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'time: $_timer s',
                ),
                Text(
                  'laps: $_laps',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: _startTimer, child: Text('start')),
                ElevatedButton(onPressed: _stopTimer, child: Text('stop')),
                ElevatedButton(onPressed: _resetTimer, child: Text('reset')),
                ElevatedButton(onPressed: _lapTimer, child: Text('lap')),
              ],
            ),
          ]),
        ));
  }

  void _showLaps() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _savedLaps.map(
            (int lap) {
              return ListTile(
                title: Text('$lap s'
                    //style: _biggerFont,
                    ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved laps'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
