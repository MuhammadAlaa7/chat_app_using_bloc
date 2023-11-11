
class AuthStates {}

 class AuthInitialState extends AuthStates {}


 /// states of login 
class LoginSuccessState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginFailureState extends AuthStates {
  final String errorMessage;
  LoginFailureState(this.errorMessage);
}

/// states of register
class RegisterSuccessState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterFailureState extends AuthStates {
  final String errorMessage;
  RegisterFailureState(this.errorMessage);
}
