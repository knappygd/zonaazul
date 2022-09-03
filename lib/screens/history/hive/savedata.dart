import 'package:hive_flutter/adapters.dart';
import 'package:zonaazul/screens/history/hive/data.dart';

class SaveData {
  const SaveData();

  Future<int> saveData(Data data) async {
    final Box<Data> box = await Hive.openBox<Data>('Parking Data');
    return box.add(data);
  }

  Future<List<Data>> get parkingData async {
    final Box<Data> box = await Hive.openBox<Data>('Parking Data');
    return box.values.toList().reversed.toList();
  }
}
