import 'package:flutter/material.dart';

class TripSearchDelegate extends SearchDelegate<String> {
  final List<String> trips;

  TripSearchDelegate(this.trips);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = trips
        .where((trip) => trip.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(child: Text('No trips found.'));
    }

    return ListView(
      children: results
          .map((trip) => ListTile(
                title: Text(trip),
                onTap: () => close(context, trip),
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = trips
        .where((trip) => trip.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: suggestions
          .map((trip) => ListTile(
                title: Text(trip),
                onTap: () {
                  query = trip;
                  showResults(context);
                },
              ))
          .toList(),
    );
  }
}