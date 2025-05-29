
sealed class FetchlocationsearchresultState {}

class FetchlocationsearchresultInitial extends FetchlocationsearchresultState {}

class FetchlocationsearchresultLoding extends FetchlocationsearchresultState {}

class FetchlocationsearchresultSuccess extends FetchlocationsearchresultState {
final List<Map<String, dynamic>> results;
  FetchlocationsearchresultSuccess(this.results);
}

class FetchlocationsearchresultError extends FetchlocationsearchresultState {
  String errorMessage;
  FetchlocationsearchresultError(this.errorMessage);
}
