import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/formfields/customdropdownfield_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:takeout/widgets/formfields/image_upload.dart';
import 'package:takeout/widgets/multilingual_toggler.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  String? selectedCategory;
  String? selectedShop;

  List<Map<String, dynamic>> languages = [
    {"label": 'en', "icon": "🇺🇸"},
    {"label": 'zh', "icon": "🇨🇳"},
    {"label": 'my', "icon": "🇲🇲"},
    {"label": 'th', "icon": "🇹🇭"},
  ];

  final List<String> categoryOptions = ["Beverages", "Snacks", "Electronics"];
  final List<String> shopOptions = ["Shop A", "Shop B", "Shop C"];

  // Controllers: controllers[languageCode][fieldName]
  final Map<String, Map<String, TextEditingController>> controllers = {};

  @override
  void initState() {
    super.initState();
    for (var lang in languages) {
      final code = lang["label"];
      controllers[code] = {
        "product_description": TextEditingController(),
      };
    }
  }

  @override
  void dispose() {
    for (var map in controllers.values) {
      for (var controller in map.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = "title.add_product".tr();
    final cLabel = "input.category".tr();
    final cPlaceholder = "input.select_category".tr();
    final sLabel = "input.shop".tr();
    final sPlaceholder = "input.select_shop".tr();
    final priceLabel = "input.price".tr();
    final stockLabel = "input.stock".tr();

    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubText(text: "title.product_info".tr()),
              const SizedBox(height: 24),
              CustomDropdownFormField<String>(
                label: cLabel,
                value: selectedCategory,
                items: categoryOptions,
                hintText: cPlaceholder,
                onChanged: (val) {
                  setState(() {
                    selectedCategory = val;
                  });
                },
                isSearchable: true,
                validator: (val) => val == null ? cPlaceholder : null,
              ),
              const SizedBox(height: 12),
              CustomDropdownFormField<String>(
                label: sLabel,
                value: selectedShop,
                items: shopOptions,
                hintText: sPlaceholder,
                onChanged: (val) {
                  setState(() {
                    selectedShop = val;
                  });
                },
                isSearchable: true,
                validator: (val) => val == null ? sPlaceholder : null,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: "",
                hint: priceLabel,
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? "$priceLabel is required" : null,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: "",
                hint: stockLabel,
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? "$stockLabel is required" : null,
              ),
              const SizedBox(height: 24),
              // Multilingual Inputs
              MultilingualToggler(
                languages: languages,
                requiredLangCode: 'en',
                fields: ["description"],
                controllers: controllers,
              ),
              // Image Upload Fields (optional)
              ImageUpload(
                label: "input.preview_image".tr(),
                description: "",
                onFileChanged: (file) {
                  // handle file
                },
              ),
              ImageUpload(
                label: "input.product_images".tr(),
                description: "",
                onFileChanged: (file) {
                  // handle file
                },
              ),
              SizedBox(
                width: double.infinity,
                child: CustomPrimaryButton(
                  text: "button.create_product".tr(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Submit logic
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
