import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Snackbar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
      if(_counter % 3 == 0){
        ScaffoldMessenger.of(context)
        ..clearSnackBars()..showSnackBar(
        SnackBar(
          content: CustomSnackBar(counter: _counter, context: context,
            title: 'Counter', error: 'the number after increment  is',
            settingImg: SvgPicture.asset('assets/images/ic_setting_icon.svg', height: 30.0, width: 30.0,),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    Key? key,
    required int counter,
    required this.context,
    required this.title, required this.error, this.settingImg
  }) : _counter = counter, super(key: key);

  final int _counter;
  final BuildContext context;
  final String title;
  final String error;
  final SvgPicture? settingImg;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          height: 90.0,
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),

          ),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('{$title}', style: const TextStyle(fontSize: 24.0, color: Colors.white), textAlign: TextAlign.center,),
                    Text('$error $_counter ::' , maxLines: 2, overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
            ],
          )),
          Positioned(
            bottom: 5.0,
            left: 10.0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20.0)),
              child: SvgPicture.asset('assets/images/next.svg',
               height: 40.0,
                width: 40.0,
              //  color: Colors.white,
               ),
            ),
          ),
           Positioned(
            top: -20.0,
            left: MediaQuery.of(context).size.width / 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20.0)),
              child: Stack(
                children: [
                  SvgPicture.asset('assets/images/ic_check_icon.svg',
                   height: 40.0,
                    width: 40.0,
                   ),
                   Positioned(
                     top: 4, left: 10,
                     child: SvgPicture.asset('assets/images/ic_setting_icon.svg',
                     height: 20.0,
                      width: 20.0,
                     ),
                   ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20.0,
            right: 10.0,
              child: settingImg ?? const Text('X'),    
            ),
      ],
    );
  }
}
