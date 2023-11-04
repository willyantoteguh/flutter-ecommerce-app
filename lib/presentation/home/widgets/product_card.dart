import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/common/extensions/int_ext.dart';

import '../../../common/components/spaces.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/variables.dart';
import '../../../data/models/responses/product_response_model.dart';
import '../../cart/bloc/bloc/cart_bloc.dart';
import '../../cart/widgets/cart_model.dart';
import '../../detail_product/detail_product_page.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailProductPage(
                    product: data,
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          boxShadow: [
            BoxShadow(
              color: ColorName.black.withOpacity(0.05),
              blurRadius: 7.0,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                '${Variables.baseUrl}${data.attributes.images.data.first.attributes.url}',
                width: 170.0,
                height: 112.0,
                fit: BoxFit.cover,
              ),
            ),
            const SpaceHeight(14.0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(data.attributes.name,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SpaceHeight(4.0),
                        Text(
                          int.parse(data.attributes.price).currencyFormatRp,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(CartEvent.add(
                              CartModel(product: data, quantity: 1)));
                        },
                        icon: const Icon(Icons.add)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
