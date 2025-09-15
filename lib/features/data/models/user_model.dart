import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba_dvp/features/data/models/address_model.dart';

class UserModel {
  final String? id;
  final String name;
  final String lastName;
  final DateTime birthDate;
  final List<AddressModel> addresses;

  UserModel({
    this.id,
    required this.name,
    required this.lastName,
    required this.birthDate,
    required this.addresses,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var addressesData = json['addresses'];
    List<AddressModel> addressesList = [];
    if (addressesData is Map<String, dynamic>) {
      addressesList = addressesData.values.map((addressJson) {
        return AddressModel.fromJson(addressJson as Map<String, dynamic>);
      }).toList();
    } else if (addressesData is List) {
      addressesList = addressesData.where((addressJson) {
        return addressJson is Map<String, dynamic>;
      }).map((addressJson) {
        return AddressModel.fromJson(addressJson as Map<String, dynamic>);
      }).toList(); 
    }

    dynamic birthDateData = json['birthdate'];
    DateTime birthDate;
    if (birthDateData is Timestamp) {
      birthDate = birthDateData.toDate();
    } else if (birthDateData is String) {
      birthDate = DateTime.parse(birthDateData);
    } else {
      birthDate = DateTime(1970);
    }

    return UserModel(
      name: json['name'],
      lastName: json['lastname'],
      birthDate: birthDate,
      addresses: addressesList,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final user = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);

    return UserModel(
      id: snapshot.id,
      name: user.name,
      lastName: user.lastName,
      birthDate: user.birthDate,
      addresses: user.addresses,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> addressesMap = {};
    for (int i = 0; i < addresses.length; i++) {
      addressesMap['address${i + 1}'] = addresses[i].toJson();
    }
    return {
      'name': name,
      'lastname': lastName,
      'birthdate': Timestamp.fromDate(birthDate),
      'addresses': addressesMap,
    };
  }
}