import 'package:takeout/widgets/product/product_filters.dart';
abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterModalOpened extends FilterState {
  final FilterType filterType;

  FilterModalOpened(this.filterType);
}

class FilterModalClosed extends FilterState {}
