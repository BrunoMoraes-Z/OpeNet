import 'package:flutter/material.dart';
import 'package:openet/utils/my_toast.dart';

class CounterController {
  // var counter = RxNotifier<int>(0);

  void increment() {
    // counter.value = counter.value + 1;
    MyToast.showSucess('Teste asdasdasdasd asdasdasd assdasdasd asdasda ');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller = CounterController();

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
            Text(
              'You have pushed the button this many times:',
            ),
            // RxBuilder(
            //   builder: (_) {
            //     return Text(
            //       '${controller.counter.value}',
            //       style: Theme.of(context).textTheme.headline4,
            //     );
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
