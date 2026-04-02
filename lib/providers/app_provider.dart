import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/waste_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider with ChangeNotifier {
  late Box<WasteRequest> _wasteBox;
  String _userRole = 'citizen'; // citizen or authority
  int _rewardPoints = 0;
  bool _isOffline = false;

  String get userRole => _userRole;
  int get rewardPoints => _rewardPoints;
  bool get isOffline => _isOffline;
  
  List<WasteRequest> get requests => _wasteBox.values.toList();
  List<WasteRequest> get pendingRequests => _wasteBox.values.where((r) => r.status == 'pending').toList();

  AppProvider() {
    _init();
  }

  Future<void> _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _rewardPoints = prefs.getInt('points') ?? 0;
    _wasteBox = Hive.box<WasteRequest>('wasteRequests');
    notifyListeners();
  }

  Future<void> setRole(String role) async {
    _userRole = role;
    notifyListeners();
  }

  Future<void> setOfflineMode(bool offline) async {
    _isOffline = offline;
    if (!offline) {
      await _syncRequests();
    }
    notifyListeners();
  }

  Future<void> addWasteRequest(WasteRequest request) async {
    request.isSynced = !_isOffline;
    await _wasteBox.put(request.id, request);
    if (!request.isSynced) {
      // It's offline, wait for sync later
    } else {
      // Simulate backend call
      await Future.delayed(const Duration(milliseconds: 500));
    }
    await _addPoints(10); // Reward for scheduling
    notifyListeners();
  }

  Future<void> markCollected(String id) async {
    final req = _wasteBox.get(id);
    if (req != null) {
      req.status = 'collected';
      await _wasteBox.put(id, req);
      notifyListeners();
    }
  }

  Future<void> _addPoints(int points) async {
    _rewardPoints += points;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('points', _rewardPoints);
    notifyListeners();
  }

  Future<void> _syncRequests() async {
    // Simulate syncing offline requests
    final offlineReqs = _wasteBox.values.where((r) => !r.isSynced).toList();
    for (var r in offlineReqs) {
      r.isSynced = true;
      await r.save();
    }
    notifyListeners();
  }
}
