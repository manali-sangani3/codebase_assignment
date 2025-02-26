// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../config/app_colors.dart';
// import '../../../config/app_values.dart';
// import '../screens/product_detail/cubit/product_detail_cubit.dart';
// import '../shimmer_widgets/app_shimmer.dart';
// import 'image_widget.dart';
//
// class ProductSlider extends StatefulWidget {
//   const ProductSlider({super.key});
//
//   @override
//   State<ProductSlider> createState() => _ProductSliderState();
// }
//
// class _ProductSliderState extends State<ProductSlider> {
//   final _controller = PageController(
//     initialPage: 0,
//   );
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   late TextTheme _textTheme;
//
//   @override
//   Widget build(BuildContext context) {
//     _textTheme = Theme.of(context).textTheme;
//
//     return Container(
//       height: AppValues.productSliderHeight,
//       width: double.infinity,
//       color: Theme.of(context).dividerColor,
//       child: Stack(
//         children: [
//           _buildPagedViewSlider(),
//           Positioned(
//               right: AppValues.sideMargin,
//               bottom: AppValues.padding_4,
//               child: _buildProductCategory),
//           Positioned(
//             bottom: 8,
//             left: 12,
//             child: _buildIndicatorWidget(),
//           )
//         ],
//       ),
//     );
//   }
//
//   /// Build indicator widget
//   Widget _buildIndicatorWidget() {
//     return BlocBuilder<ProductDetailCubit, ProductDetailState>(
//       buildWhen: (_, state) =>
//           (state is UpdateSliderIndex) || (state is ProductImageLoaded),
//       builder: (context, state) {
//         int selectedIndex = 0;
//         int totalImageCount = 0;
//         if (state is UpdateSliderIndex) {
//           selectedIndex = state.activeIndex;
//         }
//
//         if (state is ProductImageLoaded) {
//           totalImageCount = state.sliderImage.length;
//         }
//         return Container(
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(50)),
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: _buildPageIndicator(selectedIndex, totalImageCount),
//           ),
//         );
//       },
//     );
//   }
//
//   /// Build paged view slider.
//   Widget _buildPagedViewSlider() =>
//       BlocBuilder<ProductDetailCubit, ProductDetailState>(
//           buildWhen: (context, state) => (state is! CartCountUpdated),
//           builder: (context, state) {
//             if (state is ProductFound) {
//               if ((state.detailResponse.images ?? []).isNotEmpty) {
//                 return PageView.builder(
//                     controller: _controller,
//                     onPageChanged: (int page) {
//                       context
//                           .read<ProductDetailCubit>()
//                           .updateSliderIndex(page);
//                     },
//                     itemCount: state.detailResponse.images?.length,
//                     itemBuilder: (_, index) {
//                       return ImageWidget(
//                         imageURL: state.detailResponse.images![index],
//                         fit: BoxFit.cover,
//                       );
//                     });
//               }
//             } else if (state is FetchProductLoading) {
//               return AppShimmerWidget(
//                   child: Container(
//                 color: AppColors.shimmerLoadingColor,
//                 height: AppValues.productSliderHeight,
//                 width: double.infinity,
//               ));
//             }
//             return Container();
//           });
//
//   List<Widget> _buildPageIndicator(int selectedIndex, int totalCount) {
//     List<Widget> list = [];
//     for (int i = 0; i < totalCount; i++) {
//       list.add(i == selectedIndex ? _indicator(true) : _indicator(false));
//     }
//     return list;
//   }
//
//   /// Build product category.
//   Widget get _buildProductCategory =>
//       BlocBuilder<ProductDetailCubit, ProductDetailState>(
//           buildWhen: (context, state) => state is! CartCountUpdated,
//           builder: (context, state) {
//             if (state is ProductFound) {
//               return Chip(
//                 avatar: const Icon(Icons.business_center_outlined,
//                     size: AppValues.size_16),
//                 padding: EdgeInsets.zero,
//                 elevation: 4,
//                 visualDensity: VisualDensity.compact,
//                 label: Text(
//                   (state.detailResponse.category ?? "").toUpperCase(),
//                   style: _textTheme.bodyMedium,
//                 ),
//               );
//             } else if (state is FetchProductLoading) {
//               return AppShimmerWidget(
//                   child: Container(
//                 height: 34,
//                 width: 70,
//                 color: AppColors.shimmerLoadingColor,
//               ));
//             }
//             return Container();
//           });
//
//   Widget _indicator(bool isActive) {
//     return SizedBox(
//       height: 6,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         margin: const EdgeInsets.symmetric(horizontal: 4.0),
//         height: isActive ? 6 : 6.0,
//         width: isActive ? 8 : 6.0,
//         decoration: BoxDecoration(
//           boxShadow: [
//             isActive
//                 ? BoxShadow(
//                     color: AppColors.colorSecondary.withOpacity(0.72),
//                   )
//                 : const BoxShadow(
//                     color: Colors.transparent,
//                   )
//           ],
//           shape: BoxShape.circle,
//           color: isActive ? AppColors.colorSecondary : const Color(0XFFEAEAEA),
//         ),
//       ),
//     );
//   }
// }
