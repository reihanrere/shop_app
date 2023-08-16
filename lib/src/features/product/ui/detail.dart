import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/src/features/product/cubit/product_cubit.dart';
import 'package:shop_app/src/helpers/injection.dart';
import 'package:shop_app/src/repositories/models/product/product_model.dart';
import 'package:shop_app/src/themes/themes.dart';

import '../../../repositories/repositories.dart';

class DetailFeature extends StatefulWidget {
  static String routeName = "detail";
  final ProductModel? productModel;

  DetailFeature({super.key, this.productModel});

  @override
  State<DetailFeature> createState() => _DetailFeatureState();
}

class _DetailFeatureState extends State<DetailFeature> {
  final cubit = locator<ProductCubit>();

  Widget content() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  widget.productModel!.image!.toString(),
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(
              bottom: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productModel!.title.toString(),
                  style: blackTextStyle.copyWith(
                    fontSize: 26,
                    fontWeight: bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.productModel!.price.toString(),
                  style: blackTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.productModel!.description.toString(),
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: light,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.productModel!.rating!.rate.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: light,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget navigationBack(context) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.only(top: 70, left: 16),
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0x000000).withOpacity(0.05),
              offset: Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 1,
            )
          ]),
      child: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
        ),
      ),
    );
  }

  Widget addCartButton(counter) {
    print(counter != 0);
    if (counter != 0) {
      return Container(
        width: 200,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            "Tambah ke Keranjang",
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }
    return Container(
      width: 200,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          "Tambah ke Keranjang",
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
      ),
    );
  }

  Widget bottomBar() {
    return BlocBuilder<ProductCubit, ProductState>(
      bloc: cubit,
      buildWhen: (previous, current) => previous.counter != current.counter,
      builder: (context, state) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 80,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: BorderDirectional(
                top: BorderSide(color: Colors.black12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: cubit.counterDecrement,
                          icon: Icon(
                            Icons.remove_circle,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          state.counter.toString(),
                          style: blackTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: cubit.counterIncrement,
                          icon: Icon(
                            Icons.add_circle,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cubit.addCartItem(CartItemModel(
                        products: widget.productModel,
                        quantity: state.counter));
                  },
                  child: addCartButton(state.counter),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          content(),
          navigationBack(context),
          bottomBar(),
        ],
      ),
    );
  }
}
