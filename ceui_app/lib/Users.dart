import 'package:hive/hive.dart';

part 'Users.g.dart';

@HiveType(typeId: 2)
class Users {
  Users(
      {required this.usUserName,
      required this.usPassword,
      required this.usName,
      required this.usLastName,
      required this.compID,
      required this.isAdmin});

  @HiveField(0)
  String usUserName;

  @HiveField(1)
  String usPassword;

  @HiveField(2)
  String usName;

  @HiveField(3)
  String usLastName;

  @HiveField(4)
  String compID;

  @HiveField(5)
  bool isAdmin;
}
