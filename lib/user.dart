class User {
  int? id;
  late String name;
  late String sex;
  late double weight;
  late double height;
  late String bloodGroup;
  late String lastDonated;
  late String phone;
  late String location;

  User({
    this.id,
    required this.name,
    required this.sex,
    required this.weight,
    required this.height,
    required this.bloodGroup,
    required this.lastDonated,
    required this.phone,
    required this.location,
  });

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "name": name,
      "sex": sex,
      "weight": weight,
      "height": height,
      "bloodGroup": bloodGroup,
      "lastDonated": lastDonated,
      "phone": phone,
      "location": location,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
