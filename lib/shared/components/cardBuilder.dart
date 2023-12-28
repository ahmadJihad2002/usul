import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:usul/models/productModel.dart';

Widget cardBuilder(
    {required BuildContext context, required ProductModel? productModel}) {
  return Padding(
    padding: const EdgeInsets.only(
        top: 8.0, right: kIsWeb ? 300 : 10.0, left: kIsWeb ? 300 : 10.0),
    child: InkWell(
      onTap: () {
        print('tapped');
        Navigator.pushNamed(context, 'ProductDetail', arguments: productModel);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CarouselSlider(
                options: CarouselOptions(
                    autoPlay: true,
                    height: 300,
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    autoPlayCurve: Curves.fastOutSlowIn),
                items: productModel?.image.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Stack(alignment: Alignment.center, children: [
                            SizedBox(
                              width: double.infinity,
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: i,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            BackdropFilter(
                              blendMode: BlendMode.srcOver,
                              filter:
                                  ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                              ),
                            ),
                            CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: i,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ]));
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("المدينة ",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 10),
                      Text(
                        productModel?.place ?? 'لا يوجد',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("السعر/متر ",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        productModel!.price.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("المساحة",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        productModel.space.toString() ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showToast({required String text, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.warning:
      color = Colors.amber;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;
  }

  return color;
}
