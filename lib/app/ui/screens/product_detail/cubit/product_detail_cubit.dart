// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_base_project/app/model/product_detail_response.dart';
// import 'package:flutter_base_project/config/app_strings.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../model/base_model.dart';
// import '../../../../repository/user_repository.dart';
//
// part 'product_detail_state.dart';
//
// class ProductDetailCubit extends Cubit<ProductDetailState> {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//   // Product repository.
//   UserRepository repository;
//
//   // Product quantity
//   int productQuantity = 0;
//
//   // Product Id of currently viewing product.
//   String productId = "";
//
//   // slider active index
//   int activeIndex = 0;
//
//   /// Product response
//   ProductDetailResponse? productDetailResponse;
//
//   ProductDetailCubit({
//     required this.repository,
//   }) : super(FetchProductLoading());
//
//   /// Fetch single product detail from product ID.
//   ///
//   /// required [productId] => product id.
//   void getProductDetailById(String productId) async {
//     this.productId = productId;
//     try {
//       emit(FetchProductLoading());
//       final response = await repository.getProductById(id: productId);
//       if (response is SuccessResponse) {
//         ProductDetailResponse? productDetailResponse = response.data;
//         if (productDetailResponse != null) {
//           this.productDetailResponse = productDetailResponse;
//           emit(ProductFound(productDetailResponse));
//           _getProductCountFromCart();
//         } else {
//           emit(ProductNotFound());
//         }
//       } else {
//         emit(ProductNotFound());
//       }
//     } catch (ex) {
//       emit(ProductNotFound());
//     }
//   }
//
//   /// Add product to cart.
//   void addToCart(BuildContext context) async {
//     productQuantity++;
//     _addProductToDb(context);
//   }
//
//   /// increase product qty.
//   void increaseProductQty(BuildContext context) async {
//     productQuantity++;
//     if (productQuantity <= 10) {
//       _addProductToDb(context);
//     } else {
//       var snackBar =
//           const SnackBar(content: Text(AppStrings.cartMaxItemWarningMessage));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }
//
//   /// decrease product qty.
//   void decreaseProductQty(BuildContext context) async {
//     productQuantity--;
//     if (productQuantity <= 0) {
//       await repository
//           .deleteProductFromCart(
//         productId: productId,
//       )
//           .then((value) {
//         context.read<CartCubit>().getCartProducts();
//         _getProductCountFromCart();
//       });
//     } else {
//       _addProductToDb(context);
//     }
//   }
//
//   /// Store product to local Db.
//   void _addProductToDb(BuildContext context) async {
//     final addProductResponse = await repository.addProductToCart(
//         productId: productId,
//         productName: productDetailResponse?.title ?? "",
//         productImage: productDetailResponse?.thumbnail ?? "",
//         quantity: productQuantity);
//     if (addProductResponse != -1) {
//       if (!context.mounted) return;
//       context.read<CartCubit>().getCartProducts();
//       _getProductCountFromCart();
//     }
//   }
//
//   /// Fetch product count from cart.
//   void _getProductCountFromCart() async {
//     productQuantity =
//         await repository.fetchProductQuantity(productId: productId);
//
//     emit(CartCountUpdated(
//         productQuantity, DateTime.now().millisecondsSinceEpoch));
//   }
//
//   void updateSliderIndex(int index) {
//     activeIndex = index;
//     emit(UpdateSliderIndex(activeIndex));
//   }
// }
