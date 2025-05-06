import 'package:takeout/widgets/product/product_filters.dart';

abstract class FilterState {
  final Map<FilterType, Set<int>> activeFilters;

  const FilterState({this.activeFilters = const {}});
}

class FilterInitial extends FilterState {}

class FilterModalOpened extends FilterState {
  final FilterType filterType;

  const FilterModalOpened({
    required this.filterType,
    required Map<FilterType, Set<int>> activeFilters,
  }) : super(activeFilters: activeFilters);
}

class FilterModalOpenHandled extends FilterState {
  const FilterModalOpenHandled({
    required Map<FilterType, Set<int>> activeFilters,
  }) : super(activeFilters: activeFilters);
}

class FilterApplied extends FilterState {
  const FilterApplied({required Map<FilterType, Set<int>> activeFilters})
    : super(activeFilters: activeFilters);
}
