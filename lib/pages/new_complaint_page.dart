import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vecino_vigilante/configurations/routes_enum.dart';
import 'package:vecino_vigilante/http/create_complaint.dart';
import 'package:vecino_vigilante/http/requests/create_complaint_request.dart';
import 'package:vecino_vigilante/layouts/main_layout.dart';
import 'package:vecino_vigilante/enums/complaint_type_enum.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';
import 'package:vecino_vigilante/utils/image_utils.dart';
import 'package:vecino_vigilante/widgets/custom_input_decoration.dart';
import 'package:vecino_vigilante/widgets/map_preview_with_location_select.dart';

class NewComplaintPage extends StatefulWidget {
  const NewComplaintPage({
    super.key,
  });

  @override
  State<NewComplaintPage> createState() => _NewComplaintPageState();
}

class _NewComplaintPageState extends State<NewComplaintPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _isSubmitting = false;

  void submit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      final complaintRequest = CreateComplaintRequest(
        date: DateTime.now(),
        description: _formKey.currentState?.value["description"] ?? "",
        resource: _formKey.currentState?.value["image"] != null
            ? await convertXFileToBase64Image(
                _formKey.currentState?.value["image"].first as XFile,
              )
            : "",
        typeId: ComplaintTypeEnum.getIdByDescription(
                _formKey.currentState?.value["incident"]) ??
            "0",
        location: Location(
          direction: _formKey.currentState?.value["location"]["direction"],
          latitude: _formKey.currentState?.value["location"]["latitude"],
          longitude: _formKey.currentState?.value["location"]["longitude"],
        ),
        userId: await AuthUtils.getAuthenticatedUserId(),
      );

      late SnackBar snackBar;

      createComplaint(complaintRequest).then((response) {
        snackBar = const SnackBar(
          content: Text("¡Denuncia registrada correctamente!"),
          backgroundColor: Colors.green,
          showCloseIcon: true,
        );

        _formKey.currentState!.reset();
        context.pushReplacement(RoutesEnum.home.path);
      }).catchError((e) {
        snackBar = const SnackBar(
          content: Text(
            "¡Oh no! Algo salió mal mientras intentabamos guardar tu denuncia. Intentalo más tarde.",
          ),
          backgroundColor: Colors.red,
          showCloseIcon: true,
        );
      }).whenComplete(() {
        setState(() {
          _isSubmitting = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return MainLayout(
      floatingActionButton: null,
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
                itemBuilder: (context, complaintType) {
                  return ListTile(
                    title: Text(complaintType),
                  );
                },
                name: "incident",
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
                  FormBuilderValidators.required(),
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
                    theme: theme,
                  ),
                  galleryLabel: const Text("Galería"),
                  icon: Icons.add_a_photo,
                  iconColor: Colors.black45,
                  maxImages: 1,
                  name: "image",
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
                        child: MapPreviewWithLocationSelect(formKey: _formKey),
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
                  icon: _isSubmitting
                      ? Container(
                          width: 24,
                          height: 24,
                          padding: const EdgeInsets.all(2.0),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Container(),
                  label: const Text("Guardar denuncia"),
                  onPressed: _isSubmitting ? null : submit,
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
