import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/src/features/product/cubit/product_cubit.dart';
import 'package:shop_app/src/helpers/helper.dart';
import 'package:shop_app/src/repositories/models/product/product_model.dart';

import '../../../themes/themes.dart';
import 'detail.dart';

class SearchProductFeature extends StatefulWidget {
  static const String routeName = "search-product";

  const SearchProductFeature({super.key});

  @override
  State<SearchProductFeature> createState() => _SearchProductFeatureState();
}

class _SearchProductFeatureState extends State<SearchProductFeature> {
  final cubit = locator<ProductCubit>();
  TextEditingController _searchController = TextEditingController();

  void _handleSearch(String keyword) {
    if (keyword.isNotEmpty) {
      cubit.getSearchAllData(keyword);
    } else {
      cubit.getAllData();
    }
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
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: _handleSearch,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  suffix: GestureDetector(
                    onTap: () => GoRouter.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: blackTextStyle.copyWith(color: Colors.red),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // Atur warna sesuai keinginan
                  ),
                  prefixIconColor: Colors.grey,
                ),
              ),
            ),
            BlocBuilder<ProductCubit, ProductState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state.searchProductList == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.searchProductList != null &&
                    _searchController.text != '') {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.searchProductList!.length,
                      itemBuilder: (context, index) {
                        final searchData = state.searchProductList?[index];
                        return GestureDetector(
                          onTap: () {
                            final productDetail =
                                state.searchProductList?[index];
                            print(productDetail);
                            GoRouter.of(context).pushNamed(
                              DetailFeature.routeName,
                              extra: productDetail,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            margin: EdgeInsets.only(bottom: 5),
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        searchData!.image.toString(),
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchData!.title.toString(),
                                        style: blackTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "\$ ${searchData.price}",
                                        style: blackTextStyle.copyWith(
                                          fontSize: 15,
                                          fontWeight: bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
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
    );
  }
}
