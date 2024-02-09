import 'package:bloc_project_test/domain/repository/product_repository.dart';
import 'package:bloc_project_test/featues/add_product_screen/cubit/product_cubit.dart';
import 'package:bloc_project_test/featues/add_product_screen/ui/product_form.dart';
import 'package:bloc_project_test/featues/sign_in/cubit/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCubit>(
      create: (_) => context.read<ProductCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Create product')),
        body: const Padding(
          padding: EdgeInsets.all(8),
          child: ProdcutForm(),
        ),
      ),
    );
  }
}
