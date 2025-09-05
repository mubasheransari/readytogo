class AssessmentModel {
  final String assesseeUserId;
  final String assessmentSubmissionId;
  final String assesseeFirstName;
  final String assesseeLastName;
  final String assesseeEmail;
  final String assesseeRole;
  final String assessmentTitle;
  final DateTime createdAt;
  final num? durationSeconds;

  AssessmentModel({
    required this.assesseeUserId,
    required this.assessmentSubmissionId,
    required this.assesseeFirstName,
    required this.assesseeLastName,
    required this.assesseeEmail,
    required this.assesseeRole,
    required this.assessmentTitle,
    required this.createdAt,
    this.durationSeconds,
  });

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      assesseeUserId: json['assesseeUserId']?.toString() ?? '',
      assessmentSubmissionId: json['assessmentSubmissionId']?.toString() ?? '',
      assesseeFirstName: json['assesseeFirstName'] ?? '',
      assesseeLastName: json['assesseeLastName'] ?? '',
      assesseeEmail: json['assesseeEmail'] ?? '',
      assesseeRole: json['assesseeRole'] ?? '',
      assessmentTitle: json['assessmentTitle'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      durationSeconds: json['durationSeconds'],
    );
  }
}
