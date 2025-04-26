// sidebar_view_model.dart (updated)
import 'package:flutter/material.dart';

class SidebarViewModel extends ChangeNotifier {
  String _selectedMenu = "Dashboard";
  String _expandedMenu = "";
  String _hoveredMenu = "";

  String get selectedMenu => _selectedMenu;
  String get expandedMenu => _expandedMenu;
  String get hoveredMenu => _hoveredMenu;

  void setSelectedMenu(String menu) {
    _selectedMenu = menu;
    notifyListeners();
  }

  void toggleMenu(String menu) {
    _expandedMenu = _expandedMenu == menu ? "" : menu;
    notifyListeners();
  }

  void setExpandedMenu(String menu) {
    _expandedMenu = menu;
    notifyListeners();
  }

  void setHoveredMenu(String menu) {
    _hoveredMenu = menu;
    notifyListeners();
  }
}
