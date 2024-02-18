import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  String _selectedSex = 'Male'; // Default value for sex
  TextEditingController _weight = TextEditingController();
  TextEditingController _height = TextEditingController();
  TextEditingController _bp = TextEditingController();
  bool _isRightHanded = true; // Default value for right-handed

  bool receiving = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff302d7d), Color(0x00ffffff)],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
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
            SizedBox(
              height: 31,
            ),
            Expanded(
              child: Container(
                width: 343,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xccffffff),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 48),
                      Padding(
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
                          decoration: InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
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
                          decoration: InputDecoration(labelText: 'Age'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your age';
                            }
                            // You can add additional age validation if needed
                            return null;
                          },
                        ),
                      ),
                      Padding(
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
                          decoration: InputDecoration(
                            labelText: 'Sex',
                          ),
                        ),
                      ),
                      Padding(
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
                              InputDecoration(labelText: 'Enter your weight'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your weight';
                            }
                            // You can add additional weight validation if needed
                            return null;
                          },
                        ),
                      ),
                      Padding(
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
                              InputDecoration(labelText: 'Enter your height'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your height';
                            }
                            // You can add additional height validation if needed
                            return null;
                          },
                        ),
                      ),
                      Padding(
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
                              InputDecoration(labelText: 'Enter your BP'),
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
                        padding: EdgeInsets.only(left: 18),
                        child: Row(
                          children: [
                            Text(
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
                            Text(
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
                          onPressed: () {
                            if (_validateInputs()) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/graphs');
                            } else {
                              // Show dialog if validation fails
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Validation Error"),
                                    content: Text(
                                      "Please fill in all the required fields.",
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text('Start'),
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
