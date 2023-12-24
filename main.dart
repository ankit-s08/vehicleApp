// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'vehicleFormScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define a variable to track the selected vehicle type
  String selectedVehicle = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Available Vehicles'),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Bike'),
              Tab(text: 'Car'),
            ],
            onTap: (index) {
              // Handle tab selection
              setState(() {
                // Set selectedVehicle based on the selected tab
                if (index == 0) {
                  selectedVehicle = '';
                } else if (index == 1) {
                  selectedVehicle = 'Bike';
                } else if (index == 2) {
                  selectedVehicle = 'Car';
                }
              });
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: VehicleList(selectedVehicle: selectedVehicle),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    // Add functionality for the "+" button
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VehicleFormScreen()),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
                const Positioned(
                  bottom: 10.0,
                  child: Text('Add Vehicle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleList extends StatelessWidget {
  final String selectedVehicle;

  VehicleList({super.key, required this.selectedVehicle});

  // Replace this with actual data or fetch from an API
  List<String> vehicles = ['Car 1', 'Car 2', 'Bike 1', 'Truck 1'];

  @override
  Widget build(BuildContext context) {
    // Filter the list based on the selected vehicle type
    List<String> filteredVehicles = selectedVehicle.isEmpty
        ? vehicles
        : vehicles
            .where((vehicle) => vehicle.contains(selectedVehicle))
            .toList();

    return ListView.builder(
      itemCount: filteredVehicles.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(filteredVehicles[index]),
            onTap: () {
              // Add navigation to the details screen or any desired action
            },
          ),
        );
      },
    );
  }
}
