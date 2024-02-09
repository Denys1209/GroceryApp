import 'dart:io';

import 'package:bloc_project_test/core/Constants/Constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bloc_project_test/featues/add_product_screen/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ProdcutForm extends StatelessWidget {
  const ProdcutForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, Constants.homePageRount);
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Add Product failed')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PhotoInputFrame(),
              const SizedBox(height: 8),
              _NameInput(),
              const SizedBox(height: 8),
              _DescriptionInput(),
              const SizedBox(height: 8),
              _PriceInput(),
              const SizedBox(height: 8),
              const _submitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          onChanged: (name) => context.read<ProductCubit>().emitName(name),
          decoration: const InputDecoration(
            labelText: 'name',
          ),
        );
      },
    );
  }
}

class _PriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) => previous.price != current.price,
      builder: (context, state) {
        return TextField(
          onChanged: (price) =>
              context.read<ProductCubit>().emitPrice(double.parse(price)),
          decoration: const InputDecoration(
            labelText: 'price',
          ),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextField(
          onChanged: (description) =>
              context.read<ProductCubit>().emitDescription(description),
          decoration: const InputDecoration(
            labelText: 'description',
          ),
        );
      },
    );
  }
}

class _submitButton extends StatelessWidget {
  const _submitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFFFFD600),
                ),
                onPressed: state.isValid
                    ? () => context.read<ProductCubit>().productSubmitForm()
                    : null,
                child: const Text('Submit'),
              );
      },
    );
  }
}

class _PhotoInputFrame extends StatelessWidget {
  _getFromGallery(ProductCubit productCubit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path).readAsBytesSync();
      productCubit.emitImage(file);
    }
  }

  void _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return SimpleDialog(
              title: const Text('select source'),
              children: [
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text("select from gallery"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _getFromGallery(context.read<ProductCubit>());
                  },
                ),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text("cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: state.image == null
                  ? BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: Colors.grey,
                      ),
                    )
                  : BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(state.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                iconSize: 27,
                icon: const Icon(Icons.add_a_photo),
                onPressed: () {
                  _selectImage(context);
                },
              ),
            )
          ],
        );
      },
    );
  }
}
