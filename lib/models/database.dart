import 'package:mongo_dart/mongo_dart.dart';

class Database {
  static final Database _instance = Database._internal();
  Db? _db;

  factory Database() {
    return _instance;
  }

  Database._internal() {
    // mongodb://username:password@host:port/demo_kontak
    // mongodb://host:port/nama_db
    _db = Db(
        "mongodb://sudo:dhimasatha@localhost:27017/demo_kontak?authSource=admin");
  }

  Future<void> openConnection() async {
    await _db?.open();
  }

  Future<void> closeConnection() async {
    await _db?.close();
  }

  DbCollection? get kontak => _db?.collection("kontak");
}
