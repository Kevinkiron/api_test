part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchHome extends HomeEvent {}

class ProductFetch extends HomeEvent {
  final String id;
  final BuildContext context;
  const ProductFetch({required this.id, required this.context});

  @override
  List<Object> get props => [id, context];
}

class EditPrdouct extends HomeEvent {
  final String title;
  final String price;
  final String desc;
  final String id;
  final BuildContext context;
  const EditPrdouct(
      {required this.title,
      required this.desc,
      required this.price,
      required this.context,
      required this.id});

  @override
  List<Object> get props => [title, desc, price, id, context];
}
