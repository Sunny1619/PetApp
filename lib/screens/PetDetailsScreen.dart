import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routine_modify.dart'; // Import the RoutineModifyPage

class PetDetailsScreen extends StatefulWidget {
  @override
  _PetDetailsScreenState createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents keyboard overflow
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Pet’s Details",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),

                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.pets, size: 50, color: Colors.grey[600]),
                ),
                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    // TODO: Add image selection logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Add Image",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),

                buildTextField("Name", _nameController),
                SizedBox(height: 15),

                buildTextField("Type", _typeController),
                SizedBox(height: 15),

                buildTextField("Breed", _breedController),
                SizedBox(height: 15),

                buildTextField("Weight", _weightController, isNumber: true),
                SizedBox(height: 15),

                buildTextField("Age", _ageController, isNumber: true),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    if (_nameController.text.isNotEmpty &&
                        _typeController.text.isNotEmpty &&
                        _breedController.text.isNotEmpty &&
                        _weightController.text.isNotEmpty &&
                        _ageController.text.isNotEmpty) {
                      await prefs.setBool('pet_details_entered', true);

                      // Navigate to RoutineModifyPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RoutineModifyPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill all fields.")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
