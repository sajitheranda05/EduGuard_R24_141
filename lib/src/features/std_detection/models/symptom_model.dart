class SymptomModel {
  String? symptomId;
  String? symptomImg;
  String? symptomName;
  String? symptomDescription;

  SymptomModel(
      {this.symptomId,
      this.symptomImg,
      this.symptomName,
      this.symptomDescription});

  ///Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'Symptom_ID': symptomId,
      'Symptom_img': symptomImg,
      'Symptom_name': symptomName,
      'Symptom_description': symptomDescription,
    };
  }

  ///Map Json oriented document snapshot from firebase to model
  factory SymptomModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return SymptomModel();

    return SymptomModel(
        symptomId: data.containsKey('Symptom_ID') ? data['Symptom_ID'] : '',
        symptomImg: data.containsKey('Symptom_img') ? data['Symptom_img'] : '',
        symptomName:
            data.containsKey('Symptom_name') ? data['Symptom_name'] : '',
        symptomDescription: data.containsKey('Symptom_description')
            ? data['Symptom_description']
            : '');
  }
}
