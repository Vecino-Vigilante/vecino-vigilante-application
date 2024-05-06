import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vecino_vigilante/models/complaint_model.dart';
import 'package:vecino_vigilante/models/enums/complaint_type_enum.dart';
import 'package:vecino_vigilante/utils/date_utils.dart';
import 'package:vecino_vigilante/widgets/custom_list_tile.dart';

IconData getIconByComplaintType(int complaintTypeId) {
  if (complaintTypeId == ComplaintTypeEnum.vehicularCrash.id) {
    return Icons.car_crash_sharp;
  } else if (complaintTypeId == ComplaintTypeEnum.suspiciousPerson.id) {
    return Icons.person_search_sharp;
  } else if (complaintTypeId == ComplaintTypeEnum.theft.id) {
    return Icons.run_circle_sharp;
  } else if (complaintTypeId == ComplaintTypeEnum.assault.id) {
    return Icons.local_police_sharp;
  } else {
    return Icons.local_police_sharp;
  }
}

class ComplaintCard extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintCard({
    super.key,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context.go("/complaints/${complaint.id}");
        },
        child: SizedBox(
          height: 86,
          child: Stack(
            children: [
              CustomListTile(
                leading: CircleAvatar(
                  child: Icon(getIconByComplaintType(complaint.typeId)),
                ),
                title: Text(
                  complaint.type,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${getSpanishDateFormat(complaint.date)}\n${complaint.location.direction}",
                  style: const TextStyle(height: 1.6),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  width: 90,
                  child: Image.network(
                    complaint.imageUrl,
                    fit: BoxFit.cover,
                    height: double.infinity,
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
