import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

// here with baseResponse class no need constructor otherwise he will ask you things

// to Apply from from json & tojson very easy1
@JsonSerializable()
class BaseResponse {
  @JsonKey(
      name:
          "status") // we are use JsonKey when we need to change name of api variable with new name
  int? status; // because this value coming from api so we add ? sign
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;
  CustomerResponse(this.id, this.name, this.numOfNotifications);
  // from Json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  // tojson
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  ContactsResponse(this.phone, this.email, this.link);
  // from Json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  // tojson
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationResponse(this.customer, this.contacts);
  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  ForgotPasswordResponse(this.support);
//fromJson
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
  // toJson
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}
