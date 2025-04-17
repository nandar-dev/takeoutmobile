import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/cart/bloc.dart';
import 'package:takeout/bloc/cart/event.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/iconbutton_one_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/snackbar.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class AddToCart extends StatefulWidget {
  final int? initialQuantity;
  final Product? product;
  final int? productId;
  final String? productName;
  final int? productStock;
  final double? productPrice;
  final bool? isDetailPage;

  const AddToCart({
    super.key,
    this.initialQuantity,
    this.product,
    this.productId,
    this.productName,
    this.productStock,
    this.productPrice,
    this.isDetailPage = false,
  });

  @override
  State<AddToCart> createState() => AddToCartState();
}

class AddToCartState extends State<AddToCart> {
  final String plusIcon = "assets/icons/plus_icon.svg";
  final String minusIcon = "assets/icons/minus_icon.svg";
  final String trashIcon = "assets/icons/trash_icon.svg";

  int _quantity = 0;
  bool _isAddingToCart = false;

  int get productId => widget.product?.id ?? widget.productId ?? -1;
  int get stock => widget.product?.stock ?? widget.productStock ?? 0;
  double get price => widget.product?.price ?? widget.productPrice ?? 0.0;
  String get name => widget.product?.name ?? widget.productName ?? "Item";
  String get imageUrl => widget.product?.imageUrl ?? "";
  bool get isDetailPage => widget.isDetailPage == true;
  bool get isOutOfStock => stock <= 0;
  double get totalPrice => price * _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity ?? 0;
  }

  void _updateQuantity(int newQty) {
    if (newQty < 0) return;
    if (newQty > stock) {
      Snackbar.showError(context, 'Maximum stock reached!');
      return;
    }

    setState(() => _quantity = newQty);

    if (newQty == 0) {
      context.read<CartBloc>().add(RemoveCartItem(productId));
    } else {
      context.read<CartBloc>().add(UpdateItemQuantity(productId, newQty));
    }
  }

  void _handleAddToCart() {
    if (_quantity == 0 || isOutOfStock) return;

    setState(() => _isAddingToCart = true);

    final cartItem = {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': _quantity,
      'imageUrl': imageUrl,
      'stock': stock,
    };

    context.read<CartBloc>().add(AddToCartEvent(cartItem));

    Snackbar.showSuccess(context, '$name added to cart!');
    setState(() {
      _isAddingToCart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isDetailPage && !isOutOfStock) ...[
          TitleText(
            text: '\$${totalPrice.toStringAsFixed(2)}',
            fontSize: FontSizes.md,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          const SizedBox(height: 10),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButtonOneWidget(
                  buttonSize: 30,
                  icon: minusIcon,
                  onTap:
                      (_quantity > 0 && !isOutOfStock)
                          ? () => _updateQuantity(_quantity - 1)
                          : () {},
                  iconColor: AppColors.neutral90,
                  iconSize: 30,
                  borderColor:
                      isDetailPage ? AppColors.neutral10 : AppColors.neutral40,
                ),
                const SizedBox(width: 15),
                SubText(
                  text: isOutOfStock ? 'Out of stock' : '$_quantity',
                  fontSize: FontSizes.heading3,
                  fontWeight: FontWeight.bold,
                  color:
                      isOutOfStock ? AppColors.danger : AppColors.textPrimary,
                ),
                const SizedBox(width: 15),
                IconButtonOneWidget(
                  buttonSize: 30,
                  icon: plusIcon,
                  onTap:
                      !isOutOfStock
                          ? () => _updateQuantity(_quantity + 1)
                          : () {},
                  iconColor: AppColors.neutral90,
                  iconSize: 30,
                  borderColor:
                      isDetailPage ? AppColors.neutral10 : AppColors.neutral40,
                ),
              ],
            ),
            Row(
              children: [
                if (isDetailPage && !isOutOfStock) ...[
                  TitleText(
                    text: '\$${totalPrice.toStringAsFixed(2)}',
                    fontSize: FontSizes.heading3,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 10),
                ],
                if (!isDetailPage)
                  IconButtonOneWidget(
                    icon: trashIcon,
                    onTap: () => _updateQuantity(0),
                    iconColor: AppColors.danger,
                    iconSize: 17,
                  ),
              ],
            ),
          ],
        ),
        if (isDetailPage) const SizedBox(height: 20),
        if (isDetailPage)
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              disabled: isOutOfStock || _quantity == 0 || _isAddingToCart,
              text:
                  isOutOfStock
                      ? "Out of Stock"
                      : (_isAddingToCart ? "Adding..." : "Add to Cart"),
              icon: isOutOfStock ? null : Icons.shopping_cart_outlined,
              onPressed: _handleAddToCart,
            ),
          ),
      ],
    );
  }
}
