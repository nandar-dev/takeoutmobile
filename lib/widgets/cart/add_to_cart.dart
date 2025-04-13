import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class AddToCart extends StatefulWidget {
  final int productId;
  final String name;
  final double price;
  final int stock;

  const AddToCart({
    super.key,
    required this.productId,
    required this.name,
    required this.price,
    required this.stock,
  });

  @override
  AddToCartState createState() => AddToCartState();
}

class AddToCartState extends State<AddToCart> {
  int _quantity = 0;
  String cartIcon = 'assets/icons/cart_icon.svg';

  void _increment() {
    if (_quantity < widget.stock) {
      setState(() {
        _quantity++;
      });
    }
  }

  void _decrement() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.price * _quantity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(icon: Icon(Icons.remove), onPressed: _decrement),
                SubText(
                  text: '$_quantity',
                  fontSize: FontSizes.heading3,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                IconButton(icon: Icon(Icons.add), onPressed: _increment),
              ],
            ),

            // Total Price
            TitleText(
              text: '\$${totalPrice.toStringAsFixed(2)}',
              fontSize: FontSizes.heading3,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        SizedBox(height: 8,),
        // Checkout Button
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            disabled: _quantity == 0,
            icon: Icons.shopping_cart_outlined,
            text: "Checkout",
            onPressed: () {
              debugPrint(
                "Proceeding to checkout with product id: ${widget.productId}",
              );
            },
          ),
        ),
      ],
    );
  }
}
