import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/reposatries/sources_repsaitory.dart';
import 'package:news/shared/service_locator.dart';
import 'package:news/sources/view_model/sources_state.dart';


class SourcesViewModel extends Cubit<SourcesState> {
  SourcesViewModel() : super(SourcesInitial());

SourcesRepository sourcesRepository = SourcesRepository(ServiceLocator.source);

  Future<void> fetchSources(String categoryId) async {
    emit(SourcesLoading());
 
    try{
     final sources = await sourcesRepository.getsources(categoryId);
     emit(SourcesSuccess(sources));
     
    }
    catch(e){
      emit(SourcesFailure(e.toString()));
    }
   
  }
}