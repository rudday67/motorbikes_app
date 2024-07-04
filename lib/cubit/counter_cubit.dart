import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterInitial());

  void increment() {
    final int newcounter = state.counter + 1;
    final String newstatus = newcounter % 2 == 0 ? "genap" : "ganjil";
    final Color newColor = newcounter % 2 == 0
        ? Color.fromARGB(255, 243, 135, 33)
        : Color.fromARGB(255, 40, 241, 255);
    emit(CounterState(
        counter: newcounter, status: newstatus, textColor: newColor));
  }

  void decrement() {
    final int newcounter = state.counter - 1;
    final String newstatus = newcounter % 2 == 0 ? "genap" : "ganjil";
    final Color newColor = newcounter % 2 == 0
        ? Color.fromARGB(255, 243, 135, 33)
        : Color.fromARGB(255, 40, 241, 255);
    emit(CounterState(
        counter: newcounter, status: newstatus, textColor: newColor));
  }
}
