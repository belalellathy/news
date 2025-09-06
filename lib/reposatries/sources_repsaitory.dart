import 'package:news/sources/data/data_sources/data_source.dart';
import 'package:news/sources/data/models/sources_response/source.dart';



class SourcesRepository {
  final Datasource sourceDataSource;

  SourcesRepository(this.sourceDataSource);

  Future<List<Source>> getsources(String categoryId) async {
    return  sourceDataSource.getsources(categoryId);
  }

}