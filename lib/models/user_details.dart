class UserDetails {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  UserDetails({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
  });
  Map<String, dynamic> getJson()=>{
    "firstName":firstName,
    "lastName":lastName,
    "phone":phone,
    "email":email,
  };
}
