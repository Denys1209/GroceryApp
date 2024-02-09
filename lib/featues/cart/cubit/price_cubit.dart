import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'price_state.dart';

class PriceCubit extends Cubit<double> {
  PriceCubit() : super(0);

  void set(double price) => emit(price);
  void add(double price) => emit(state + price);
  void minus(double price) => emit(state - price);
}
