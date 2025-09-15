class AddressModel {
  final String country;
  final String state;
  final String city;

  AddressModel({
    required this.country,
    required this.state,
    required this.city,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      country: json['country'],
      state: json['state'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'state': state,
      'city': city,
    };
  }
}
