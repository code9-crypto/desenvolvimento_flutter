// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve_products.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReserveProducts on _ReserveProducts, Store {
  late final _$_ReserveProductsActionController =
      ActionController(name: '_ReserveProducts', context: context);

  @override
  void reservar(ProductData produto, String userID, BuildContext context) {
    final _$actionInfo = _$_ReserveProductsActionController.startAction(
        name: '_ReserveProducts.reservar');
    try {
      return super.reservar(produto, userID, context);
    } finally {
      _$_ReserveProductsActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
