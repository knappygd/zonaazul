import 'package:hive_flutter/adapters.dart';

part 'data.g.dart';

@HiveType(typeId: 0)
class Data extends HiveObject {
  Data({required this.date, required this.lapse, required this.time});

  @HiveField(0)
  late String time;

  @HiveField(1)
  late String date;

  @HiveField(2)
  late String lapse;
}
