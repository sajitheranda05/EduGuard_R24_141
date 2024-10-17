import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  String Catogary;
  String ID;
  String BlogName;
  String Blog;
  String BloggerName;
  String BlogImage;

  BlogModel({
    required this.ID,
    required this.Catogary,
    required this.BlogName,
    required this.Blog,
    required this.BloggerName,
    required this.BlogImage,
  });

  //Staic function to create an empty user model
  static BlogModel empty() => BlogModel(
        ID: '',
        BlogName: '',
        Blog: '',
        BloggerName: '',
        BlogImage: '',
        Catogary: '',
      );

  //Convert model to JSON structureR
  Map<String, dynamic> toJson() {
    return {
      'Catogary': Catogary,
      //'ID': ID,
      'ID': '',
      'BlogName': BlogName,
      'Blog': Blog,
      'Blogger_Name': BloggerName,
      'Blog_Image': BlogImage
    };
  }

  factory BlogModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BlogModel(
        //ID: data['ID'] ?? '',
        ID: document.id,
        BlogName: data['BlogName'] ?? '',
        Blog: data['Blog'] ?? '',
        BloggerName: data['Blogger_Name'] ?? '',
        BlogImage: data['Blog_Image'] ?? '',
        Catogary: data['Catogary'] ?? '',
      );
    } else {
      return BlogModel.empty();
    }
  }
}
