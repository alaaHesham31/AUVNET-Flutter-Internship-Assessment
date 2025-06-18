import '../../domain/entities/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel extends Service {
  ServiceModel({
    required String id,
    required String imageUrl,
    required String label,
    required String tag,
  }) : super(id: id, imageUrl: imageUrl, label: label, tag: tag);

  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ServiceModel(
      id: doc.id,
      imageUrl: data['imageUrl'] ?? '',
      label: data['label'] ?? '',
      tag: data['tag'] ?? '',
    );
  }
}
