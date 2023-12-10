import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../common/components/row_text.dart';
import '../../../common/extensions/int_ext.dart';
import '../../../data/models/responses/buyer_order_response_model.dart';

import '../../../common/components/button.dart';
import '../../../common/components/spaces.dart';
import '../../../common/constants/colors.dart';
import '../manifest_delivery_page.dart';
import '../order_detail_page.dart';

class OrderItemCard extends StatelessWidget {
  final BuyerOrder buyerOrder;

  const OrderItemCard({super.key, required this.buyerOrder});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderDetailPage(
                    buyerOrder: buyerOrder,
                  )),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(color: ColorName.border),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NO RESI: ${buyerOrder.attributes.noResi}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Button.filled(
                  onPressed: () {
                    if (buyerOrder.attributes.noResi != "-") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManifestDeliveryPage(
                                  buyerOrder: buyerOrder,
                                )),
                      );
                    } else {
                      log('Tidak bisa melacak');
                    }
                  },
                  label: 'Lacak',
                  height: 20.0,
                  width: 94.0,
                  fontSize: 11.0,
                ),
              ],
            ),
            const SpaceHeight(24.0),
            GeneralRowText(
                label: 'Status', value: buyerOrder.attributes.status),
            const SpaceHeight(12.0),
            // RowText(label: 'Item', value: data.item),
            const SpaceHeight(12.0),
            GeneralRowText(
                label: 'Harga',
                value: buyerOrder.attributes.totalPrice.currencyFormatRp),
          ],
        ),
      ),
    );
  }
}
