import 'package:flutter/material.dart';
import 'package:my_notes_firebase_bloc/bloc/cart_bloc/cart_bloc.dart';
import 'package:my_notes_firebase_bloc/models/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_firebase_bloc/screens/add_product.dart';
import 'package:my_notes_firebase_bloc/screens/edit_dialog_widget.dart';

import '../bloc/auth_bloc/auth_bloc.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLogged) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('List Screen'),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthEventLogOut());
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: BlocBuilder<CartBloc, CartState>(
              builder: (contextCart, stateCart) {
                if (stateCart is CartLoadded) {
                  return stateCart.cart.isEmpty
                      ? Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${state.user.name} your cart is empty, add product',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const AddButton(),
                              ]),
                        )
                      : Center(
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: stateCart.cart.length,
                                itemBuilder: (context, index) {
                                  return _productTile(
                                      product: stateCart.cart[index],
                                      context: context);
                                },
                              ),
                              const AddButton()
                            ],
                          ),
                        );
                } else {
                  return const Text('Something went wrong');
                }
              },
            ),
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddProduct(),
          ),
        );
      },
      child: const Text('Add product'),
    );
  }
}

Widget _productTile({
  required CartModel product,
  required BuildContext context,
}) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              product.productName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            Row(
              children: [
                Text(
                  product.units == Units.kg
                      ? '${product.quantity.toStringAsFixed(1)} ${product.units.name}'
                      : '${product.quantity.toStringAsFixed(0)} ${product.units.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => EditDialogWidget(
                        product: product,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<CartBloc>()
                        .add(RemoveFromCartEvent(product: product));
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ]),
        ),
      ));
}
