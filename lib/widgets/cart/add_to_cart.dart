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
  final int initialQuantity;
  final Product product;
  final bool isDetailPage;

  const AddToCart({
    super.key,
    this.initialQuantity = 0,
    required this.product,
    this.isDetailPage = false,
  });

  @override
  State<AddToCart> createState() => AddToCartState();
}

class AddToCartState extends State<AddToCart> {
  final String plusIcon = "assets/icons/plus_icon.svg";
  final String minusIcon = "assets/icons/minus_icon.svg";
  final String trashIcon = "assets/icons/trash_icon.svg";

  late int _quantity;
  bool _isAddingToCart = false;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  @override
  void didUpdateWidget(AddToCart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialQuantity != oldWidget.initialQuantity) {
      setState(() {
        _quantity = widget.initialQuantity;
      });
    }
  }

  void _updateQuantity(int newQty) {
    if (newQty < 0) return;
    if (newQty > widget.product.stock) {
      Snackbar.showError(context, 'Maximum stock reached!');
      return;
    }

    setState(() => _quantity = newQty);

    if (newQty == 0) {
      context.read<CartBloc>().add(RemoveCartItem(widget.product.id));
    } else {
      context.read<CartBloc>().add(UpdateItemQuantity(widget.product.id, newQty));
    }
  }

  void _handleAddToCart() {
    if (_quantity == 0 || widget.product.stock <= 0) return;

    setState(() => _isAddingToCart = true);

    final cartItem = {
      'productId': widget.product.id,
      'name': widget.product.name,
      'price': widget.product.price,
      'quantity': _quantity,
      'imageUrl': widget.product.imageUrl,
      'stock': widget.product.stock,
    };

    context.read<CartBloc>().add(AddToCartEvent(cartItem));

    Snackbar.showSuccess(context, '${widget.product.name} added to cart!');
    setState(() => _isAddingToCart = false);
  }

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = widget.product.stock <= 0;
    final totalPrice = widget.product.price * _quantity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isDetailPage && !isOutOfStock) ...[
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
                  onTap: (_quantity > 0 && !isOutOfStock)
                      ? () => _updateQuantity(_quantity - 1)
                      : (){},
                  iconColor: AppColors.neutral90,
                  iconSize: 30,
                  borderColor: widget.isDetailPage 
                      ? AppColors.neutral10 
                      : AppColors.neutral40,
                ),
                const SizedBox(width: 15),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: SubText(
                    key: ValueKey(_quantity),
                    text: isOutOfStock ? 'Out of stock' : '$_quantity',
                    fontSize: FontSizes.heading3,
                    fontWeight: FontWeight.bold,
                    color: isOutOfStock 
                        ? AppColors.danger 
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 15),
                IconButtonOneWidget(
                  buttonSize: 30,
                  icon: plusIcon,
                  onTap: !isOutOfStock 
                      ? () => _updateQuantity(_quantity + 1) 
                      : (){},
                  iconColor: AppColors.neutral90,
                  iconSize: 30,
                  borderColor: widget.isDetailPage 
                      ? AppColors.neutral10 
                      : AppColors.neutral40,
                ),
              ],
            ),
            if (!widget.isDetailPage)
              IconButtonOneWidget(
                icon: trashIcon,
                onTap: () => _updateQuantity(0),
                iconColor: AppColors.danger,
                iconSize: 17,
              ),
              if(widget.isDetailPage)
              TitleText(
                text: '\$${totalPrice.toStringAsFixed(2)}',
                fontSize: FontSizes.md,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              )
          ],
        ),
        if (widget.isDetailPage) const SizedBox(height: 20),
        if (widget.isDetailPage)
          SizedBox(
            width: double.infinity,
            child: CustomPrimaryButton(
              disabled: isOutOfStock || _quantity == 0 || _isAddingToCart,
              text: isOutOfStock
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