import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/formfields/customdropdownfield_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:takeout/widgets/formfields/image_upload.dart';
import 'package:takeout/widgets/formfields/time_picker.dart';
import 'package:takeout/widgets/multilingual_address_description.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class AddShopPage extends StatefulWidget {
  const AddShopPage({super.key});

  @override
  State<AddShopPage> createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  PlatformFile? uploadedLogo;
  PlatformFile? uploadedCover;
  String? selectedType;
  String selectedLanguage = "en";

  // New variables for opening and closing time
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;

  final Map<String, TextEditingController> addressControllers = {};
  final Map<String, TextEditingController> descriptionControllers = {};

  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> languages = [
    {"label": 'en', "icon": "🇺🇸"},
    {"label": 'zh', "icon": "🇨🇳"},
    {"label": 'my', "icon": "🇲🇲"},
    {"label": 'th', "icon": "🇹🇭"},
  ];

  final List<String> shopTypeOptions = [
    "Candy Shop",
    "Boutique",
    "Pharmacy",
    "Hardware Store",
    "News Stand",
    "Butcher",
    "Book Shops",
  ];

  @override
  void initState() {
    super.initState();
    for (var lang in languages) {
      final code = lang["label"];
      addressControllers[code] = TextEditingController();
      descriptionControllers[code] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in addressControllers.values) {
      controller.dispose();
    }
    for (var controller in descriptionControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final optional = "status.optional".tr();
    final title = "title.merchant_add_shop".tr();
    final des = "merchant_shop.shop_list_des".tr();
    final shopInfo = "merchant_shop.shop_info".tr();
    final label1 = "merchant_shop.shop_type".tr();
    final label2 = "merchant_shop.logo".tr();
    final label3 = "merchant_shop.cover".tr();
    final placeholder1 = "merchant_shop.select_shop".tr();
    final placeholder2 = "merchant_shop.name".tr();
    final placeholder3 = "merchant_shop.phone".tr();
    final placeholder4 = "merchant_shop.link".tr();

    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubText(text: des),
              const SizedBox(height: 24),
              Row(
                children: <Widget>[
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SubText(text: shopInfo, fontSize: FontSizes.sm),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),
              CustomDropdownFormField<String>(
                label: label1,
                value: selectedType,
                items: shopTypeOptions,
                hintText: placeholder1,
                onChanged: (val) {
                  setState(() {
                    selectedType = val;
                  });
                },
                isSearchable: true,
                validator: (val) => val == null ? placeholder1 : null,
              ),
              const SizedBox(height: 24),
              CustomTextField(label: "", hint: placeholder2),
              const SizedBox(height: 24),
              CustomTextField(label: "", hint: placeholder3),
              const SizedBox(height: 24),
              CustomTextField(label: "", hint: "$placeholder4 ($optional)"),
              const SizedBox(height: 24),
              ImageUpload(
                label: label2,
                description: "",
                onFileChanged: (file) {
                  setState(() {
                    uploadedLogo = file;
                  });
                },
              ),
              ImageUpload(
                label: label3,
                description: "",
                onFileChanged: (file) {
                  setState(() {
                    uploadedCover = file;
                  });
                },
              ),
              const SizedBox(height: 12),
              // Language selector
              MultilingualAddressDescription(
                languages: languages,
                requiredLangCode: 'en',
                addressControllers: addressControllers,
                descriptionControllers: descriptionControllers,
              ),
              const SizedBox(height: 24),
              // Opening Time Picker
              TimePicker(
                label: "Opening Time",
                selectedTime: openingTime,
                onTimeSelected: (time) {
                  setState(() {
                    openingTime = time;
                  });
                },
              ),
              const SizedBox(height: 24),
              // Closing Time Picker
              TimePicker(
                label: "Closing Time",
                selectedTime: closingTime,
                onTimeSelected: (time) {
                  setState(() {
                    closingTime = time;
                  });
                },
              ),
              const SizedBox(height: 24),
              SizedBox(width: double.infinity , child: CustomPrimaryButton(text: "button.register_shop".tr(), onPressed: (){})),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
