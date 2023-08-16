import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/src/features/product/ui/product.dart';
import 'package:shop_app/src/helpers/helper.dart';
import 'package:shop_app/src/themes/themes.dart';

class HomeFeature extends StatelessWidget {
  static String routeName = "/";
  HomeFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            color: Colors.grey.shade300,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      margin: EdgeInsets.only(top: 240),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x000000).withOpacity(0.05),
                            offset: Offset(0, 0),
                            blurRadius: 5,
                            spreadRadius: 10,
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Text(
                            "HelloWorld Shop",
                            style: blackTextStyle.copyWith(
                              fontSize: 22,
                              fontWeight: bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Jl. Cinere Raya No.1001",
                                style: blackTextStyle.copyWith(
                                    fontSize: 16, fontWeight: light),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_sharp,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Setiap hari  (08:00-22:00)",
                                style: blackTextStyle.copyWith(
                                    fontSize: 16, fontWeight: light),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 3),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x000000).withOpacity(0.05),
                            offset: Offset(0, 0),
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "HelloWorld Shop",
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: light,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context)
                            .pushNamed(ProductFeature.routeName);
                      },
                      child: Container(
                        width: 171,
                        height: 100,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x000000).withOpacity(0.05),
                              offset: Offset(0, 0),
                              blurRadius: 5,
                              spreadRadius: 1,
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.food_bank_outlined,
                              size: 50,
                            ),
                            Text(
                              "Ambil di Tempat",
                              style: blackTextStyle.copyWith(
                                fontWeight: light,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context)
                            .pushNamed(ProductFeature.routeName);
                      },
                      child: Container(
                        width: 171,
                        height: 100,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x000000).withOpacity(0.05),
                              offset: Offset(0, 0),
                              blurRadius: 5,
                              spreadRadius: 1,
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.dinner_dining_sharp,
                              size: 50,
                            ),
                            Text(
                              "Makan di Tempat",
                              style: blackTextStyle.copyWith(
                                fontWeight: light,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
