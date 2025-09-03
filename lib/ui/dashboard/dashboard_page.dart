import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/ui/widgets/header_txt_widget.dart';
import '../../Constant/color_const.dart';
import '../../services/route_generator.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  final _con = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: 'home',
        onGenerateRoute: onGenerateRoute,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.newspaper,
                color: primaryColorCode,
              ),
              icon: Icon(
                Icons.newspaper_rounded,
                color: color_B8B7C7,
              ),
              label: "Document",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.menu,
                color: primaryColorCode,
              ),
              icon: Icon(
                Icons.menu_outlined,
                color: color_B8B7C7,
              ),
              label: "More",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.support_agent, color: primaryColorCode),
              icon: Icon(Icons.support_agent, color: color_B8B7C7),
              label: "Help / Support",
            ),
          ],
          currentIndex: _con.currentIndex.value,
          onTap: (index) {
            _con.changePage(index); // Always go through controller
          },
          backgroundColor: Colors.white,
          unselectedItemColor: color_B8B7C7,
          selectedItemColor: primaryColorCode,
          iconSize: 24,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
