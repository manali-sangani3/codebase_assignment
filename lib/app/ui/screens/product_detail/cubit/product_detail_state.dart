// part of 'product_detail_cubit.dart';
//
// abstract class ProductDetailState extends Equatable {
//   const ProductDetailState();
// }
//
// class FetchProductLoading extends ProductDetailState {
//   @override
//   List<Object> get props => [];
// }
//
// class ProductFound extends ProductDetailState {
//   final ProductDetailResponse detailResponse;
//
//   const ProductFound(this.detailResponse);
//
//   @override
//   List<Object> get props => [detailResponse];
// }
//
// class ProductNotFound extends ProductDetailState {
//   @override
//   List<Object> get props => [];
// }
//
// class CartCountUpdated extends ProductDetailState {
//   final int cartItemCount;
//   final int now;
//
//   const CartCountUpdated(this.cartItemCount, this.now);
//
//   @override
//   List<Object> get props => [cartItemCount, now];
// }
//
// class ProductImageLoaded extends ProductDetailState {
//   final List<String> sliderImage;
//
//   const ProductImageLoaded(this.sliderImage);
//
//   @override
//   List<Object> get props => [sliderImage];
// }
//
// class UpdateSliderIndex extends ProductDetailState{
//   final int activeIndex;
//
//   const UpdateSliderIndex(this.activeIndex);
//
//   @override
//   List<Object> get props => [activeIndex];
// }