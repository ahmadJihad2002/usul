import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:usul/models/productModel.dart';
import 'package:usul/shared/components/constanse.dart';
import 'package:usul/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  List<ProductModel?> productsModel = [];

  Future<void> getHomeData() async {
    emit(AppLoadingProductsStates());
    productsModel.clear();
    final querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    // Create a list to hold the futures for each product's image URLs
    if (querySnapshot.docs.isEmpty) {
      emit(AppSuccessProductsStates());
    } else {
      try {
        querySnapshot.docs.forEach((doc) async {
          ProductModel productData =
              await ProductModel.fromJson(doc.data(), docId: doc.id);

          List<Future<String>> imageUrlFutures =
              await productData.image.map((imageName) {
            return getImageUrl(
                imageName); // getImageUrl returns a Future<String>
          }).toList();
          List<String> updatedImageUrls = await Future.wait(imageUrlFutures);
          productData.image
              .replaceRange(0, productData.image.length, updatedImageUrls);

          // Add all the image URL futures to the imageUrlFutures list

          productsModel.add(productData);
          print(productData.image);

          emit(AppSuccessProductsStates());
        });

      } catch (error, stackTrace) {
        emit(AppErrorProductsStates());
        print('Stack Trace: $stackTrace');
        print('Error fetching document from Firestore: $error');
      }
    }
  }

  Future<void> getAdminData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc('7Kw0zmMjrpfMvHoGfBoI')
        .get()
        .then((value) => phoneNumber = value['phoneNumber'] as String);
  }

  Future<String> getImageUrl(String imageName) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('/pictures/$imageName');

    try {
      String downloadURL = await storageReference.getDownloadURL();

      return downloadURL;
    } catch (error) {
      print('Error getting image URL: $error');
      return ''; // Return an empty string or handle the error
    }
  }
}
