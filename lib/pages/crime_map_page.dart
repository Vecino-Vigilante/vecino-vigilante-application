import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:vecino_vigilante/configurations/constants.dart';
import 'package:vecino_vigilante/http/get_all_complaints.dart';
import 'package:vecino_vigilante/layouts/app_bar.dart';
import 'package:vecino_vigilante/layouts/drawer/drawer_links.dart';
import 'package:vecino_vigilante/utils/location_utils.dart';
import 'package:latlong2/latlong.dart';

class CrimeMapPage extends StatefulWidget {
  const CrimeMapPage({
    super.key,
  });

  @override
  State<CrimeMapPage> createState() => _CrimeMapPageState();
}

class _CrimeMapPageState extends State<CrimeMapPage> {
  LatLng? _userLocation;
  List<WeightedLatLng> _data = [];
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();

    _initializeUserLocation();
    _initializeMarkers();
  }

  Future<void> _initializeUserLocation() async {
    final position = await getCurrentUserLocation();

    setState(() {
      _userLocation = LatLng(
        position.latitude ?? meridaCenterLatitude,
        position.longitude ?? meridaCenterLongitude,
      );
    });
  }

  _initializeMarkers() async {
    final complaints = await getAllComplaints();

    final locations = complaints
        ?.map(
          (complaint) => WeightedLatLng(
            LatLng(
              complaint.location?.latitude ?? meridaCenterLatitude,
              complaint.location?.longitude ?? meridaCenterLongitude,
            ),
            2,
          ),
        )
        .toList();

    setState(() {
      _data = locations ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: Navbar.render(context),
      drawer: const DrawerLinks(),
      resizeToAvoidBottomInset: false,
      floatingActionButton: _userLocation != null
          ? FloatingActionButton(
              backgroundColor: theme.primaryColor,
              onPressed: () {
                mapController.move(
                  LatLng(
                    _userLocation?.latitude ?? meridaCenterLatitude,
                    _userLocation?.longitude ?? meridaCenterLongitude,
                  ),
                  16,
                );
              },
              child: Icon(
                Icons.my_location,
                color: theme.colorScheme.onPrimary,
              ),
            )
          : null,
      body: SafeArea(
        child: _userLocation == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: _userLocation ??
                      const LatLng(
                        meridaCenterLatitude,
                        meridaCenterLongitude,
                      ),
                  initialZoom: 16,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  CurrentLocationLayer(),
                  if (_data.isNotEmpty)
                    HeatMapLayer(
                      heatMapDataSource: InMemoryHeatMapDataSource(data: _data),
                      heatMapOptions: HeatMapOptions(
                        minOpacity: 0.1,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
