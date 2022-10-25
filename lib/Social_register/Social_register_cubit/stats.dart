abstract class SocialRegisterStat {}

class SocialRegisterIntialState extends SocialRegisterStat {}

class SocialRegisterLoadingState extends SocialRegisterStat {}

class SocialRegisterSucessState extends SocialRegisterStat {}

class SocialRegistererorState extends SocialRegisterStat {
  final String eror;

  SocialRegistererorState(this.eror);
}

class SocialRegisterChangPassState extends SocialRegisterStat {}

class SocialCreateRegisterSucessState extends SocialRegisterStat {}

class SocialCreateRegistererorState extends SocialRegisterStat {
  final String eror;

  SocialCreateRegistererorState(this.eror);
}
