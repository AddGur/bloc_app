part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoadded extends CartState {
  final List<CartModel> cart;

  const CartLoadded({this.cart = const []});

  @override
  List<Object> get props => [cart];
}
