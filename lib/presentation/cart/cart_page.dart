import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/components/button.dart';
import '../../common/components/row_text.dart';
import '../../common/components/spaces.dart';
import '../../common/constants/colors.dart';
import '../../common/extensions/int_ext.dart';
import '../../data/models/requests/order_request_model.dart';
import '../payment/page/payment_page.dart';
import 'bloc/cart_bloc/cart_bloc.dart';
import 'bloc/order_bloc/order_bloc.dart';
import 'widgets/cart_item_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Item> items = [];
  int allTotalPrice = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (carts) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SpaceHeight(16.0),
                    itemCount: carts.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        data: carts[index],
                      );
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(70.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(color: ColorName.border),
            ),
            child: Column(
              children: [
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return GeneralRowText(
                          label: 'Total Harga',
                          value: 0.currencyFormatRp,
                        );
                      },
                      loaded: (carts) {
                        int totalPrice = 0;
                        for (var element in carts) {
                          totalPrice +=
                              int.parse(element.product.attributes.price) *
                                  element.quantity;
                        }
                        return GeneralRowText(
                          label: 'Total Harga',
                          value: totalPrice.currencyFormatRp,
                        );
                      },
                    );
                    // return RowText(
                    //   label: 'Total Price',
                    //   value: 1750000.currencyFormatRp,
                    // );
                  },
                ),
                const SpaceHeight(12.0),
                const GeneralRowText(
                  label: 'Biaya Pengiriman',
                  value: "Bebas biaya pengiriman",
                ),
                const SpaceHeight(40.0),
                const Divider(color: ColorName.border),
                const SpaceHeight(12.0),
                BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                  return state.maybeWhen(loaded: (carts) {
                    int totalPriceCalculate = 0;

                    for (var element in carts) {
                      totalPriceCalculate +=
                          int.parse(element.product.attributes.price) *
                              element.quantity;
                    }
                    allTotalPrice = totalPriceCalculate;

                    items = carts
                        .map(
                          (e) => Item(
                            id: e.product.id,
                            productName: e.product.attributes.name,
                            qty: e.quantity,
                            price: int.parse(e.product.attributes.price),
                          ),
                        )
                        .toList();
                    return GeneralRowText(
                      label: 'Total Harga',
                      value: totalPriceCalculate.currencyFormatRp,
                      valueColor: ColorName.primary,
                      fontWeight: FontWeight.w700,
                    );
                  }, orElse: () {
                    return GeneralRowText(
                      label: 'Total Harga',
                      value: 0.currencyFormatRp,
                    );
                  });
                }),
                const SpaceHeight(16.0),
                BlocConsumer<OrderBloc, OrderState>(listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (response) {
                      context.read<CartBloc>().add(const CartEvent.started());
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return PaymentPage(
                          invoiceUrl: response.invoiceUrl,
                          orderId: response.externalId,
                        );
                      }));
                    },
                  );
                }, builder: (context, state) {
                  return state.maybeWhen(orElse: () {
                    return Button.filled(
                      onPressed: () {
                        var order = OrderRequestModel(
                          data: Data(
                            items: items,
                            totalPrice: allTotalPrice,
                            deliveryAddress: 'Jeparaloka, Jepara',
                            courierName: 'JNE',
                            courierPrice: 0,
                            status: 'waiting-payment',
                          ),
                        );
                        context.read<OrderBloc>().add(OrderEvent.order(order));
                      },
                      label: 'Bayar Sekarang',
                    );
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: ColorName.primary,
                      ),
                    );
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
