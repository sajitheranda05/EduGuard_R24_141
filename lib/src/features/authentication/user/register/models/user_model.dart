import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/features/authentication/user/register/models/role_enum.dart';
import 'package:eduguard/src/utils/helper_functions.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String age;
  final String email;
  String contactNumber;
  String profilePicture;
  Role role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
    required this.contactNumber,
    required this.profilePicture,
    required this.role,
  });

  //Helper function to get the full name
  String get fullName => '$firstName $lastName';

  //Helper function to format phone number
  String get formatContactNumber => AppHelperFunctions.formatPhoneNumber(contactNumber);

  //Static function to split full name into first and lastname
  static List<String> nameParts(fullName) => fullName.split('');

  //Staic function to create an empty user model
  static UserModel empty() => UserModel(id: '', firstName: '', lastName: '', age: '', email: '', contactNumber: '', profilePicture: '', role: Role.student);

  //Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'FirstName' : firstName,
      'LastName' : lastName,
      'Age' : age,
      'Email' : email,
      'ContactNumber' : contactNumber,
      'ProfilePicture' : profilePicture,
      'Role' : role.toString().split('.').last,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    if (document.data() != null) {
      final data =document.data()!;
      return UserModel(
          id: document.id,
          firstName: data['FirstName'] ?? '',
          lastName: data['LastName'] ?? '',
          age: data['Age'] ?? '',
          email: data['Email'] ?? '',
          contactNumber: data['ContactNumber'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '',
          role: Role.values.firstWhere((e) => e.toString() == 'Role.${data['Role']}'),
      );
    } else {
      return UserModel.empty();
    }
  }

}