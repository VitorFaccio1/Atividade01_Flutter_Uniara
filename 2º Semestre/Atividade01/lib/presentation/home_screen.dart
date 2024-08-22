import 'package:appgeolocalizacao/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng? _currentPosition;
  final LocationService _locationService = LocationService();
  final MapController _mapController = MapController(); 

  final List<LatLng> _pointsOfInterest = [
    LatLng(-21.804267, -48.1739194), // UNIARA IV
    LatLng(-21.797156, -48.1806229), // UNIARA II
    LatLng(-21.7966042, -48.1783619), // UNIARA II
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _locationService.getCurrentLocation();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Localização atual: ${position.latitude}, ${position.longitude}',
          ),
          duration: const Duration(seconds: 3),
        ),
      );

      _mapController.move(_currentPosition!, 15);
    } catch (e) {
      print('Erro ao obter a localização: $e');
    }
  }

  void _centerOnCurrentLocation() {
    if (_currentPosition != null) {
      _mapController.move(_currentPosition!, 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Localização no Mapa'),
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController, 
              options: MapOptions(
                center: _currentPosition,
                zoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentPosition!,
                      width: 80,
                      height: 80,
                      builder: (ctx) => const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                    ..._pointsOfInterest.map(
                      (point) => Marker(
                        point: point,
                        width: 80,
                        height: 80,
                        builder: (ctx) => const Icon(
                          Icons.star,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                    ).toList(),
                  ],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _centerOnCurrentLocation,
        child: const Icon(Icons.my_location),
        tooltip: 'Centralizar na Localização Atual',
      ),
    );
  }
}