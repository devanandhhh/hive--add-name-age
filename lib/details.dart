import 'package:hive_flutter/adapters.dart';
part 'details.g.dart';
@HiveType(typeId:1)
class Details {
  @HiveField(0)
  String name;  
  @HiveField(1)
  int age;
  Details({required this.name,required this.age});
}