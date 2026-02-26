

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class Newssucces extends NewsState {
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}
