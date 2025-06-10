import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sheba_pathway/models/travel_plan_model.dart';

class TravelPlansRepository {
  final CollectionReference _plansCollection =
      FirebaseFirestore.instance.collection('travel_plans');
  final user = FirebaseAuth.instance.currentUser;
  // Add a new trip plan
  Future<void> addTripPlan(TripPlanModel plan) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final userPlansCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('travel_plans');

    await userPlansCollection.add(plan.toJson());
  }

  // Retrieve all trip plans (as a stream for real-time updates)
  Stream<List<TripPlanModel>> getUserTravelPlans() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value([]);
    }
    final userPlansCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('travel_plans');

    return userPlansCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TripPlanModel.fromJson(
                  doc.data(),
                  id: doc.id,
                ))
            .toList());
  }

  // Retrieve all trip plans (one-time fetch)
  Future<List<TripPlanModel>> fetchTripPlansOnce() async {
    final snapshot = await _plansCollection
        .where('userId', isEqualTo: user?.uid)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => TripPlanModel.fromJson(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            ))
        .toList();
  }
}
