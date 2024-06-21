import 'package:d_chart/d_chart.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todos_app/components/custom_app_bar.dart';
import 'package:todos_app/utils/color_palette.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return ListView(
      children: [
        AspectRatio(
          aspectRatio: 12 / 9,
          child: DChartBarO(
            groupList: [
              OrdinalGroup(
                id: '1',
                data: [
                  OrdinalData(domain: 'Mon', measure: 2),
                  OrdinalData(domain: 'Tue', measure: 6),
                  OrdinalData(domain: 'Wed', measure: 3),
                  OrdinalData(domain: 'Thu', measure: 7),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
