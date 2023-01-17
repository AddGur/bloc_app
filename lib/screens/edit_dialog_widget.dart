import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_firebase_bloc/bloc/cart_bloc/cart_bloc.dart';
import 'package:my_notes_firebase_bloc/models/cart_model.dart';

class EditDialogWidget extends StatefulWidget {
  final CartModel product;
  const EditDialogWidget({
    super.key,
    required this.product,
  });

  @override
  State<EditDialogWidget> createState() => _EditDialogWidgetState();
}

class _EditDialogWidgetState extends State<EditDialogWidget> {
  late TextEditingController _productController;
  late TextEditingController _quantityController;

  bool isCleared = false;
  @override
  void initState() {
    _productController = TextEditingController();
    _quantityController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _productController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Edit product')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _productController..text = widget.product.productName,
            decoration: const InputDecoration(labelText: 'Product name'),
          ),
          TextField(
            controller: _quantityController
              ..text = widget.product.quantity.toString(),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              context.read<CartBloc>().add(
                    UpdateCartEvent(
                      product: widget.product.copyWith(
                        productName: _productController.text,
                        quantity: double.parse(_quantityController.text),
                      ),
                    ),
                  );
              Navigator.pop(context);
            },
            child: const Text('Change')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
      ],
    );
  }
}
