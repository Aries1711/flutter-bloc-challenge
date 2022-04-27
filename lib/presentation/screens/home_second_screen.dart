// ignore_for_file: prefer_const_constructors

import 'package:bloc_challenge/business_logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeSecondScreen extends StatefulWidget {
  HomeSecondScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeSecondScreen> createState() => _HomeSecondScreenState();
}

class _HomeSecondScreenState extends State<HomeSecondScreen> {
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
              "You have pushed button many times: ",
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  Fluttertoast.showToast(
                      msg: "Kau tambah bro!",
                      toastLength: Toast.LENGTH_LONG,
                      fontSize: 16.0);
                } else {
                  Fluttertoast.showToast(
                      msg: "Kau Kurangi bro!",
                      toastLength: Toast.LENGTH_LONG,
                      fontSize: 16.0);
                }
              },
              builder: (context, state) {
                return Text(
                  "THE VALUE ${state.counterValue}",
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  heroTag: 'btn-',
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  heroTag: 'btn+',
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/three');
                },
                icon: Icon(
                  Icons.logout,
                  size: 20,
                ),
                label: Text("Halaman ketiga"),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
