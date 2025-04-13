import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/product_filters/event.dart';
import 'package:takeout/bloc/product_filters/state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<OpenFilterModal>((event, emit) {
      emit(FilterModalOpened(event.filterType));
    });

    on<CloseFilterModal>((event, emit) {
      emit(FilterModalClosed());
    });
  }
}
