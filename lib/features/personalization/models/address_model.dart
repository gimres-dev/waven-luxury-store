import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  String name;
  String phoneNumber;
  String street;
  String city;
  String state;
  String postalCode;
  String country;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.selectedAddress = false,
  });

  static AddressModel empty() => AddressModel(
        id: '',
        name: '',
        phoneNumber: '',
        street: '',
        city: '',
        state: '',
        postalCode: '',
        country: '',
      );

  String get formattedAddress =>
      '$street, $city, $state $postalCode, $country';

  Map<String, dynamic> toJson() => {
        'Name': name,
        'PhoneNumber': phoneNumber,
        'Street': street,
        'City': city,
        'State': state,
        'PostalCode': postalCode,
        'Country': country,
        'SelectedAddress': selectedAddress,
      };

  factory AddressModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AddressModel(
      id: document.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      selectedAddress: data['SelectedAddress'] ?? false,
    );
  }
}
