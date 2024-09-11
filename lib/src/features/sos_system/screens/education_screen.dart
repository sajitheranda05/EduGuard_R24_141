import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants/image_strings.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  late Future<SharedPreferences> _prefsFuture;
  String? userEmail;

  @override
  void initState() {
    _prefsFuture = SharedPreferences.getInstance();
    super.initState();
  }

  final String selectedEmail = "sandutharu40@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sex Education'),
        actions: [
          FutureBuilder<SharedPreferences>(
            future: _prefsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading preferences');
              } else {
                final prefs = snapshot.data;
                final email = prefs?.getString('email') ?? '';

                if (email == selectedEmail) {
                  return IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _showAddCardDialog(context);
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<SharedPreferences>(
          future: _prefsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading preferences'));
            } else {
              final prefs = snapshot.data;
              final role = prefs?.getString('role')?.split('.').last ?? '';
              final email = prefs?.getString('email') ?? '';

              return StreamBuilder(
                stream: email == selectedEmail ? FirebaseFirestore.instance
                    .collection('cards').snapshots() :  FirebaseFirestore.instance
                    .collection('cards')
                    .where('role', isEqualTo: role.toUpperCase())
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var cardData = snapshot.data!.docs[index];
                      return SexEducationCard(
                        title: cardData['title'],
                        image: AppImages.onBoardingImage_education,
                        onPressed: () {
                          // Navigate to new screen with content
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewContentScreen(
                                title: cardData['title'],
                                content: cardData['content'],
                              ),
                            ),
                          );
                        },
                        /// Show delete button only if the email equals
                        onDelete: email == selectedEmail
                            ? () {
                          _deleteCard(cardData.id);
                        }
                            : null,
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  void _showAddCardDialog(BuildContext context) {
    String title = '';
    String content = '';
    String selectedRole = 'STUDENT'; // Default role

    // List of roles for the dropdown
    List<String> roles = ['STUDENT', 'USER'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Card'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Enter Title'),
              onChanged: (value) {
                title = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Enter Content'),
              maxLines: 5,
              onChanged: (value) {
                content = value;
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedRole,
              items: roles.map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value ?? 'STUDENT';
                });
              },
              decoration: const InputDecoration(labelText: 'Select Role'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (title.isNotEmpty && content.isNotEmpty && selectedRole.isNotEmpty) {
                _addCard(title, content, selectedRole);
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _addCard(String title, String content, String role) async {
    await FirebaseFirestore.instance.collection('cards').add({
      'title': title,
      'content': content, // Save the content
      'role': role, // Save the selected role
      'image': AppImages.onBoardingImage_education,
    });
  }

  Future<void> _deleteCard(String docId) async {
    await FirebaseFirestore.instance.collection('cards').doc(docId).delete();
  }
}

class SexEducationCard extends StatefulWidget {
  final String title;
  final String image;
  final VoidCallback onPressed;
  final VoidCallback? onDelete;

  const SexEducationCard({
    required this.title,
    required this.image,
    required this.onPressed,
    this.onDelete,
  });

  @override
  State<SexEducationCard> createState() => _SexEducationCardState();
}

class _SexEducationCardState extends State<SexEducationCard> {
  late Future<SharedPreferences> _prefsFuture;

  String? userEmail;

  @override
  void initState() {
    _prefsFuture = SharedPreferences.getInstance();
    super.initState();
  }

  Future<void> _getEmail() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userEmail = sharedPreferences.getString('email');
    });
  }

  final String selectedEmail = "sandutharu40@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Image.asset(
              widget.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.zero,
              ),
              child: Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.greenAccent),
                ),
                child: const Center(
                  child: Text(
                    'View',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder<SharedPreferences>(
            future: _prefsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading preferences');
              } else {
                final prefs = snapshot.data;
                final email = prefs?.getString('email') ?? '';

                if (widget.onDelete != null && email == selectedEmail) {
                  return IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: widget.onDelete,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class ViewContentScreen extends StatelessWidget {
  final String title;
  final String content;

  const ViewContentScreen({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Image(
              image: AssetImage(
                AppImages.onBoardingImage_education,
              ),
            ),
            Text(
              content,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
