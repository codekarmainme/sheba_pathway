import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheba_pathway/provider/mapping_provider.dart';
import 'package:sheba_pathway/common/typography.dart';

class PlaceSearchDelegate extends SearchDelegate<String> {
  final bool isStartLocation;
  final bool
      isaddDestination; //to determine if the input clicked is fro added destination inputs
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
    final mappingProvider =
        Provider.of<MappingProvider>(context, listen: false);
    mappingProvider.fetchAutoCompleteResults(query, isStartLocation);

    return Consumer<MappingProvider>(
      builder: (context, locationProvider, child) {
        if (locationProvider.startautoCompleteResults.isEmpty &&
            locationProvider.destinationautoCompleteResults.isEmpty) {
          return Center(
            child: Text('No results found', style: normalText),
          );
        }

        final results = isStartLocation
            ? locationProvider.startautoCompleteResults
            : locationProvider.destinationautoCompleteResults;

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
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final mappingProvider =
        Provider.of<MappingProvider>(context, listen: false);
    // final localStorageProvider =
    //     Provider.of<LocalStorageProvider>(context, listen: false);
    if (query.isNotEmpty) {
      mappingProvider.fetchAutoCompleteResults(query, isStartLocation);
    }

    return Consumer<MappingProvider>(
      builder: (context, mappingProvider, child) {
        if (mappingProvider.startautoCompleteResults.isEmpty &&
            mappingProvider.destinationautoCompleteResults.isEmpty) {
          return Center(
            child: Text('No suggestions', style: normalText),
          );
        }

        final results = isStartLocation
            ? mappingProvider.startautoCompleteResults
            : mappingProvider.destinationautoCompleteResults;

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return ListTile(
              title: Text(result['name'], style: normalText),
              
              leading:Icon(FontAwesomeIcons.locationDot,size: 15,),
              onTap: () {
                final coordinates = extractCoordinates(result['coordinates']);
                print(coordinates);
                if (coordinates != null && isaddDestination == false) {
                  if (!isStartLocation &&
                      mappingProvider.selectedStartlocation != null &&
                      mappingProvider.selectedStartlocation!.isNotEmpty) {
                    final startCoordinates = mappingProvider
                        .selectedStartlocation![1]['coordinates'];
                    if (startCoordinates != null &&
                        startCoordinates[0] == coordinates[0] &&
                        startCoordinates[1] == coordinates[1]) {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   snackBarWidget(
                      //       context,
                      //       "Start and destination locations cannot be the same.",
                      //       errorColor),
                      // );
                      return;
                    }
                  }
                  isStartLocation
                      ? mappingProvider.setselectedStartlocation([
                          {
                            "name": result['name'],
                          },
                          {
                            "coordinates": coordinates,
                          },
                        ])
                      : mappingProvider.setselectedDestinationLocation([
                          {
                            "name": result['name'],
                          },
                          {
                            "coordinates": coordinates,
                          },
                        ]);
                  if (isStartLocation == false) {
                    Navigator.pop(context);
                  }
                  // localStorageProvider.addPlace(result['name'],
                  //     coordinates); //Storing the searched result to the local memory
                  query = result['name'];
                  showResults(context);
                } else if (coordinates != null && isaddDestination == true) {
                  mappingProvider.addSelectedDestination([
                    {
                      "name": result['name'],
                    },
                    {
                      "coordinates": coordinates,
                    },
                  ]);
                  // localStorageProvider.addPlace(result['name'],
                  //     coordinates); //Storing the searched result to the local memory

                  query = result['name'];
                  showResults(context);
                }
              },
            );
          },
        );
      },
    );
  }

  List<double>? extractCoordinates(dynamic coordinates) {
    if (coordinates is List) {
      if (coordinates.isNotEmpty) {
        if (coordinates[0] is List) {
          // Handle array of arrays
          if (coordinates[0].isNotEmpty && coordinates[0][0] is List) {
            // Handle array of array of arrays
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
