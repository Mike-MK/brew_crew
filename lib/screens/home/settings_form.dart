import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MUser>(context);

    return Container(
      color: const Color(0xff737373),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 30.0,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          color: Colors.white,
        ),
        child: StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData? userData = snapshot.data;
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Update your brew settings',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        initialValue: _currentName ?? userData!.name,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Name'),
                        validator: (value) =>
                            value == '' ? 'Enter a name' : null,
                        onChanged: (value) {
                          setState(() => _currentName = value);
                        },
                      ),
                      const SizedBox(height: 10.0),
                      DropdownButtonFormField(
                        decoration: textInputDecoration,
                        value: _currentSugars ?? userData!.sugars,
                        items: sugars.map((sugar) {
                          return DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugar(s)'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _currentSugars = value.toString();
                          });
                        },
                      ),
                      Slider(
                        min: 100,
                        max: 900,
                        divisions: 8,
                        activeColor: Colors.brown[_currentStrength ?? 100],
                        inactiveColor: Colors.brown[_currentStrength ?? 100],
                        value:
                            (_currentStrength ?? userData!.strength).toDouble(),
                        onChanged: (val) =>
                            setState(() => _currentStrength = val.round()),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentSugars ?? userData!.sugars,
                                _currentName ?? userData!.name,
                                _currentStrength ?? userData!.strength);
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                );
              } else {
                return const Text('No data');
              }
            }),
      ),
    );
  }
}
