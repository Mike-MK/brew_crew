import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register'),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white)),
          ),
        ],
      ),
      body: loading
          ? Loading()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (value) => value!.length < 6
                          ? 'Password should be at least 6 characters'
                          : null,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    Text(error,style: TextStyle(color: Colors.red),),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.brown[900]),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = email.trim();
                            password = password.trim();

                            //loading = true;
                          });
                          print('loading...');
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Invalid credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
