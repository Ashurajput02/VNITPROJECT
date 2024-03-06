import 'dart:html';

import 'package:flutter/material.dart';
import 'package:vnitproject/chart.dart';
import 'package:vnitproject/db/database.dart';
import 'connecttodevice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  String _selectedSex = 'Male'; // Default value for sex
  TextEditingController _weight = TextEditingController();
  TextEditingController _height = TextEditingController();
  TextEditingController _bp = TextEditingController();
  bool _isRightHanded = true; // Default value for right-handed

  DatabaseHelper db = DatabaseHelper();

  bool receiving = true;
  List<int> value = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff302d7d), Color(0x00ffffff)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 73,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                        color: Colors.black,
                        width: 2.0), // Border for the entire container
                  ),
                  child: Image.asset(
                    "assets/images/vnitfinal.webp",
                    width: 100,
                    height: 122,
                  ),
                ),
                Container(
                  width: 104,
                  height: 128,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                        color: Colors.black, width: 2.0), // Border for the logo
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 31,
            ),
            Expanded(
              child: Container(
                width: 343,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xccffffff),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),
                      const Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                          "Name:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _name,
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                          "Age:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _age,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Age'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your age';
                            }
                            // You can add additional age validation if needed
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                          "Sex:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DropdownButtonFormField<String>(
                          value: _selectedSex,
                          items: ['Male', 'Female', 'Others']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedSex = newValue!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Sex',
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                          "Weight:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _weight,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: 'Enter your weight'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your weight';
                            }
                            // You can add additional weight validation if needed
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                          "Height:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _height,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: 'Enter your height'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your height';
                            }
                            // You can add additional height validation if needed
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                          "BP:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _bp,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: 'Enter your BP'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your BP';
                            }
                            // You can add additional BP validation if needed
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Row(
                          children: [
                            const Text(
                              "Left-Handed:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                            Switch(
                              value: !_isRightHanded,
                              onChanged: (value) {
                                setState(() {
                                  _isRightHanded = !value;
                                });
                              },
                            ),
                            const Text(
                              "Right-Handed",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_validateInputs()) {
                              await DatabaseHelper.initDatabase();
                              List<int> values =
                                  await Bluetooth.startListening();

                              value.addAll(values);
                              db.insertUserData(
                                  value1: values[0],
                                  value2: values[1],
                                  value3: values[2]);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      Chart(chartData: value)));
                            } else {
                              // Show dialog if validation fails
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Validation Error"),
                                    content: const Text(
                                      "Please fill in all the required fields.",
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('Start'),
                        ),
                      ),
                      // Add more fields and validations as needed
                      // ...
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (_name.text.isEmpty ||
        _age.text.isEmpty ||
        _selectedSex.isEmpty ||
        _weight.text.isEmpty ||
        _height.text.isEmpty ||
        _bp.text.isEmpty) {
      return false;
    }
    return true;
  }
}
