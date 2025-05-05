import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';

class CustomDropdownFormField<T> extends StatefulWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String? hintText;
  final String? Function(T?)? validator;
  final void Function(T?) onChanged;
  final String Function(T)? itemToString;
  final bool showLabelAbove;
  final IconData? prefixIcon;
  final Color? fillColor;
  final bool isSearchable;

  const CustomDropdownFormField({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText,
    this.validator,
    this.itemToString,
    this.showLabelAbove = true,
    this.prefixIcon,
    this.fillColor,
    this.isSearchable = false,
  });

  @override
  State<CustomDropdownFormField<T>> createState() => _CustomDropdownFormFieldState<T>();
}

class _CustomDropdownFormFieldState<T> extends State<CustomDropdownFormField<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  void _openSelectModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: widget.fillColor ?? AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (_) => _SelectModal<T>(
        items: widget.items,
        itemToString: widget.itemToString,
        initialValue: selectedValue,
        isSearchable: widget.isSearchable,
        onSelect: (val) {
          setState(() {
            selectedValue = val;
          });
          widget.onChanged(val);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty && widget.showLabelAbove) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: FontSizes.body,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
        GestureDetector(
          onTap: () => _openSelectModal(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: widget.fillColor ?? AppColors.background,
              borderRadius: borderRadius,
              border: Border.all(color: AppColors.neutral30),
            ),
            child: Row(
              children: [
                if (widget.prefixIcon != null) ...[
                  Icon(widget.prefixIcon, size: 20, color: theme.colorScheme.onSurface.withAlpha(150)),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    selectedValue != null
                        ? (widget.itemToString != null
                            ? widget.itemToString!(selectedValue as T)
                            : selectedValue.toString())
                        : (widget.hintText ?? 'Select an option'),
                    style: TextStyle(
                      fontSize: FontSizes.body,
                      color: selectedValue != null
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSurface.withAlpha(100),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.neutral70),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SelectModal<T> extends StatefulWidget {
  final List<T> items;
  final T? initialValue;
  final String Function(T)? itemToString;
  final bool isSearchable;
  final void Function(T?) onSelect;

  const _SelectModal({
    required this.items,
    required this.onSelect,
    this.itemToString,
    this.initialValue,
    this.isSearchable = false,
  });

  @override
  State<_SelectModal<T>> createState() => _SelectModalState<T>();
}

class _SelectModalState<T> extends State<_SelectModal<T>> {
  late List<T> filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      filteredItems = widget.items
          .where((item) => (widget.itemToString?.call(item) ?? item.toString())
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.isSearchable)
            const SizedBox(height: 8),
            CustomTextField(
              label: '',
              hint: 'Search...',
              controller: _searchController,
              isDense: true,
              contentPadding: const EdgeInsets.all(12),
            ),
          const SizedBox(height: 8),
          // Add a Fixed height for the modal body and wrap ListView with a SingleChildScrollView
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...filteredItems.map((item) {
                    final label = widget.itemToString?.call(item) ?? item.toString();
                    return ListTile(
                      title: Text(
                        label,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontSize: FontSizes.body,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        widget.onSelect(item);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}