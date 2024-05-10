import 'package:flutter/material.dart';

class TProductPriceText extends StatefulWidget {
  const TProductPriceText({
    super.key, 
    this.currentSign =' đ', 
    required this.price, 
    this.isLarge = false, 
    this.maxLines = 1, 
    this.lineThrough = false,
  });

  final String currentSign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  State<TProductPriceText> createState() => _TProductPriceTextState();
}

class _TProductPriceTextState extends State<TProductPriceText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.price + widget.currentSign,
      maxLines: widget.maxLines,
      overflow: TextOverflow.ellipsis,
      style: widget.isLarge
          ? Theme.of(context). textTheme.headlineMedium!.apply(decoration: widget.lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context) . textTheme.titleLarge!.apply(decoration: widget.lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
