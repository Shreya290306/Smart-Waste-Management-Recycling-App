import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'schedule_pickup_screen.dart';
import 'guidance_screen.dart';
import 'map_screen.dart';
import 'auth_screen.dart';

class CitizenDashboard extends StatefulWidget {
  const CitizenDashboard({super.key});

  @override
  State<CitizenDashboard> createState() => _CitizenDashboardState();
}

class _CitizenDashboardState extends State<CitizenDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _HomeTab(),
    const SchedulePickupScreen(),
    const GuidanceScreen(),
    const MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Dashboard'),
        actions: [
          Consumer<AppProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                   Switch(
                    value: provider.isOffline,
                    onChanged: (val) => provider.setOfflineMode(val),
                    activeColor: Colors.red,
                  ),
                  const Text('Offline Mode'),
                  const SizedBox(width: 10),
                  Chip(
                    avatar: const Icon(Icons.star, color: Colors.amber, size: 20),
                    label: Text('${provider.rewardPoints} pts'),
                  ),
                  const SizedBox(width: 10),
                ],
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AuthScreen()));
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) {
          setState(() {
            _currentIndex = idx;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Schedule'),
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'Guide'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        final requests = provider.requests;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.green[100],
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text('Your Total Reward Points', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 10),
                      Text('${provider.rewardPoints}', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green)),
                      const Text('Keep up the good work!', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Recent Pickups', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: requests.isEmpty ? const Center(child: Text('No pickups scheduled yet.')) : ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final req = requests[index];
                    return ListTile(
                      leading: Icon(
                        req.category == 'organic' ? Icons.eco : req.category == 'plastic' ? Icons.recycling : Icons.computer,
                        color: req.status == 'collected' ? Colors.grey : Colors.green,
                      ),
                      title: Text('${req.category.toUpperCase()} Waste'),
                      subtitle: Text('${req.scheduledDate.toLocal().toString().split(' ')[0]} - ${req.status.toUpperCase()}'),
                      trailing: Icon(req.isSynced ? Icons.cloud_done : Icons.cloud_off, color: req.isSynced ? Colors.green : Colors.red),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
