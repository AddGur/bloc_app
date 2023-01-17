part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {
  final List<CartModel> cart;

  const LoadCartEvent({this.cart = const []});
  @override
  List<Object> get props => [cart];
}

class AddToCartEvent extends CartEvent {
  final CartModel product;

  const AddToCartEvent({required this.product});
  @override
  List<Object> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final CartModel product;

  const RemoveFromCartEvent({required this.product});
  @override
  List<Object> get props => [product];
}

class UpdateCartEvent extends CartEvent {
  final CartModel product;

  const UpdateCartEvent({required this.product});
  @override
  List<Object> get props => [product];
}
