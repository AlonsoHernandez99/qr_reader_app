import 'package:flutter/material.dart';
import 'package:qr_reader_app/widgets/scan_tiles.dart';

class DirectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScanTiles(type: 'geo');
}
