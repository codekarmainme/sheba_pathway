import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheba_pathway/models/travel_plan_model.dart';

class TravelPlansRepository {
  final CollectionReference _plansCollection =
      FirebaseFirestore.instance.collection('travel_plans');

  // Add a new trip plan
  Future<void> addTripPlan(TripPlanModel plan) async {
    await _plansCollection.add(plan.toJson());
  }

  // Retrieve all trip plans (as a stream for real-time updates)
  Stream<List<TripPlanModel>> getTripPlans() {
    return _plansCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TripPlanModel.fromJson(doc.data() as Map<String, dynamic>, id: doc.id))
            .toList());
  }

  // Retrieve all trip plans (one-time fetch)
  Future<List<TripPlanModel>> fetchTripPlansOnce() async {
    final snapshot = await _plansCollection.orderBy('createdAt', descending: true).get();
    return snapshot.docs
        .map((doc) => TripPlanModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}