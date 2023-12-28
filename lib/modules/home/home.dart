import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usul/models/productModel.dart';
import 'package:usul/shared/components/cardBuilder.dart';
import 'package:usul/shared/cubit/cubit.dart';
import 'package:usul/shared/cubit/states.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xffffffff),
              title: Text(
                'العقارات المتاحة',
                style: TextStyle(fontSize: 16, color: Color(0xff000000)),
              ),
              actions: [
                IconButton(
                    onPressed: () => Navigator.pushNamed(context, 'about'),
                    icon: const Icon(
                      Icons.question_mark_sharp,
                      color: Color(0xff000000),
                    ))
              ],
            ),
            body: (cubit.productsModel.isEmpty &&
                    state is! AppLoadingProductsStates)
                ? Center(
                    child: Text('لا يوجد عقارات ',
                        style: Theme.of(context).textTheme.displaySmall),
                  )
                : ConditionalBuilder(
                    builder: (context) =>
                        productBuilder(productModel: cubit.productsModel),
                    condition: state is AppSuccessProductsStates,
                    fallback: (BuildContext context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  ));
      },
    );
  }

  Widget productBuilder({required List<ProductModel?> productModel}) {
    return ListView.builder(
        itemCount: productModel.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return cardBuilder(
              context: context, productModel: productModel[index]);
        });
  }
}
