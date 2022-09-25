abstract class SocialLoginStates {}

class SocialInitialStates extends SocialLoginStates {}

class SocialloadingStates extends SocialLoginStates {}

class SocialLoginSuccessStates extends SocialLoginStates {
  String uId;
  SocialLoginSuccessStates(this.uId);
}

class SocialLoginErrorStates extends SocialLoginStates {
  String error;
  SocialLoginErrorStates(this.error);
}

class SocialAppChangePasswordVisibility extends SocialLoginStates {}
