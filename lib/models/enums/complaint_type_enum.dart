enum ComplaintTypeEnum {
  vehicularCrash(id: 1, description: "Choque automovilístico"),
  suspiciousPerson(id: 2, description: "Persona sospechosa"),
  theft(id: 3, description: "Robo"),
  assault(id: 4, description: "Asalto");

  const ComplaintTypeEnum({
    required this.id,
    required this.description,
  });

  final int id;
  final String description;
}
