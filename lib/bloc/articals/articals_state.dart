part of 'articals_bloc.dart';

abstract class ArticalsState extends Equatable {
  const ArticalsState();

  @override
  List<Object> get props => [];
}

class ArticalsInitial extends ArticalsState {}

class ArticalsLoading extends ArticalsState {
  final List<ArticalModel>? artical;

  ArticalsLoading({required this.artical});
}

class ArticalsLoaded extends ArticalsState {
  final List<ArticalModel> artical;

  ArticalsLoaded({required this.artical});
}

class ArticalsError extends ArticalsState {
  final error;

  ArticalsError({this.error});
}
