import 'package:news/news/data/data_source/news_api_data_source.dart';
import 'package:news/news/data/data_source/news_data_source.dart';
import 'package:news/sources/data/data_sources/data_source.dart';
import 'package:news/sources/data/data_sources/source_data_source.dart';

class ServiceLocator {
static Datasource source = SourceDataSource();
static NewsDataSource newsDataSource = NewsApiDataSource();

}