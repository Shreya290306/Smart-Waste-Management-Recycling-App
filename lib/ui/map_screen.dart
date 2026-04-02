import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(13.0827, 80.2707), // Chennai roughly
            initialZoom: 12.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.antiwastemanage.app',
            ),
            const MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(13.0827, 80.2707),
                  child: Icon(Icons.location_on, color: Colors.green, size: 40),
                ),
                Marker(
                  point: LatLng(13.1000, 80.2807),
                  child: Icon(Icons.location_on, color: Colors.green, size: 40),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Nearby Recycling Centers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ListTile(
                    leading: const Icon(Icons.factory, color: Colors.green),
                    title: const Text('GreenCity Main Plant'),
                    subtitle: const Text('2.5 km away'),
                    trailing: ActionChip(label: const Text('Route'), onPressed: () {}),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
