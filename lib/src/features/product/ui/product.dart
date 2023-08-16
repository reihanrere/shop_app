import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/src/features/product/cubit/product_cubit.dart';
import 'package:shop_app/src/features/product/ui/cart.dart';
import 'package:shop_app/src/features/product/ui/detail.dart';
import 'package:shop_app/src/features/product/ui/search_product.dart';
import 'package:shop_app/src/helpers/helper.dart';
import 'package:shop_app/src/themes/themes.dart';
import '../widgets/modal/modal.dart';
import '../../../repositories/repositories.dart';

class ProductFeature extends StatefulWidget {
  static const String routeName = "product";
  const ProductFeature({super.key});

  @override
  State<ProductFeature> createState() => _ProductFeatureState();
}

class _ProductFeatureState extends State<ProductFeature> {
  final cubit = locator<ProductCubit>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getAllData();
    cubit.getAllCategoryData();
  }

  Widget colorCategory(string) {
    print(string);
    return BlocBuilder<ProductCubit, ProductState>(
      bloc: cubit,
      builder: (context, state) {
        print(state.category);
        if (state.category == string) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              string.toUpperCase(),
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
                color: Colors.white,
              ),
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              string.toUpperCase(),
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HelloWorld Shop",
          style: blackTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: BorderDirectional(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Modal(),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.grid_view_outlined),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            child: BlocBuilder<ProductCubit, ProductState>(
                              bloc: cubit,
                              builder: (context, state) {
                                if (state.productCategory != null &&
                                    state.productCategory!.isNotEmpty) {
                                  return Row(
                                    children:
                                        state.productCategory!.map((category) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: GestureDetector(
                                          onTap: () {
                                            cubit.categoryString(category);
                                            cubit.getAllData(
                                                category: category);
                                          },
                                          child: colorCategory(category),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                } else {
                                  return Text("No categories available");
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: IconButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(SearchProductFeature.routeName);
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ProductCubit, ProductState>(
                  bloc: cubit,
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    if (state.productList == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state.productList != null) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.productList?.length,
                          itemBuilder: (context, index) {
                            final productList = state.productList?[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //   width: double.infinity,
                                //   padding: EdgeInsets.symmetric(
                                //     vertical: 10,
                                //     horizontal: 16,
                                //   ),
                                //   decoration: BoxDecoration(
                                //       border: BorderDirectional(
                                //           bottom: BorderSide(
                                //               color: Colors.grey.shade300))),
                                //   child: Text(
                                //     "Kategori",
                                //     style: blackTextStyle.copyWith(
                                //       fontSize: 18,
                                //       fontWeight: bold,
                                //     ),
                                //   ),
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    final productDetail =
                                        state.productList?[index];
                                    print(productDetail);
                                    GoRouter.of(context).pushNamed(
                                      DetailFeature.routeName,
                                      extra: productDetail,
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 150,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: BorderDirectional(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                productList!.image.toString(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    productList!.title
                                                        .toString(),
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 20,
                                                      fontWeight: bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "\$ ${productList!.price.toString()}",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.add_circle,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                    return SizedBox();
                  },
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).pushNamed(CartProductFeature.routeName);
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  right: 25,
                  left: 25,
                  bottom: 25,
                ),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.card_travel,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Keranjang",
                        style: whiteTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                          child: Text(
                            "1",
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
