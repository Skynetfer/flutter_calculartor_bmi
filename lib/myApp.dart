import 'package:flutter/material.dart';

import 'bmi.dart';
import 'bmiList.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double? bmi;
  BMI _bmi = BMI(name: '', height: 0.0, weight: 0.0, bmi: 0.0);
  List<BMI> _listBmis = [];

  double? _calculateBmi() {
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);
    // We dived height by 100 because we are taking the height in centimeter
    // and formula takes height in meter.

    double heightSquare = height * height;
    double bmi = weight / heightSquare;
    print(bmi);
    return bmi;
  }

  void _Bmi() {
    if (_bmi.name!.isEmpty ||
        _bmi.height == 0 ||
        _bmi.height!.isNaN ||
        _bmi.weight == 0 ||
        _bmi.weight!.isNaN) {
      return;
    }
    _bmi.createdDate = DateTime.now();
    _listBmis.add(_bmi);
    _bmi.bmi = _calculateBmi();
    _bmi = BMI(name: '', height: 0.0, weight: 0.0, bmi: 0.0);
    _nameController.text = '';
    _heightController.text = '';
    _weightController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculator BMI',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.only(
                right: 20,
              ),
              onPressed: () {
                _calculateBmi();
                this._Bmi();
              },
              icon: Icon(Icons.add, color: Colors.green),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(
            //       'assets/images/simple-white-abstract-gradient-background_53876-99910.jpg',
            //     ),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nhap ten',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                    ),
                    controller: _nameController,
                    onChanged: (text) {
                      print(text);
                      setState(
                        () {
                          _bmi.name = text;
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nhap can nang (kg)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),
                    controller: _weightController,
                    onChanged: (text) {
                      print(text);
                      setState(
                        () {
                          _bmi.weight = double.tryParse(text) ?? 0;
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nhap chieu cao (cm)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),
                    controller: _heightController,
                    onChanged: (text) {
                      print(text);
                      setState(
                        () {
                          _bmi.height = double.tryParse(text) ?? 0;
                        },
                      );
                    },
                  ),
                ),
                ButtonTheme(
                  child: Container(
                    child: TextButton(
                      onPressed: () {
                        print('press me');
                        print(
                          'Name: ${_bmi.name}, Can nang: ${_bmi.weight}, Chieu cao: ${_bmi.height}',
                        );
                        setState(() {
                          this._calculateBmi();
                          this._Bmi();
                        });
                      },
                      child: Text(
                        'Calculator',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.greenAccent,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    child: BmiList(bmiList: _listBmis),
                    // color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
