import 'package:flutter/material.dart';
import 'package:vecino_vigilante/layouts/main/main_layout.dart';
import 'package:vecino_vigilante/widgets/emergency_service_card.dart';

class EmergencyNumbersPage extends StatelessWidget {
  const EmergencyNumbersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List emergencyServices = [
      {
        "serviceDescription":
            "Atiende incidentes médicos, de seguridad, protección civil y servicios públicos.",
        "serviceIcon": Icons.local_police_outlined,
        "serviceName": "Emergencias",
        "serviceTelephoneNumber": "911"
      },
      {
        "serviceDescription":
            "Atiende denuncias sobre venta de drogas, violencia intrafamiliar, secuestro, maltrato, homicidio, robo, violación, pandillerismo, falsificación de documentos, armas, explosivos, corrupción, entre otras.",
        "serviceIcon": Icons.support_agent_outlined,
        "serviceName": "Denuncia anónima",
        "serviceTelephoneNumber": "089"
      },
      {
        "serviceDescription":
            "Mecanismo nacional de coordinación y cooperación sistemática para la búsqueda y pronta recuperación de niños y adolescentes que son reportados como desaparecidos y por ello, se encuentran en riesgo inminente de sufrir un daño grave a su integridad.",
        "serviceIcon": Icons.child_care_outlined,
        "serviceName": "Alerta AMBER",
        "serviceTelephoneNumber": "800 002 6237"
      },
      {
        "serviceDescription":
            "Atiende emergencias por fuego que ponen en riesgo a las personas y a su patrimonio, el patrimonio histórico o cultural de la Ciudad, así como las que significan un riesgo para el medio ambiente.",
        "serviceIcon": Icons.fire_truck_outlined,
        "serviceName": "Central de bomberos",
        "serviceTelephoneNumber": "999 924 9242"
      },
      {
        "serviceDescription":
            "Atiende a personas o comunidades afectadas por situaciones de emergencia o desastre, problemáticas de salud, enfermedades y lesiones por accidentes.",
        "serviceIcon": Icons.medical_services_outlined,
        "serviceName": "Cruz roja",
        "serviceTelephoneNumber": "999 983 0243"
      },
      {
        "serviceDescription":
            "Gestiona y coordina las acciones destinadas a proteger a las personas, los bienes y el medio ambiente ante situaciones de grave riesgo colectivo, catástrofes y calamidades públicas.",
        "serviceIcon": Icons.change_history_outlined,
        "serviceName": "Protección civil",
        "serviceTelephoneNumber": "999 928 8311"
      },
    ];

    return MainLayout(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            ...emergencyServices.map((emergencyService) => EmergencyServiceCard(
                serviceDescription: emergencyService["serviceDescription"],
                serviceIcon: emergencyService["serviceIcon"],
                serviceName: emergencyService["serviceName"],
                serviceTelephoneNumber:
                    emergencyService["serviceTelephoneNumber"]))
          ],
        ),
      ),
    );
  }
}
