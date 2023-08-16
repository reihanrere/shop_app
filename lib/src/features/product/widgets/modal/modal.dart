import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/src/features/product/cubit/product_cubit.dart';
import 'package:shop_app/src/repositories/repositories.dart';
import 'package:shop_app/src/themes/themes.dart';

class Modal extends StatelessWidget {
  Modal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Kategori",
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              )
            ],
          ),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              print(state.productCategory);
              return Expanded(
                child: ListView.builder(
                  itemCount: state.productCategory!.length,
                  itemBuilder: (context, index) {
                    final productCategory = state.productCategory?[index];
                    return Container(
                      height: 60,
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: BorderDirectional(
                          bottom: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      child: Text(
                        productCategory.toString(),
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
