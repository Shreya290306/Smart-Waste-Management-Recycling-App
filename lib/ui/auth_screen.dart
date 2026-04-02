import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'citizen_dashboard.dart';
import 'authority_dashboard.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF81C784), Color(0xFF388E3C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.recycling, size: 100, color: Colors.white),
                const SizedBox(height: 20),
                const Text('GreenCity', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                const Text('Smart Waste Management', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 60),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green[800],
                    minimumSize: const Size(200, 50),
                  ),
                  onPressed: () {
                    context.read<AppProvider>().setRole('citizen');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CitizenDashboard()));
                  },
                  child: const Text('Login as Citizen', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[900],
                    foregroundColor: Colors.white,
                    minimumSize: const Size(200, 50),
                  ),
                  onPressed: () {
                    context.read<AppProvider>().setRole('authority');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AuthorityDashboard()));
                  },
                  child: const Text('Login as Authority', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
