import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalog_cart_app/core/extension.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../core/text_styles.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/custom_list_tile.dart';
import '../../../shared/models/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final String uom;
  final bool isCart;
  final int? index;

  const ProductItem({super.key, required this.product, required this.uom, this.isCart = false, this.index});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              isCart
                  ? Text(
                      "$index. ",
                      style: AppTextStyles.bodySmallBold,
                    )
                  : const SizedBox(),
              Text(
                product.sku ?? '',
                style: AppTextStyles.bodySmallRegular.copyWith(color: grey9B9B9B),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                  product.inStock == true
                      ? ("${product.stockQuantity != null ? product.stockQuantity.toString() : ''} In Stock")
                      : "Out of Stock",
                  style: TextStyle(color: green02A340, fontSize: 12)),
            ],
          ),
          Text(
            product.name ?? '',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            toRM(
                product.variations
                    ?.where((element) => element.uom == (uom.isNotEmpty ? uom : product.variations?.firstOrNull?.uom))
                    .firstOrNull
                    ?.regularPrice,
                rm: true,
                decimal: true),
            style: AppTextStyles.bodyBold,
          ),
        ],
      ),
      trailing: CachedNetworkImage(
        imageUrl: product.images?.firstOrNull?.src ?? placeholderImageUrl,
        height: isCart ? context.screenHeight * 0.08 : context.screenHeight * 0.1,
        width: isCart ? context.screenHeight * 0.08 : context.screenHeight * 0.1,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: const Icon(Icons.error_outline),
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
