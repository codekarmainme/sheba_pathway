import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/fetchlocationsearchresult/bloc/fetchlocationsearchresult_event.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/fetchlocationsearchresult/bloc/fetchlocationsearchresult_state.dart';
import 'package:sheba_pathway/repository/mapping_repository.dart';


class FetchlocationsearchresultBloc extends Bloc<FetchlocationsearchresultEvent, FetchlocationsearchresultState> {
  final MappingRepository mappingRepository;
  FetchlocationsearchresultBloc( this.mappingRepository) : super(FetchlocationsearchresultInitial()) {
      on<FetchAutoCompleteResults>((event, emit) async {
  emit(FetchlocationsearchresultLoding());
  try {
    final results = await mappingRepository.fetchAutoCompleteResults(
      event.query,
      event.isStartLocation,
    );
    emit(FetchlocationsearchresultSuccess( results));
  } catch (e) {
    emit(FetchlocationsearchresultError( e.toString()));
  }
});
  }
}
