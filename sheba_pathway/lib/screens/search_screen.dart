import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/location_selection/location_selection_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/location_selection/location_selection_event.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/fetchlocationsearchresult/bloc/fetchlocationsearchresult_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/fetchlocationsearchresult/bloc/fetchlocationsearchresult_event.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/fetchlocationsearchresult/bloc/fetchlocationsearchresult_state.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PlaceSearchDelegate extends SearchDelegate<String> {
  final bool isStartLocation;
  final bool isaddDestination;
  PlaceSearchDelegate(
      {required this.isStartLocation, this.isaddDestination = false});

  TextStyle get searchFieldStyle => normalText.copyWith(
        color: Colors.black,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: black3,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: black3,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      context.read<FetchlocationsearchresultBloc>().add(
            FetchAutoCompleteResults(query, isStartLocation),
          );
    }

    return BlocBuilder<FetchlocationsearchresultBloc,
        FetchlocationsearchresultState>(
      builder: (context, state) {
        if (state is FetchlocationsearchresultLoding) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FetchlocationsearchresultSuccess) {
          final results = state.results;
          if (results.isEmpty) {
            return Center(child: Text('No results found', style: normalText));
          }
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return ListTile(
                title: Text(result['name'], style: normalText),
                onTap: () {
                  close(context, result['name']);
                },
              );
            },
          );
        } else if (state is FetchlocationsearchresultError) {
          return Center(
              child: Text(state.errorMessage,
                  style: normalText.copyWith(color: errorColor)));
        }
        return Center(child: Text('No results found', style: normalText));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      context.read<FetchlocationsearchresultBloc>().add(
            FetchAutoCompleteResults(query, isStartLocation),
          );
    }

    return BlocBuilder<FetchlocationsearchresultBloc,
        FetchlocationsearchresultState>(
      builder: (context, state) {
        if (state is FetchlocationsearchresultLoding) {
          return Center(
              child: LoadingAnimationWidget.discreteCircle(
            color: successColor,
            secondRingColor: warningColor,
            thirdRingColor: errorColor,
            size: 40,
          ));
          ;
        } else if (state is FetchlocationsearchresultSuccess) {
          final results = state.results;
          if (results.isEmpty) {
            return Center(child: Text('No suggestions', style: normalText));
          }
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return ListTile(
                title: Text(result['name'], style: normalText),
                leading: Icon(FontAwesomeIcons.locationDot, size: 15),
                onTap: () {
                  final coordinates = extractCoordinates(result['coordinates']);
                  final location = {
                    'name': result['name'],
                    'coordinates': coordinates,
                  };

                  if (isStartLocation) {
                    context
                        .read<LocationSelectionBloc>()
                        .add(SetStartLocation(location));
                  } else {
                    context
                        .read<LocationSelectionBloc>()
                        .add(SetDestinationLocation(location));
                  }
                  close(context, result['name']);
                },
              );
            },
          );
        } else if (state is FetchlocationsearchresultError) {
          return Center(
              child: Text("Something went wrong",
                  style: normalText.copyWith(color: errorColor)));
        }
        return Center(child: Text('No suggestions', style: normalText));
      },
    );
  }

  List<double>? extractCoordinates(dynamic coordinates) {
    if (coordinates is List) {
      if (coordinates.isNotEmpty) {
        if (coordinates[0] is List) {
          if (coordinates[0].isNotEmpty && coordinates[0][0] is List) {
            if (coordinates[0][0].isNotEmpty &&
                coordinates[0][0][0] is double) {
              return [coordinates[0][0][1], coordinates[0][0][0]];
            }
          } else if (coordinates[0].isNotEmpty && coordinates[0][0] is double) {
            return [coordinates[0][1], coordinates[0][0]];
          }
        } else if (coordinates[0] is double) {
          return [coordinates[1], coordinates[0]];
        }
      }
    }
    return null;
  }
}
