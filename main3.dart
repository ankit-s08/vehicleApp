import 'package:flutter/material.dart';
import 'vehicleFormScreen.dart';

class VehicleList extends StatelessWidget {
  final List<VehicleCard> vehicleCards;
  final String selectedTab;
  const VehicleList(
      {super.key, required this.vehicleCards, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    //filter the list based on the basis of selected vehicle
    List<VehicleCard> filteredCards = [];

    if (selectedTab == 'All') {
      filteredCards = List.from(vehicleCards);
    } else {
      filteredCards = vehicleCards
          .where((card) => card.vehicleData.vehicleType == selectedTab)
          .toList();
    }
    return ListView.builder(
      itemCount: filteredCards.length,
      itemBuilder: (context, index) {
        return filteredCards[index];
      },
    );
  }
}

class VehicleCard extends StatelessWidget {
  final VehicleData vehicleData;
  final Function onDelete;

  const VehicleCard(
      {super.key, required this.vehicleData, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Vehicle No: ${vehicleData.vehicleNo}'),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    //Handle delete action
                    onDelete();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Brand: ${vehicleData.brand}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Vehicle Type: ${vehicleData.vehicleType}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Fuel Type: ${vehicleData.fuelType}'),
          ),
        ]));
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Lykiq Vehicles App',
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
  List<VehicleCard> vehicleCards = [];

  late String selectedTab; //default selected tab

  @override
  void initState() {
    super.initState();
    selectedTab = 'All'; //Initialize the default selected tab
  }

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
                if (index == 0) {
                  selectedTab = 'All';
                } else if (index == 1) {
                  selectedTab = 'Bike';
                } else if (index == 2) {
                  selectedTab = 'Car';
                }
              });
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: VehicleList(
                  vehicleCards: vehicleCards, selectedTab: selectedTab),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {
                    // Navigate to the "Vehicle Form" screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VehicleFormScreen(
                          onSubmit: (vehicleData) {
                            // Handle the submitted form data
                            addVehicleCard(vehicleData);
                          },
                        ),
                      ),
                    );
                  },
                  label: const Text('Add Vehicle'),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addVehicleCard(VehicleData vehicleData) {
    late VehicleCard newCard;
    setState(() {
      newCard = VehicleCard(
        vehicleData: vehicleData,
        onDelete: () {
          //handle delete action
          deleteVehicleCard(newCard);
        },
      );
      vehicleCards.add(newCard);
    });
  }

  void deleteVehicleCard(VehicleCard vehicleCard) {
    setState(() {
      vehicleCards.remove(vehicleCard);
    });
  }
}
