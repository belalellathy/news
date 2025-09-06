import 'package:news/sources/data/models/sources_response/source.dart';


abstract class Datasource {

  Future<List<Source>> getsources(String categoryId);
}