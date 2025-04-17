import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/cart/bloc.dart';
import 'package:takeout/bloc/cart/event.dart';
import 'package:takeout/bloc/cart/state.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/cart/add_to_cart.dart';
import 'package:takeout/widgets/buttons/iconbutton_one_widget.dart';
import 'package:takeout/widgets/buttons/iconbutton_two_widget.dart';
import 'package:takeout/widgets/product/related_products.dart';
import 'package:takeout/widgets/render_custom_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  ProductDetailState createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  bool isFav = false;
  int? favId;
  Map<String, dynamic>? existingItem;

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetCartItemById(widget.product.id));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenHeight * 0.5;

    return Scaffold(
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartItemLoaded) {
            setState(() {
              existingItem = state.item;
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: imageHeight,
                child: Stack(
                  children: [
                    RenderCustomImage(
                      imageUrl: widget.product.imageUrl,
                      width: screenWidth,
                      height: imageHeight,
                    ),
                    _buildTopButtons(context),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -20),
                child: _buildInfoOverlay(screenWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopButtons(BuildContext context) {
    const iconSize = 15.0;
    const heartOutlinedIcon = 'assets/icons/heart.svg';
    const heartFilledIcon = 'assets/icons/heart_fill.svg';
    const chevronLeftIcon = 'assets/icons/chevron_left.svg';
    final topPadding = MediaQuery.of(context).padding.top + 20;

    return Positioned(
      top: topPadding,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButtonOneWidget(
              iconSize: iconSize,
              icon: chevronLeftIcon,
              onTap: () => Navigator.pop(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:
                isFav && favId == widget.product.id
                    ? IconButtonTwoWidget(
                      bgColor: AppColors.background,
                      iconColor: AppColors.danger,
                      iconSize: iconSize,
                      icon: heartFilledIcon,
                      onTap: () {
                        setState(() {
                          isFav = false;
                          favId = null;
                        });
                      },
                    )
                    : IconButtonOneWidget(
                      iconSize: iconSize,
                      icon: heartOutlinedIcon,
                      onTap: () {
                        setState(() {
                          isFav = true;
                          favId = widget.product.id;
                        });
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoOverlay(double screenWidth) {
    final product = widget.product;
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            text: product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 8),
          ..._buildDetailText([
            product.shopName,
            product.categoryName,
            "Items in stock - ${product.stock}",
          ]),
          const SizedBox(height: 8),
          TitleText(
            text: '\$${product.price.toStringAsFixed(2)}',
            fontSize: FontSizes.heading3,
            color: AppColors.primary,
          ),
          const SizedBox(height: 12),
          SubText(
            text: "Description",
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          SubText(text: product.description, color: AppColors.neutral60),
          const SizedBox(height: 20),

          AddToCart(
            product: product,
            isDetailPage: true,
            initialQuantity: existingItem?['quantity'] ?? 0,
          ),

          const SizedBox(height: 20),
          RelatedProducts(productId: product.id),
        ],
      ),
    );
  }

  List<Widget> _buildDetailText(List<String> texts) {
    return texts
        .map(
          (text) => Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SubText(
              text: text,
              color: AppColors.neutral60,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
        .toList();
  }
}
