import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_notes_firebase_bloc/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCartEvent>(_loadCart);
    on<AddToCartEvent>(_addCart);
    on<RemoveFromCartEvent>(_removeCart);
    on<UpdateCartEvent>(_updateCart);
  }

  void _loadCart(LoadCartEvent event, Emitter<CartState> emit) {
    emit(CartLoadded(cart: event.cart));
  }

  void _addCart(AddToCartEvent event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoadded) {
      emit(CartLoadded(cart: List.from(state.cart)..add(event.product)));
    }
  }

  void _removeCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoadded) {
      var cart = state.cart
          .where((element) => element.id != event.product.id)
          .toList();
      emit(CartLoadded(cart: cart));
    }
  }

  void _updateCart(UpdateCartEvent event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoadded) {
      List<CartModel> cart = (state.cart.map((product) {
        return product.id == event.product.id ? event.product : product;
      })).toList();
      emit(CartLoadded(cart: cart));
    }
  }
}
