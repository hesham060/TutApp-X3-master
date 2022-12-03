class LoginRequest {
  String email;
  String password;
  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String userName;
  String countryMobileCode;
  String mobileNumber;

  String email;
  String password;
  String profilePic;
  RegisterRequest(this.userName, this.countryMobileCode, this.mobileNumber,
      this.email, this.password, this.profilePic);
}
