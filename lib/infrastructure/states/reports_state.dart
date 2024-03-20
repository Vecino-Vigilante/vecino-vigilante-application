import 'package:flutter/material.dart';
import 'package:vecino_vigilante/domain/models/report_model.dart';

class ReportsState extends ChangeNotifier {
  List<ReportModel> _reports = [];

  List<ReportModel> get reports {
    return _reports;
  }

  set reports(List<ReportModel> reports) {
    _reports = reports;
    notifyListeners();
  }
}
