import 'package:flutter/material.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:qr_reader_app/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  Future<ScanModel> createScan(String value) async {
    final newScan = new ScanModel(value: value);
    final id = await DBProvider.db.createScan(newScan);
    newScan.id = id;

    if (this.selectedType == newScan.type) {
      this.scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  loadScans() async {
    final res = await DBProvider.db.getAllScans();
    scans = [...res];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final res = await DBProvider.db.getScansByType(type);
    scans = [...res];
    this.selectedType = type;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}
