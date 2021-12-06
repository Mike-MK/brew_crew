import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Authenticate();
  }
}