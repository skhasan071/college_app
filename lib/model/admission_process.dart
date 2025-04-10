class AdmissionProcess {
  final String id; // MongoDB ObjectId
  final String collegeId;
  final String admissionCriteria;
  final String applicationProcess;
  final String importantDates;
  final List<String> documentsRequired;
  final String selectionProcess;

  AdmissionProcess({
    required this.id,
    required this.collegeId,
    required this.admissionCriteria,
    required this.applicationProcess,
    required this.importantDates,
    required this.documentsRequired,
    required this.selectionProcess,
  });

  factory AdmissionProcess.fromMap(Map<String, dynamic> map) {
    return AdmissionProcess(
      id: map['_id'] ?? '',
      collegeId: map['collegeId'] ?? '',
      admissionCriteria: map['admissionCriteria'] ?? '',
      applicationProcess: map['applicationProcess'] ?? '',
      importantDates: map['importantDates'] ?? '',
      documentsRequired: List<String>.from(map['documentsRequired'] ?? []),
      selectionProcess: map['selectionProcess'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'collegeId': collegeId,
      'admissionCriteria': admissionCriteria,
      'applicationProcess': applicationProcess,
      'importantDates': importantDates,
      'documentsRequired': documentsRequired,
      'selectionProcess': selectionProcess,
    };
  }
}
