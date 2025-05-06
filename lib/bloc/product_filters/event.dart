import 'package:takeout/widgets/product/product_filters.dart';

abstract class FilterEvent {}

class OpenFilterModal extends FilterEvent {
  final FilterType filterType;

  OpenFilterModal(this.filterType);
}

class CloseFilterModal extends FilterEvent {}

class FilterSelectionChanged extends FilterEvent {
  final FilterType filterType;
  final List<int> selectedIds;

  FilterSelectionChanged({required this.filterType, required this.selectedIds});
}

class ResetFilters extends FilterEvent {}
