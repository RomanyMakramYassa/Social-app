abstract class SocialState {}

class SocialIntialState extends SocialState {}

class SocialGetuserLoadingState extends SocialState {}

class SocialGetuserSucceesState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String eror;

  SocialGetUserErrorState(this.eror);
}

class SocialGetalluserLoadingState extends SocialState {}

class SocialGetalluserSucceesState extends SocialState {}

class SocialGetallUserErrorState extends SocialState {
  final String eror;

  SocialGetallUserErrorState(this.eror);
}

class SocialChangeBottomNavState extends SocialState {}

class SocialAddNewPostState extends SocialState {}

class SociaprofileImagepackedSuccessState extends SocialState {}

class SociaprofileImagepackedErrorState extends SocialState {}

class SocialCoverImagepackedSuccessState extends SocialState {}

class SocialCoverImagepackedErrorState extends SocialState {}

class SocialuploadprofileImageSuccessState extends SocialState {}

class SocialuploadprofileImageErrorState extends SocialState {}

class SocialuploadCoverImageSuccessState extends SocialState {}

class SocialuploadCoverImageErrorState extends SocialState {}

class SocialuserupdateErrorState extends SocialState {}

class SocialuserupdateLoadingState extends SocialState {}

//createpost
class SocialCreatepostSuccessState extends SocialState {}

class SocialCreatepostErrorState extends SocialState {}

class SocialCreatepostLoadingState extends SocialState {}

class SocialPostImagepackedSuccessState extends SocialState {}

class SocialPostImagepackedErrorState extends SocialState {}

class SocialremovePostImageState extends SocialState {}

class SocialGetpostLoadingState extends SocialState {}

class SocialGetpostSucceesState extends SocialState {}

class SocialGetpostErrorState extends SocialState {
  final String eror;

  SocialGetpostErrorState(this.eror);
}

class SocialPostlikeSucceesState extends SocialState {}

class SocialPostlikeErrorState extends SocialState {
  final String eror;

  SocialPostlikeErrorState(this.eror);
}

class SocialPostcommentSucceesState extends SocialState {}

class SocialPostcommentErrorState extends SocialState {
  final String eror;

  SocialPostcommentErrorState(this.eror);
}
// chaat

class SocialSendMessageSucceesState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {}

class SocialGetMessageSucceesState extends SocialState {}

//class SocialGetMessageErrorState extends SocialState {}
