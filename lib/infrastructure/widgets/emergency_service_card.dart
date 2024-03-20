import 'package:flutter/material.dart';

class EmergencyServiceCard extends StatelessWidget {
  final String serviceDescription;
  final IconData serviceIcon;
  final String serviceName;
  final String serviceTelephoneNumber;

  const EmergencyServiceCard(
      {super.key,
      required this.serviceDescription,
      required this.serviceIcon,
      required this.serviceName,
      required this.serviceTelephoneNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Icon(
                  serviceIcon,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(serviceName),
                Text(serviceDescription),
              ],
            ),
          ),
          const Divider(),
          Text(serviceTelephoneNumber)
        ],
      ),
    );
  }
}
