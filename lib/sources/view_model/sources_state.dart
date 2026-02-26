import 'package:news/sources/data/models/sources_response/source.dart';

abstract class SourcesState {}
class SourcesInitial extends SourcesState {}
class SourcesLoading extends SourcesState {}
class SourcesSuccess extends SourcesState {
  final List<Source> sources;
  SourcesSuccess(this.sources);
}
class SourcesFailure extends SourcesState {
  final String error;
  SourcesFailure(this.error);
}