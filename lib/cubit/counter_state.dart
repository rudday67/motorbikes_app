part of 'counter_cubit.dart';

@immutable
class CounterState {
  final int counter;
  final String? status;
  final Color? textColor;
  const CounterState(
      {required this.counter, this.status, required this.textColor});
}

final class CounterInitial extends CounterState {
  const CounterInitial()
      : super(counter: 0, status: "genap", textColor: Colors.blue);
}
