// import 'package:flutter/material.dart';
// import 'package:flutter_base_project/app/ui/custom_widget/app_bar_mixin.dart';
// import 'package:flutter_base_project/app/ui/screens/product_detail/cubit/product_detail_cubit.dart';
// import 'package:flutter_base_project/config/app_colors.dart';
// import 'package:flutter_base_project/config/app_values.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../custom_widget/app_button_mixin.dart';
// import '../../custom_widget/product_slider.dart';
// import '../../shimmer_widgets/app_shimmer.dart';
//
// class ProductDetailScreen extends StatefulWidget
//     with AppButtonMixin, AppBarMixin {
//   final String productId;
//
//   ProductDetailScreen({required this.productId, super.key});
//
//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }
//
// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   @override
//   void initState() {
//     context.read<ProductDetailCubit>().getProductDetailById(widget.productId);
//     super.initState();
//   }
//
//   late TextTheme _textTheme;
//
//   @override
//   Widget build(BuildContext context) {
//     _textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       appBar: widget.buildAppBar(title: "Detail", context: context),
//       floatingActionButton: _buildFAB(),
//       body: _buildProductBody(),
//     );
//   }
//
//   /// Build add to cart FAB button
//   Widget _buildFAB() {
//     return BlocBuilder<ProductDetailCubit, ProductDetailState>(
//         buildWhen: (context, state) {
//       return state is CartCountUpdated;
//     }, builder: (context, state) {
//       if (state is CartCountUpdated) {
//         if (state.cartItemCount == 0) {
//           return _buildAddToCartFab();
//         } else {
//           return _buildItemInCart(state.cartItemCount);
//         }
//       }
//       return Container();
//     });
//   }
//
//   FloatingActionButton _buildAddToCartFab() => FloatingActionButton(
//       onPressed: () {
//         context.read<ProductDetailCubit>().addToCart(context);
//       },
//       child: const Icon(Icons.add_shopping_cart_outlined));
//
//   Widget _buildItemInCart(int count) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         FloatingActionButton.small(
//             onPressed: () =>
//                 context.read<ProductDetailCubit>().decreaseProductQty(context),
//             child: const Icon(Icons.remove)),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(count.toString()),
//         ),
//         FloatingActionButton.small(
//             onPressed: () =>
//                 context.read<ProductDetailCubit>().increaseProductQty(context),
//             child: const Icon(Icons.add)),
//       ],
//     );
//   }
//
//   /// Build product body widget.
//   Widget _buildProductBody() => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ProductSlider(),
//           _buildProductBrand,
//           _buildProductTitle,
//           _buildProductDescription
//         ],
//       );
//
//   /// Build product brand.
//   Widget get _buildProductBrand => Padding(
//         padding: const EdgeInsets.symmetric(
//             vertical: AppValues.padding_8, horizontal: AppValues.sideMargin),
//         child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
//             buildWhen: (context, state) => state is! CartCountUpdated,
//             builder: (context, state) {
//               if (state is ProductFound) {
//                 return Chip(
//                   avatar: const Icon(Icons.star, size: AppValues.size_16),
//                   padding: EdgeInsets.zero,
//                   visualDensity: VisualDensity.compact,
//                   elevation: 0,
//                   backgroundColor: Theme.of(context).highlightColor,
//                   label: Text(
//                     (state.detailResponse.brand ?? "").toUpperCase(),
//                     style: _textTheme.bodySmall,
//                   ),
//                 );
//               } else if (state is FetchProductLoading) {
//                 return AppShimmerWidget(
//                     child: Chip(
//                   avatar: const Icon(Icons.star, size: AppValues.size_16),
//                   padding: EdgeInsets.zero,
//                   visualDensity: VisualDensity.compact,
//                   label: Container(
//                     color: AppColors.shimmerLoadingColor,
//                     height: 16,
//                     width: 100,
//                   ),
//                 ));
//               }
//               return Container();
//             }),
//       );
//
//   /// Build product title.
//   Widget get _buildProductTitle => Padding(
//         padding: const EdgeInsets.symmetric(
//             vertical: AppValues.padding_4, horizontal: AppValues.sideMargin),
//         child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
//             buildWhen: (context, state) => state is! CartCountUpdated,
//             builder: (context, state) {
//               if (state is ProductFound) {
//                 return Text(
//                   state.detailResponse.title ?? "",
//                   style: _textTheme.headlineSmall,
//                 );
//               } else if (state is FetchProductLoading) {
//                 return AppShimmerWidget(
//                     child: Container(
//                   height: 24,
//                   width: 200,
//                   color: AppColors.shimmerLoadingColor,
//                 ));
//               }
//               return Container();
//             }),
//       );
//
//   /// Build product description.
//   Widget get _buildProductDescription => Padding(
//         padding: const EdgeInsets.symmetric(
//             vertical: AppValues.padding_10, horizontal: AppValues.sideMargin),
//         child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
//             buildWhen: (context, state) => state is! CartCountUpdated,
//             builder: (context, state) {
//               if (state is ProductFound) {
//                 return Text(
//                   state.detailResponse.description ?? "",
//                   style: _textTheme.bodyMedium,
//                 );
//               } else if (state is FetchProductLoading) {
//                 return Column(
//                   children: [
//                     AppShimmerWidget(
//                         child: Container(
//                       height: 16,
//                       width: double.infinity,
//                       color: AppColors.shimmerLoadingColor,
//                     )),
//                     const SizedBox(
//                       height: AppValues.size_4,
//                     ),
//                     AppShimmerWidget(
//                         child: Container(
//                       height: 16,
//                       width: double.infinity,
//                       color: AppColors.shimmerLoadingColor,
//                     )),
//                     const SizedBox(
//                       height: AppValues.size_4,
//                     ),
//                     AppShimmerWidget(
//                         child: Container(
//                       height: 16,
//                       width: double.infinity,
//                       color: AppColors.shimmerLoadingColor,
//                     )),
//                   ],
//                 );
//               }
//               return Container();
//             }),
//       );
// }
