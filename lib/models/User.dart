class UserModel {
  String? uID;
  String? Name;
  String? Email;
  String? Phone;
  String? Address;
  String? Role;
  double? Point;

  UserModel({this.uID, this.Email, this.Name, this.Phone, this.Address, this.Role, this.Point});

  //get data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(
    uID: map['uID'],
    Name: map['Name'],
    Phone: map['Phone'],
    Email: map['Email'],
    Address: map['Address'],
        Role: map['Role'],
        Point: double.parse(map['Point'].toString())

    );
  }

  //send data to server
  Map<String, dynamic> toMap()
  {
    return {
      'uID':uID,
      'Name':Name,
      'Phone':Phone,
      'Email':Email,
      'Address':Address,
      'Role' : Role,
      'Point': Point
    };
  }

}