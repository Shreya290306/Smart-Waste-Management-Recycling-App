import 'package:hive/hive.dart';

class WasteRequest extends HiveObject {
  final String id;
  final String category; // organic, plastic, e-waste
  final DateTime scheduledDate;
  final String address;
  bool isSynced;
  String status; // pending, collected

  WasteRequest({
    required this.id,
    required this.category,
    required this.scheduledDate,
    required this.address,
    this.isSynced = false,
    this.status = 'pending',
  });
}

class WasteRequestAdapter extends TypeAdapter<WasteRequest> {
  @override
  final int typeId = 0;

  @override
  WasteRequest read(BinaryReader reader) {
    return WasteRequest(
      id: reader.readString(),
      category: reader.readString(),
      scheduledDate: DateTime.parse(reader.readString()),
      address: reader.readString(),
      isSynced: reader.readBool(),
      status: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, WasteRequest obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.category);
    writer.writeString(obj.scheduledDate.toIso8601String());
    writer.writeString(obj.address);
    writer.writeBool(obj.isSynced);
    writer.writeString(obj.status);
  }
}
