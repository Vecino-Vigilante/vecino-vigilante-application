enum RoutesEnum {
  home(
    name: "Inicio",
    path: "/",
  ),
  crimeMap(
    name: "Mapa delictivo",
    path: "/crime-map",
  ),
  newComplaint(
    name: "Nueva denuncia",
    path: "/new-complaint",
  ),
  emergencyNumbers(
    name: "Números de emergencia",
    path: "/emergency-numbers",
  );

  const RoutesEnum({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
}
