import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/widgets/filters/filter_model.dart';
import 'package:takeout/widgets/buttons/sort_button.dart';
import 'package:takeout/bloc/product_filters/bloc.dart';
import 'package:takeout/bloc/product_filters/state.dart';
import 'package:takeout/bloc/product_filters/event.dart';

enum FilterType { category, sort, offer, shop }

class ProductFilters extends StatelessWidget {
  const ProductFilters({
    super.key,
    required this.filterBtnIcon,
    required this.sortBtnLabel,
    required this.chevronDownIcon,
    required this.offerBtnLabel,
    required this.shopBtnLabel,
  });

  final String filterBtnIcon;
  final String sortBtnLabel;
  final String chevronDownIcon;
  final String offerBtnLabel;
  final String shopBtnLabel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FilterBloc, FilterState>(
      listenWhen: (previous, current) => current is FilterModalOpened,
      listener: (context, state) {
        if (state is FilterModalOpened) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showModalBottomSheet<List<int>>(
              context: context,
              builder:
                  (_) => FilterModal(
                    filterType: state.filterType,
                    initialSelectedIds:
                        state.activeFilters[state.filterType]?.toList() ?? [],
                  ),
            ).then((selectedIds) {
              if (selectedIds != null) {
                context.read<FilterBloc>().add(
                  FilterSelectionChanged(
                    filterType: state.filterType,
                    selectedIds: selectedIds,
                  ),
                );
              }
              if (context.mounted) {
                context.read<FilterBloc>().add(CloseFilterModal());
              }
            });
          });
        }
      },
      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SortButton(
                onTap: () {
                  context.read<FilterBloc>().add(
                    OpenFilterModal(FilterType.category),
                  );
                },
                iconHeight: 12,
                iconWeight: 12,
                icon: filterBtnIcon,
                angleVal: 90 * (3.1416 / 180),
              ),
              const SizedBox(width: 5),
              SortButton(
                onTap: () {
                  context.read<FilterBloc>().add(
                    OpenFilterModal(FilterType.sort),
                  );
                },
                label: sortBtnLabel,
                icon: chevronDownIcon,
              ),
              const SizedBox(width: 5),
              SortButton(
                onTap: () {
                  context.read<FilterBloc>().add(
                    OpenFilterModal(FilterType.offer),
                  );
                },
                label: offerBtnLabel,
                icon: chevronDownIcon,
              ),
              const SizedBox(width: 5),
              SortButton(
                onTap: () {
                  context.read<FilterBloc>().add(
                    OpenFilterModal(FilterType.shop),
                  );
                },
                label: shopBtnLabel,
                icon: chevronDownIcon,
              ),
            ],
          );
        },
      ),
    );
  }
}
