// ignore_for_file: prefer_const_constructors

import 'package:bloc_challenge/business_logic/cubit/counter_cubit.dart';
import 'package:bloc_challenge/business_logic/cubit/internet_cubit.dart';
import 'package:bloc_challenge/constants/device_driver_value.dart';
import 'package:bloc_challenge/constants/ui_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetDisconnected) {
          BlocProvider.of<CounterCubit>(context).abort();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "You have pushed button many times voila: ",
              ),
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi) {
                  return Text(
                    "TERKONEKSI KE WIFI",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: textRed,
                        fontSize: 20,
                      ),
                    ),
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile) {
                  return Text(
                    "TERKONEKSI KE DATA SELULER",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: textRed,
                        fontSize: 20,
                      ),
                    ),
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    "KONEKSI ANDA TERPUTUS",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: textRed,
                        fontSize: 20,
                      ),
                    ),
                  );
                }
                return Container();
              }),
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
                    Navigator.of(context).pushNamed('/second');
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 20,
                  ),
                  label: Text("Halaman kedua"),
                ),
              )
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
