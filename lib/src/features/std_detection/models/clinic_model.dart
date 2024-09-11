class ClinicModel {
  String? clinicId;
  String? clinicLogo;
  String? clinicName;
  String? clinicAddress;
  String? clinicPhone;
  String? clinicDescription;

  ClinicModel(
      {this.clinicId,
      this.clinicLogo,
      this.clinicName,
      this.clinicAddress,
      this.clinicPhone,
      this.clinicDescription});

  ///Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'Clinic_ID': clinicId,
      'Clinic_logo': clinicLogo,
      'Clinic_name': clinicName,
      'Clinic_address': clinicAddress,
      'Clinic_phone': clinicPhone,
      'Clinic_description': clinicDescription,
    };
  }

  ///Map Json oriented document snapshot from firebase to model
  factory ClinicModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return ClinicModel();

    return ClinicModel(
      clinicId: data.containsKey('Clinic_ID') ? data['Clinic_ID'] : '',
      clinicLogo: data.containsKey('Clinic_logo') ? data['Clinic_logo'] : '',
      clinicName: data.containsKey('Clinic_name') ? data['Clinic_name'] : '',
      clinicAddress:
          data.containsKey('Clinic_address') ? data['Clinic_address'] : '',
      clinicPhone: data.containsKey('Clinic_phone') ? data['Clinic_phone'] : '',
      clinicDescription: data.containsKey('Clinic_description')
          ? data['Clinic_description']
          : '',
    );
  }
}
