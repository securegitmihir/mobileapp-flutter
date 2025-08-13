import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("build called profile screen");
    return Scaffold(body: Center(child: Text('Profile Screen')));
  }
}
