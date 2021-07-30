import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/models/artical_model.dart';
import 'package:news/repository/artical_repo.dart';

part 'articals_event.dart';
part 'articals_state.dart';

class ArticalsBloc extends Bloc<ArticalsEvent, ArticalsState> {
  final ArticalsRepository articalRepository;
  late List<ArticalModel> articalList;

  List<ArticalModel>? _list = [];

  List<ArticalModel>? get data {
    return [..._list!];
  }

  // final Ticker ticker;
  // StreamSubscription? _subscription;

  ArticalsBloc({required this.articalRepository}) : super(ArticalsInitial());

  @override
  Stream<ArticalsState> mapEventToState(ArticalsEvent event) async* {
    switch (event) {
      case ArticalsEvent.fetchArticals:
        // await _subscription?.cancel();
        // _subscription = ticker.tick().listen((event) => add(ArticalsEvent.fetchArticals));
        yield ArticalsLoading(artical: _list);
        try {
          articalList = await articalRepository.getArticalsList();
          yield ArticalsLoaded(artical: articalList);
        } on SocketException {
          yield ArticalsError(error: 'No Internet');
        } on HttpException {
          yield ArticalsError(error: 'No Service');
        } on FormatException {
          yield ArticalsError(error: 'No Formate Exception');
        } catch (e) {
          print(e.toString());
          yield ArticalsError(error: 'Un Known Error ${e.toString()}');
        }
        break;
    }
  }

  // @override
  // Future<void> close() {
  //   _subscription?.cancel();
  //   return super.close();
  // }
}
