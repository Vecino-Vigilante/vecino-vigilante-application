import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vecino_vigilante/dto/complaint_dto.dart';
import 'package:vecino_vigilante/enums/complaint_type_enum.dart';
import 'package:vecino_vigilante/utils/date_utils.dart';
import 'package:vecino_vigilante/widgets/custom_list_tile.dart';

IconData getIconByComplaintType(String complaintTypeId) {
  String cleanComplaintTypeId = complaintTypeId.replaceAll('-', "");

  if (cleanComplaintTypeId == ComplaintTypeEnum.vehicularCrash.id) {
    return Icons.car_crash_sharp;
  } else if (cleanComplaintTypeId == ComplaintTypeEnum.suspiciousPerson.id) {
    return Icons.person_search_sharp;
  } else if (cleanComplaintTypeId == ComplaintTypeEnum.vandalism.id) {
    return Icons.sports_hockey_sharp;
  } else if (cleanComplaintTypeId == ComplaintTypeEnum.fire.id) {
    return Icons.local_fire_department_sharp;
  } else if (cleanComplaintTypeId == ComplaintTypeEnum.theft.id) {
    return Icons.run_circle_sharp;
  } else if (cleanComplaintTypeId == ComplaintTypeEnum.assault.id) {
    return Icons.local_police_sharp;
  } else {
    return Icons.local_police_sharp;
  }
}

Color getColorByComplaintType(String complaintTypeId) {
  String cleanComplaintTypeId = complaintTypeId.replaceAll('-', "");

  if (cleanComplaintTypeId == ComplaintTypeEnum.vehicularCrash.id) {
    return Colors.orange.shade600;
  } else if (cleanComplaintTypeId == ComplaintTypeEnum.suspiciousPerson.id) {
    return Colors.grey.shade400;
  } else if (cleanComplaintTypeId == ComplaintTypeEnum.vandalism.id) {
    return Colors.green.shade400;
  } else if (cleanComplaintTypeId == ComplaintTypeEnum.fire.id) {
    return Colors.red.shade400;
  } else if (cleanComplaintTypeId == ComplaintTypeEnum.theft.id) {
    return Colors.teal.shade400;
  } else if (cleanComplaintTypeId == ComplaintTypeEnum.assault.id) {
    return Colors.white;
  } else {
    return Colors.grey.shade400;
  }
}

class ComplaintCard extends StatelessWidget {
  final ComplaintDTO complaint;

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
          context.push("/complaints/${complaint.id}");
        },
        child: SizedBox(
          height: 86,
          child: Stack(
            children: [
              CustomListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      getColorByComplaintType(complaint.type?.id ?? ""),
                  child: Icon(
                    getIconByComplaintType(complaint.type?.id ?? ""),
                  ),
                ),
                title: Text(
                  complaint.type?.name ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getSpanishDateFormat(complaint.date ?? DateTime.now()),
                      style: const TextStyle(height: 1.6),
                    ),
                    SizedBox(
                      width: 287,
                      child: Text(
                        complaint.location?.direction ?? "",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
