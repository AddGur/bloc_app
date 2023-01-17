import 'package:equatable/equatable.dart';

enum Units {
  kg,
  piece,
}

class CartModel extends Equatable {
  final String id;
  final String productName;
  final double quantity;
  final bool isCollected;
  final Units units;

  const CartModel({
    required this.id,
    required this.productName,
    required this.quantity,
    this.isCollected = false,
    required this.units,
  });

  CartModel copyWith(
      {String? id,
      String? productName,
      double? quantity,
      bool? isCollected,
      Units? units}) {
    return CartModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      units: units ?? this.units,
    );
  }

  @override
  List<Object?> get props => [id, productName, quantity, isCollected, units];
}
