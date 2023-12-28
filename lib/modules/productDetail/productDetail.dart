import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:usul/models/productModel.dart';
import 'package:usul/shared/components/components.dart';
import 'package:usul/shared/components/constanse.dart';
import 'package:usul/shared/cubit/cubit.dart';
import 'package:usul/shared/cubit/states.dart';
import 'package:usul/shared/network/local/util.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    final ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {},
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffffffff),
            title: Text(
              'التفاصيل',
              style: TextStyle(fontSize: 16, color: Color(0xff000000)),
            ),
             leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 300,
                        pauseAutoPlayOnTouch: true,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                      ),
                      items: productModel.image.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                imageUrl: i,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.blue, // Customize the color
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'المكان:  ${productModel.place}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        const Icon(
                          Icons.attach_money,
                          color: Colors.green, // Customize the color
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'السعر/متر:  ${productModel.price} دينار',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      ':التفاصيل',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                    Text(
                      productModel.classification,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14),
                      textDirection: TextDirection.rtl, // or TextDirection.ltr
                    ),
                    // Add some space between widgets

                    const SizedBox(height: 20),
                    // Add some space between widgets
                    defaultButton(
                      icon: FontAwesome.whatsapp,
                      function: () {
                        // Trigger WhatsApp with the message
                        Util.whatsapp(
                          phoneNumber: phoneNumber,
                          message: ' مرحبا... مهتم في هذا العقار',
                        );
                      },
                      text: 'تواصل',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
