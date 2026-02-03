
import 'package:flutter/material.dart';




class WizardListScreen extends StatelessWidget {
  const WizardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hogwarts CRUD')),
      body: const Center(child: Text('Wizard List Screen')),
    );
  } 
}
