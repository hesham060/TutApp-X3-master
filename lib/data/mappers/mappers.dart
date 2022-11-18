import 'package:firstproject/app/constants.dart';
import 'package:firstproject/data/response/responses.dart';
import 'package:firstproject/domain/models/models.dart';
import 'package:firstproject/app/extensions.dart';

// mapper it means the channel between data,domain layer
// the idea change CustomerResponse to customer object
extension CustomerResponseMapper on CustomerResponse? {
  Customers toDomain() {
    return Customers(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}
