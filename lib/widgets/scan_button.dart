import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
             '#3D8BEF', 'Cancel', false, ScanMode.QR);
        // String barcodeScanRes = "https://pub.dev/packages/url_launcher";
        //String barcodeScanRes = "geo:14.009384,-89.192848";

        if (barcodeScanRes == '-1') return;
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final newScan = await scanListProvider.createScan(barcodeScanRes);

        launchURL(context, newScan);
      },
      child: Icon(Icons.filter_center_focus),
    );
  }
}
