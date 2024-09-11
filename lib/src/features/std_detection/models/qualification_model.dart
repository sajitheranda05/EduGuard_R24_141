class QualificationModel {
  String? campusId;
  String? campusLogo;
  String? campusName;
  String? degree;

  QualificationModel(
      {this.campusId, this.campusLogo, this.campusName, this.degree});

  ///Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'Campus_ID': campusId,
      'Campus_logo': campusLogo,
      'Campus_name': campusName,
      'Degree': degree,
    };
  }

  ///Map Json oriented document snapshot from firebase to model
  factory QualificationModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return QualificationModel();

    return QualificationModel(
        campusId: data.containsKey('Campus_ID') ? data['Campus_ID'] : '',
        campusLogo: data.containsKey('Campus_logo') ? data['Campus_logo'] : '',
        campusName: data.containsKey('Campus_name') ? data['Campus_name'] : '',
        degree: data.containsKey('Degree') ? data['Degree'] : '');
  }
}
