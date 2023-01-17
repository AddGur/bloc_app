import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_firebase_bloc/bloc/cart_bloc/cart_bloc.dart';
import 'package:my_notes_firebase_bloc/models/cart_model.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late final TextEditingController _productController;
  late final TextEditingController _quantityController;
  int _groupValue = 1;
  Units units = Units.kg;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _productController,
              decoration: const InputDecoration(hintText: 'Product name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Quantity'),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text('kg'),
                Radio(
                  value: 1,
                  groupValue: _groupValue,
                  onChanged: (value) {
                    setState(() {
                      _groupValue = 1;
                      units = Units.kg;
                    });
                  },
                  activeColor: Colors.green,
                ),
                const Text('piece'),
                Radio(
                  value: 2,
                  groupValue: _groupValue,
                  onChanged: (value) {
                    setState(() {
                      _groupValue = 2;
                      units = Units.piece;
                    });
                  },
                  activeColor: Colors.green,
                )
              ],
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    var uuid = const Uuid().v1();
                    context.read<CartBloc>().add(
                          AddToCartEvent(
                            product: CartModel(
                                id: uuid,
                                productName: _productController.text,
                                quantity:
                                    double.parse(_quantityController.text),
                                units: units),
                          ),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text(
                          '${_productController.text} added to your cart',
                        ),
                      ),
                    );
                    _productController.clear();
                    _quantityController.clear();
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text('Add product'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
