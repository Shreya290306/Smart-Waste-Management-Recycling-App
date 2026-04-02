import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/waste_request.dart';
import '../providers/app_provider.dart';

class SchedulePickupScreen extends StatefulWidget {
  const SchedulePickupScreen({super.key});

  @override
  State<SchedulePickupScreen> createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<SchedulePickupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'organic';
  DateTime _scheduledDate = DateTime.now().add(const Duration(days: 1));
  final TextEditingController _addressController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _scheduledDate) {
      setState(() {
        _scheduledDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text('Schedule a Waste Pickup', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Waste Category', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'organic', child: Text('Organic Waste')),
                DropdownMenuItem(value: 'plastic', child: Text('Plastic Waste')),
                DropdownMenuItem(value: 'e-waste', child: Text('E-Waste')),
              ],
              onChanged: (val) {
                setState(() { _category = val!; });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Pickup Address', border: OutlineInputBorder()),
              validator: (val) => val == null || val.isEmpty ? 'Please enter an address' : null,
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Scheduled Date: ${_scheduledDate.toLocal().toString().split(' ')[0]}'),
              trailing: ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select Date'),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final provider = context.read<AppProvider>();
                  final request = WasteRequest(
                    id: const Uuid().v4(),
                    category: _category,
                    scheduledDate: _scheduledDate,
                    address: _addressController.text,
                    isSynced: !provider.isOffline,
                  );
                  provider.addWasteRequest(request);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pickup scheduled! (+10 pts)')),
                  );
                  _addressController.clear();
                }
              },
              child: const Text('Schedule & Earn Points', style: TextStyle(fontSize: 18)),
            ),
            if (context.watch<AppProvider>().isOffline)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('Offline Mode: Request will be synced when you go online.', style: TextStyle(color: Colors.red)),
              )
          ],
        ),
      ),
    );
  }
}
