import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:vecino_vigilante/configurations/constants.dart';
import 'package:vecino_vigilante/layouts/main/main_layout.dart';
import 'package:vecino_vigilante/models/enums/complaint_type_enum.dart';
import 'package:vecino_vigilante/models/position.dart';
import 'package:vecino_vigilante/utils/location_utils.dart';
import 'package:vecino_vigilante/widgets/custom_input_decoration.dart';

class NewComplaintPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  NewComplaintPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return MainLayout(
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTypeAhead<String>(
                decoration: CustomInputDecoration.getDecoration(
                  helperText: "Seleccione el tipo de incidente",
                  hintText: "Ej. Robo, choque automovilístico",
                  labelText: "Tipo de incidente",
                  suffixIcon: Icons.keyboard_arrow_down_rounded,
                  theme: theme,
                ),
                itemBuilder: (context, country) {
                  return ListTile(
                    title: Text(country),
                  );
                },
                name: "incidentType",
                suggestionsCallback: (query) {
                  List<String> complaintTypes = ComplaintTypeEnum.values
                      .map((complaintType) => complaintType.description)
                      .toList();

                  if (query.isEmpty) {
                    return complaintTypes;
                  } else {
                    String lowercaseQuery = query.toLowerCase();

                    return complaintTypes
                        .where((complaintType) => complaintType
                            .toLowerCase()
                            .contains(lowercaseQuery))
                        .toList(growable: false)
                      ..sort((a, b) => a
                          .toLowerCase()
                          .indexOf(lowercaseQuery)
                          .compareTo(b.toLowerCase().indexOf(lowercaseQuery)));
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'El campo "Tipo de incidente" es requerido.',
                  ),
                ]),
              ),
              const SizedBox(
                height: 34,
              ),
              FormBuilderTextField(
                decoration: CustomInputDecoration.getDecoration(
                  helperText: "(Opcional)",
                  hintText: "Ej. El sospechoso se dirigió a la calle 135...",
                  labelText: "Descripciones adicionales del suceso",
                  theme: theme,
                ),
                minLines: 4,
                maxLines: 4,
                name: "description",
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(
                height: 34,
              ),
              SizedBox(
                height: 96,
                child: FormBuilderImagePicker(
                  backgroundColor: Colors.transparent,
                  cameraIcon: const Icon(Icons.camera_alt),
                  cameraLabel: const Text("Cámara"),
                  decoration: CustomInputDecoration.getDecoration(
                      helperText: "(Opcional)",
                      labelText: "Imagen del suceso",
                      theme: theme),
                  icon: Icons.add_a_photo,
                  iconColor: Colors.black45,
                  galleryLabel: const Text("Galería"),
                  maxImages: 1,
                  name: "imageUrl",
                  previewAutoSizeWidth: true,
                  showDecoration: true,
                ),
              ),
              const SizedBox(
                height: 34,
              ),
              SizedBox(
                height: 201,
                child: FormBuilderField(
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: CustomInputDecoration.getDecoration(
                        labelText: "Ubicación del suceso",
                        helperText: "(Por defecto tu ubicación)",
                        theme: theme,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: FutureBuilder<PositionModel>(
                          future: getCurrentUserLocation(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    snapshot.data!.latitude,
                                    snapshot.data!.longitude,
                                  ),
                                  zoom: 16,
                                ),
                                scrollGesturesEnabled: false,
                                myLocationEnabled: true,
                                myLocationButtonEnabled: false,
                                onMapCreated: (mapController) {
                                  getCurrentUserLocation().then(
                                    (position) => {
                                      _formKey.currentState?.patchValue({
                                        "location": {
                                          "latitude": position.latitude,
                                          "longitude": position.longitude,
                                          "address": position.address,
                                        }
                                      }),
                                    },
                                  );
                                },
                                onTap: (latLong) {
                                  _showLocationPickerModal(context);
                                },
                                zoomControlsEnabled: false,
                                zoomGesturesEnabled: false,
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  "¡Oh, no! Se produjo un error al intentar obtener tu ubicación actual.",
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  name: "location",
                ),
              ),
              const SizedBox(
                height: 34,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Container(
                    width: 24,
                    height: 24,
                    padding: const EdgeInsets.all(2.0),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  ),
                  label: const Text("Guardar denuncia"),
                  onPressed: () {
                    _formKey.currentState?.save();
                    log(jsonEncode(_formKey.currentState?.value));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      theme.colorScheme.primary,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_showLocationPickerModal(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 500),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlacePicker(
              apiKey: dotenv.get("GOOGLE_MAPS_API_KEY"),
              hintText: "Buscar en Google Maps",
              initialPosition: const LatLng(
                meridaCenterLatitude,
                meridaCenterLongitude,
              ),
              useCurrentLocation: true,
              zoomControlsEnabled: true,
            ),
          ),
        ),
      );
    },
  );
}
