import 'package:flutter/material.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/render_custom_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    final emptyImage = "assets/images/empty_cart.png";
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            RenderCustomImage(imageUrl: emptyImage, height: 300),
            const SizedBox(height: 12),
            const TitleText(
              text: "Ouch! Cart is empty",
              fontSize: FontSizes.heading2,
            ),
            SizedBox(height: 10,),
            const SubText(
              text: "Seems like you haven't ordered any food yet",
              fontSize: FontSizes.md,
            ),
            SizedBox(height: 25,),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: "Find Foods",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.products);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
