// vehicle_form_screen.dart

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class VehicleFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Form'),
      ),
      body: const Center(
        child: Text('This is the Vehicle Form Screen'),
      ),
    );
  }
}
