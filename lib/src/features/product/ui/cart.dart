import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../themes/themes.dart';

class CartProductFeature extends StatelessWidget {
  static const String routeName = "cart-product";
  const CartProductFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Keranjang",
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
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 100,
                        margin: EdgeInsets.only(bottom: 5),
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product ${index + 1}",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: bold,
                                  ),
                                ),
                                Text(
                                  "Rp. 30.000",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 15,
                                    fontWeight: bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.pink,
                            ),
                            Text(
                              "Tambah",
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: bold,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
