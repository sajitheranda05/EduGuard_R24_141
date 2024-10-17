import 'package:cloud_firestore/cloud_firestore.dart';

class Questionnaremodel {
  String Catogary;
  String ID;
  String QsName;
  String Qs;
  String QSAdderName;
  String QSImage;

  Questionnaremodel({
    required this.ID,
    required this.Catogary,
    required this.QsName,
    required this.Qs,
    required this.QSAdderName,
    required this.QSImage,
  });

  //Staic function to create an empty user model
  static Questionnaremodel empty() => Questionnaremodel(
        ID: '',
        QsName: '',
        Qs: '',
        QSAdderName: '',
        QSImage: '',
        Catogary: '',
      );

  //Convert model to JSON structureR
  Map<String, dynamic> toJson() {
    return {
      'Catogary': Catogary,
      'ID': ID,
      'QsName': QsName,
      'Qs': Qs,
      'QSAdderName': QSAdderName,
      'QSImage': QSImage
    };
  }

  factory Questionnaremodel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return Questionnaremodel(
        ID: data['ID'] ?? '',
        QsName: data['QsName'] ?? '',
        Qs: data['Qs'] ?? '',
        QSAdderName: data['QSAdderName'] ?? '',
        QSImage: data['QSImage'] ?? '',
        Catogary: data['Catogary'] ?? '',
      );
    } else {
      return Questionnaremodel.empty();
    }
  }
}
