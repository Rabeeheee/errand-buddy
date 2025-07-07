import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/escalation.dart';

class EscalationModel extends Escalation {
  const EscalationModel({
    required super.id,
    required super.taskId,
    required super.taskTitle,
    required super.assignedTo,
    required super.assignedToName,
    required super.escalatedAt,
    required super.reason,
    required super.isResolved,
    super.resolvedAt,
  });
  
  factory EscalationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EscalationModel(
      id: doc.id,
      taskId: data['taskId'] ?? '',
      taskTitle: data['taskTitle'] ?? '',
      assignedTo: data['assignedTo'] ?? '',
      assignedToName: data['assignedToName'] ?? '',
      escalatedAt: (data['escalatedAt'] as Timestamp).toDate(),
      reason: data['reason'] ?? '',
      isResolved: data['isResolved'] ?? false,
      resolvedAt: data['resolvedAt'] != null 
          ? (data['resolvedAt'] as Timestamp).toDate()
          : null,
    );
  }
  
  factory EscalationModel.fromEscalation(Escalation escalation) {
    return EscalationModel(
      id: escalation.id,
      taskId: escalation.taskId,
      taskTitle: escalation.taskTitle,
      assignedTo: escalation.assignedTo,
      assignedToName: escalation.assignedToName,
      escalatedAt: escalation.escalatedAt,
      reason: escalation.reason,
      isResolved: escalation.isResolved,
      resolvedAt: escalation.resolvedAt,
    );
  }
  
  Map<String, dynamic> toFirestore() {
    return {
      'taskId': taskId,
      'taskTitle': taskTitle,
      'assignedTo': assignedTo,
      'assignedToName': assignedToName,
      'escalatedAt': Timestamp.fromDate(escalatedAt),
      'reason': reason,
      'isResolved': isResolved,
      'resolvedAt': resolvedAt != null 
          ? Timestamp.fromDate(resolvedAt!)
          : null,
    };
  }
}