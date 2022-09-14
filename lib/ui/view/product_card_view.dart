import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../../model/product.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView(
      {Key? key,
      required this.product,
      this.imageAlignment = Alignment.bottomCenter,
      this.onTap})
      : super(key: key);

  final Product product;
  final Alignment imageAlignment;
  final Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    final priceValue = (product.price?.onSales ?? false)
        ? product.price?.discountedValue
        : product.price?.value;
    final crossedValue =
        (product.price?.onSales ?? false) ? product.price?.value : null;
    return GestureDetector(
      onTap: () => onTap?.call(product.objectID!),
      child: SizedBox(
        width: 150,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network('${product.image}',
                      alignment: imageAlignment, fit: BoxFit.cover)),
              if (product.price?.onSales == true)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(" ON SALE ${product.price?.discountLevel}% ",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.white,
                          backgroundColor: AppTheme.darkPink)),
                )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
              child: Text('${product.brand}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.caption)),
          SizedBox(
              child: Text('${product.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.bodyText2)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: ColorIndicatorView(product: product),
          ),
          Row(
            children: [
              Text('$priceValue €',
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.vividOrange)),
              if (crossedValue != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('$crossedValue €',
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(decoration: TextDecoration.lineThrough)),
                ),
            ],
          ),
          RatingView(
              value: product.reviews?.rating?.toInt() ?? 0,
              reviewsCount: product.reviews?.count?.toInt() ?? 0),
        ]),
      ),
    );
  }
}

class RatingView extends StatelessWidget {
  const RatingView({
    Key? key,
    this.value = 0,
    required this.reviewsCount,
    this.fontSize = 8,
    this.iconSize = 8,
    this.isExtended = false,
  }) : super(key: key);

  final int value;
  final int reviewsCount;
  final double fontSize;
  final double iconSize;
  final bool isExtended;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StarView(
          value: value,
          size: iconSize,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
              isExtended ? '($reviewsCount reviews)' : '($reviewsCount)',
              style: TextStyle(fontSize: fontSize)),
        )
      ],
    );
  }
}

class StarView extends StatelessWidget {
  const StarView({Key? key, this.value = 0, this.size = 8}) : super(key: key);

  final int value;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          size: size,
        );
      }),
    );
  }
}

class ColorIndicatorView extends StatelessWidget {
  const ColorIndicatorView({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final isMultiColor = product.color?.isMultiColor() ?? false;
    return Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: !isMultiColor
                ? Color(int.parse(product.color!.hexColor()!, radix: 16))
                : null,
            border: Border.all(
              width: 1,
              color: Colors.grey,
              style: BorderStyle.solid,
            ),
            image: isMultiColor
                ? const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/color_wheel.png'))
                : null));
  }
}
