import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:vecino_vigilante/configurations/constants.dart';
import 'package:vecino_vigilante/utils/location_utils.dart';

class MapPreviewWithLocationSelect extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;

  const MapPreviewWithLocationSelect({
    super.key,
    required this.formKey,
  });

  @override
  State<MapPreviewWithLocationSelect> createState() =>
      _MapPreviewWithLocationSelectState();
}

class _MapPreviewWithLocationSelectState
    extends State<MapPreviewWithLocationSelect> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  Marker? _locationMarker;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final position = await getCurrentUserLocation();

    if (!mounted) return;

    setState(() {
      _selectedLocation = LatLng(
        position.latitude ?? meridaCenterLatitude,
        position.longitude ?? meridaCenterLongitude,
      );
      _updateMarker(_selectedLocation!);
    });
  }

  void _updateMarker(LatLng position) {
    setState(() {
      _locationMarker = Marker(
        markerId: const MarkerId('Selected-location'),
        position: position,
        consumeTapEvents: true,
        onTap: () {
          _showLocationPickerModal(context);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedLocation == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _selectedLocation!,
        zoom: 16,
      ),
      markers: _locationMarker != null ? {_locationMarker!} : {},
      myLocationButtonEnabled: false,
      onMapCreated: (mapController) {
        _mapController = mapController;

        getCurrentUserLocation().then(
          (position) => {
            widget.formKey.currentState?.patchValue({
              "location": {
                "latitude": position.latitude,
                "longitude": position.longitude,
                "direction": position.direction,
              }
            }),
          },
        );
      },
      onTap: (latLong) {
        _showLocationPickerModal(context);
      },
      scrollGesturesEnabled: false,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
    );
  }

  void _showLocationPickerModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 600),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlacePicker(
                apiKey: dotenv.get("GOOGLE_MAPS_API_KEY"),
                automaticallyImplyAppBarLeading: false,
                autocompleteLanguage: "es",
                enableMapTypeButton: false,
                hintText: "Buscar en Google Maps",
                initialPosition: _selectedLocation ??
                    const LatLng(
                      meridaCenterLatitude,
                      meridaCenterLongitude,
                    ),
                region: "mx",
                onPlacePicked: (PickResult pickResult) {
                  final lat = pickResult.geometry?.location.lat ?? 0;
                  final lng = pickResult.geometry?.location.lng ?? 0;
                  final direction = pickResult.formattedAddress ?? "";

                  setState(() {
                    _selectedLocation = LatLng(lat, lng);
                    _updateMarker(_selectedLocation!);
                  });

                  widget.formKey.currentState?.patchValue({
                    "location": {
                      "latitude": lat,
                      "longitude": lng,
                      "direction": direction,
                    }
                  });

                  _mapController?.animateCamera(
                    CameraUpdate.newLatLng(_selectedLocation!),
                  );

                  Navigator.of(context).pop();
                },
                searchingText: "Buscando...",
                useCurrentLocation: false,
              ),
            ),
          ),
        );
      },
    );
  }
}
