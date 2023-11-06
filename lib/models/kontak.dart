import 'package:mongo_dart/mongo_dart.dart';

class Kontak {
  final String? id;
  final String? name;
  final String? phoneNumber; // 08xxxx
  final String? email;
  final String? address;

  Kontak({this.id, this.name, this.phoneNumber, this.email, this.address});

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "address": address,
    };
  }

  ModifierBuilder toUpdateData() {
    final kontakMap = toMap();
    var updateData = ModifierBuilder();

    for (var kontakKey in kontakMap.keys) {
      if (kontakKey == '_id') continue;
      updateData.set(kontakKey, kontakMap[kontakKey]);
    }

    return updateData;
  }

  factory Kontak.fromMap(Map<String, dynamic> map, String id) {
    return Kontak(
      id: id,
      name: map["name"],
      phoneNumber: map["phoneNumber"],
      email: map["email"],
      address: map["address"],
    );
  }
}
