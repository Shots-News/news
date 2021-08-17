// import 'dart:async';
// import 'dart:io';

// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:news/bloc/articals/articals_bloc.dart';
// import 'package:news/models/article_model.dart';
// import 'package:news/repository/artical_repo.dart';

// class ArticalsBloc extends HydratedBloc<ArticalsEvent, ArticalsState> {
//   final ArticalsRepository articalRepository;
//   late List<ArticalModel> articalList;

//   List<ArticalModel>? _list = [];

//   List<ArticalModel>? get data {
//     return [..._list!];
//   }

//   ArticalsBloc({required this.articalRepository}) : super(ArticalsInitial());

//   @override
//   Stream<ArticalsState> mapEventToState(ArticalsEvent event) async* {
//     switch (event) {
//       case ArticalsEvent.fetchArticals:
//         yield ArticalsLoading(artical: _list);
//         try {
//           articalList = await articalRepository.getArticalsList();
//           yield ArticalsLoaded(artical: articalList);
//         } on SocketException {
//           yield ArticalsError(error: 'No Internet');
//         } on HttpException {
//           yield ArticalsError(error: 'No Service');
//         } on FormatException {
//           yield ArticalsError(error: 'No Formate Exception');
//         } catch (e) {
//           print(e.toString());
//           yield ArticalsError(error: 'Un Known Error ${e.toString()}');
//         }
//         break;
//     }
//   }

//   @override
//   ArticalsState? fromJson(Map<String, dynamic> json) {
//     try {
//       final _articals = ArticalModel.fromJson(json);
//       print("*************** JSON: $json -------------------");
//       print("*************** Articals: $_articals -------------------");
//       // return ArticalsLoaded(artical: [_articals]);
//       return null;
//     } catch (_) {
//       return null;
//     }
//   }

//   @override
//   Map<String, dynamic>? toJson(ArticalsState state) {
//     // if (state is ArticalsLoaded) {
//     //   return state.artical.
//     // }
//   }
// }
