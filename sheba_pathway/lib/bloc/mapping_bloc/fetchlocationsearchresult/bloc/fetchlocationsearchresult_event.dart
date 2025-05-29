import 'package:equatable/equatable.dart';

abstract class FetchlocationsearchresultEvent extends Equatable {
 @override
  List<Object?> get props =>[];
}
class FetchAutoCompleteResults extends FetchlocationsearchresultEvent {
  final String query;
  final bool isStartLocation;
  FetchAutoCompleteResults(this.query, this.isStartLocation);
  @override
  List<Object?> get props => [query, isStartLocation];
}