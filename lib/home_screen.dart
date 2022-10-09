import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List titles = ['Foo', 'Boo', 'Beee'];

class CubitState extends Cubit<String?> {
  CubitState() : super(null);

  void changeState() => emit(titles.getElement());
}

extension Number<T> on Iterable<T> {
  T getElement() => elementAt(math.Random().nextInt(length));
// void getElement() => emit(math.Random().nextInt(length));
}

class _MyHomePageState extends State<MyHomePage> {
  late CubitState cubitState;

  @override
  void initState() {
    cubitState = CubitState();
    super.initState();
  }

  @override
  void dispose() {
    cubitState.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Bloc'),
        ),
        body: StreamBuilder(
          stream: cubitState.stream,
          builder: (context, snapshot) {
            final button =
                ElevatedButton(onPressed: () {}, child: Text('Clicked Me'));

            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return button;
                break;
              case ConnectionState.waiting:
                return button;
                break;
              case ConnectionState.active:
                return Column(
                  children: [Text(snapshot.data ?? ''), button],
                );
                break;
              case ConnectionState.done:
                return SizedBox();
                break;
            }
          },
        ));
  }
}
