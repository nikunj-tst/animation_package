import 'package:animated_toast_demo/animated_toast_demo.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'Animated Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    AnimatedToast().initialize(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                AnimatedToast().showSuccess(
                  context,
                  headerMsg: 'Success',
                  description: 'Success Test Toast',
                  isSuccess: true,
                );
              },
              child: Text("Success Toast"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AnimatedToast().showSuccess(
                  context,
                  headerMsg: 'Failed',
                  description: 'Fail Test Toast',
                  isSuccess: false,
                );
              },
              child: Text("Failed Toast"),
            ),
          ],
        ),
      ),
    );
  }
}
