import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/widgets/product/product_filters.dart';
import 'event.dart';
import 'state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<OpenFilterModal>((event, emit) async {
      emit(
        FilterModalOpened(
          filterType: event.filterType,
          activeFilters:
              state is FilterApplied
                  ? (state as FilterApplied).activeFilters
                  : {},
        ),
      );
    });

    on<CloseFilterModal>((event, emit) {
      if (state is FilterModalOpened) {
        final currentState = state as FilterModalOpened;
        emit(FilterApplied(activeFilters: currentState.activeFilters));
      }
    });

    on<FilterSelectionChanged>((event, emit) {
      final newFilters = Map<FilterType, Set<int>>.from(
        state is FilterApplied ? (state as FilterApplied).activeFilters : {},
      );

      if (event.selectedIds.isEmpty) {
        newFilters.remove(event.filterType);
      } else {
        newFilters[event.filterType] = Set<int>.from(event.selectedIds);
      }

      emit(FilterApplied(activeFilters: newFilters));
    });

    on<ResetFilters>((event, emit) {
      emit(FilterApplied(activeFilters: {}));
    });
  }
}
