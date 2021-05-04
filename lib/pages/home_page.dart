import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/pages/directions_page.dart';
import 'package:qr_reader_app/pages/map_page.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/providers/ui_provider.dart';
import 'package:qr_reader_app/widgets/custom_navigatorbar.dart';
import 'package:qr_reader_app/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("History"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteAll();
              })
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    final currentIndex = uiProvider.selectedMenuOption;

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return MapPage();
        break;
      case 1:
        scanListProvider.loadScansByType('http');
        return DirectionsPage();
      default:
        return MapPage();
    }
  }
}
