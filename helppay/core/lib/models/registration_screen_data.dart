class RegistrationScreenData {
  String? email;
  String? login;
  String? password;
  bool? isSendCodeSMS;
  String? phone;
  String? fio;

  RegistrationScreenData({
    this.email,
    this.password,
    this.isSendCodeSMS,
    this.phone,
    this.fio,
  });

  @override
  String toString() =>
      'RegistrationScreenData{ email: $email, email: $login, password: $password, isSendCodeSMS: $isSendCodeSMS, phone: $phone, fio:$fio}';
}
