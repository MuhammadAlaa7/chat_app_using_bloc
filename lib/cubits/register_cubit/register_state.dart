abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterFailureState extends RegisterStates {
  final String errorMessage;
  RegisterFailureState(this.errorMessage);
}
