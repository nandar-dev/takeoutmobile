import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/cards/category_card_2.dart';
import 'package:takeout/cubit/category/category_cubit.dart';
import 'package:takeout/cubit/category/category_state.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final title = "title.category".tr();

    return Scaffold(
      appBar: AppBarWidget(title: title, borderedBack: false),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoaded) {
              return ListView.separated(
                itemCount: state.categories.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return CategoryCard2(category: category);
                },
              );
            } else if (state is CategoryError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text('No categories available.'));
          },
        ),
      ),
    );
  }
}
