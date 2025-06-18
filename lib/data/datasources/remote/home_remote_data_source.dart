import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/data/models/service_model.dart';

class HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSource(this.firestore);

  Future<List<ServiceModel>> fetchServices() async {
    final snapshot = await firestore.collection('services').get();
    return snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();
  }
}
