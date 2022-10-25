abstract class SocialLoginStat {}

class SocialLoginIntialState extends SocialLoginStat {}

class SocialLoginLoadingState extends SocialLoginStat {}

class SocialLoginSucessState extends SocialLoginStat {
  final String uId;

  SocialLoginSucessState(this.uId);
}

class SocialLoginerorState extends SocialLoginStat {
  final String eror;
  SocialLoginerorState(this.eror);
}

class SocialLoginChangPassState extends SocialLoginStat {}
