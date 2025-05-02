// import 'package:takeout/data/models/product_model.dart';

// abstract class ProductState {}

// class ProductInitial extends ProductState {}

// class ProductLoading extends ProductState {}

// class ProductLoaded extends ProductState {
//   final List<ProductModel> products;
//   ProductLoaded(this.products);
// }

// class ProductLoadingMore extends ProductState {
//   final List<ProductModel> products;
//   ProductLoadingMore(this.products);
// }

// class ProductError extends ProductState {
//   final String message;
//   ProductError(this.message);
// }

import 'package:takeout/data/models/product_model.dart';

abstract class ProductState {
  List<ProductModel> get products;
  bool get isLoading;
  bool get hasError;
  bool get canLoadMore;
}

class ProductInitial extends ProductState {
  @override
  final List<ProductModel> products = [];
  
  @override
  bool get isLoading => false;
  
  @override
  bool get hasError => false;
  
  @override
  bool get canLoadMore => false;
}

class ProductLoading extends ProductState {
  @override
  final List<ProductModel> products;
  
  ProductLoading([this.products = const []]);
  
  @override
  bool get isLoading => true;
  
  @override
  bool get hasError => false;
  
  @override
  bool get canLoadMore => false;
}

class ProductLoaded extends ProductState {
  @override
  final List<ProductModel> products;
  @override
  final bool canLoadMore;
  
  ProductLoaded(this.products, {this.canLoadMore = false});
  
  @override
  bool get isLoading => false;
  
  @override
  bool get hasError => false;
}

class ProductLoadingMore extends ProductState {
  @override
  final List<ProductModel> products;
  @override
  final bool canLoadMore;
  
  ProductLoadingMore(this.products, {this.canLoadMore = false});
  
  @override
  bool get isLoading => true;
  
  @override
  bool get hasError => false;
}

class ProductError extends ProductState {
  @override
  final List<ProductModel> products;
  final String message;
  
  ProductError(this.message, [this.products = const []]);
  
  @override
  bool get isLoading => false;
  
  @override
  bool get hasError => true;
  
  @override
  bool get canLoadMore => false;
}