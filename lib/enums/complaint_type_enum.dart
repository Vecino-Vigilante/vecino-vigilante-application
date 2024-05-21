enum ComplaintTypeEnum {
  vehicularCrash(
    id: "e975e7019bc847e69f8a3742cee4cf96",
    description: "Choque automovilístico",
  ),
  suspiciousPerson(
    id: "9bbb35714af649718531a700638ae4b8",
    description: "Persona sospechosa",
  ),
  vandalism(
    id: "5d2c9473e3de46ec8248650584e6fbde",
    description: "Vandalismo",
  ),
  fire(
    id: "c0f82bcc5f394abe9d13ee50bade82a8",
    description: "Incendio",
  ),
  theft(
    id: "7b9d24cffcfe4812b6d0f0ed7f6851b4",
    description: "Robo",
  ),
  assault(
    id: "3e5c2aa7a3914dce8a7ba73ea5596596",
    description: "Asalto",
  );

  const ComplaintTypeEnum({
    required this.id,
    required this.description,
  });

  final String id;
  final String description;

  static String? getIdByDescription(String description) {
    for (var complaint in ComplaintTypeEnum.values) {
      if (complaint.description == description) {
        return complaint.id;
      }
    }

    return null;
  }
}
