import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'Companies.g.dart';

@HiveType(typeId: 1)
class Companies {
  Companies({
    required this.companyName,
    required this.companyId,
    required this.companyPassword,
  });

  @HiveField(0)
  String companyName;

  @HiveField(1)
  String companyId;

  @HiveField(2)
  String companyPassword;
}
