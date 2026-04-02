import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'auth_screen.dart';

class AuthorityDashboard extends StatelessWidget {
  const AuthorityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authority Dashboard'),
        backgroundColor: Colors.green[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AuthScreen()));
            },
          )
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          final pending = provider.pendingRequests;
          final all = provider.requests;
          final collected = all.length - pending.length;
          
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(child: _StatCard(title: 'Pending', count: pending.length, color: Colors.orange)),
                    const SizedBox(width: 10),
                    Expanded(child: _StatCard(title: 'Collected', count: collected, color: Colors.green)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Collection Requests', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ElevatedButton.icon(
                      onPressed: pending.isEmpty ? null : () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Routes optimized! Drivers have been notified.')));
                      },
                      icon: const Icon(Icons.directions_car),
                      label: const Text('Optimize Routes'),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: pending.isEmpty 
                    ? const Center(child: Text('No pending requests. All clear!')) 
                    : ListView.builder(
                        itemCount: pending.length,
                        itemBuilder: (context, index) {
                          final req = pending[index];
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.location_on, color: Colors.red),
                              title: Text('${req.category.toUpperCase()} Pickup'),
                              subtitle: Text('${req.address}\nScheduled: ${req.scheduledDate.toLocal().toString().split(' ')[0]}'),
                              isThreeLine: true,
                              trailing: IconButton(
                                icon: const Icon(Icons.check_circle, color: Colors.green, size: 30),
                                onPressed: () {
                                  provider.markCollected(req.id);
                                },
                              ),
                            ),
                          );
                        },
                    ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int count;
  final MaterialColor color;

  const _StatCard({required this.title, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withAlpha(50),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('$count', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color[900])),
          ],
        ),
      ),
    );
  }
}
