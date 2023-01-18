class EditProfileModel {
  String profileImage;
  String uniqueId;
  String name;
  String aboutyou;
  String resume;
  List workExperience;
  List links;
  List contacts;
  List skills;
  String address;
  String uid;

  EditProfileModel(
      this.profileImage,
      this.uniqueId,
      this.name,
      this.aboutyou,
      this.resume,
      this.workExperience,
      this.links,
      this.contacts,
      this.skills,
      this.address,
      this.uid);

  Map<String,dynamic> toMap(){
    return {
      'profileImage': this.profileImage,
      'uniqueId': this.uniqueId,
      'name': this.name,
      'aboutyou': this.aboutyou,
      'resume': this.resume,
      'workExperience': this.workExperience,
      'links': this.links,
      'contacts': this.contacts,
      'skills': this.skills,
      'address': this.address,
      'uid': this.uid,
    };
  }

  factory EditProfileModel.fromjson(Map map){
    return EditProfileModel(map['profileImage'], map['uniqueId'], map['name'], map['aboutyou'], map['resume'],
        map['workExperience'], map['links'], map['contacts'], map['skills'], map['address'], map['uid']);
  }
}
