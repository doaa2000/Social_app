abstract class SocialRegisterStates {}

class SocialRegisterInitialStates extends SocialRegisterStates {}

class SocialRegisterloadingStates extends SocialRegisterStates {}

class SocialRegisterSuccessStates extends SocialRegisterStates {}

class SocialRegisterErrorStates extends SocialRegisterStates {
  String error;
  SocialRegisterErrorStates(this.error);
}

class SocialAppChangePasswordVisibility extends SocialRegisterStates {}

class SocialCreateUserSuccessStates extends SocialRegisterStates {}

class SocialCreateUserErrorStates extends SocialRegisterStates {
  String error;
  SocialCreateUserErrorStates(this.error);
}
