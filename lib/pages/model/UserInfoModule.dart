class UserInfoModel {
  int resultCode;
  bool success;
  String message;
  UserInfoItemModel data;

  UserInfoModel({this.resultCode, this.success, this.message, this.data});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new UserInfoItemModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserInfoItemModel {
  String id;
  int grade;
  String numPhone;
  String userName;
  String userPass;
  String email;
  String about;
  String createTime;
  String headPic;
  int freeCount;
  bool enable;
  int vipDay;
  String vipBeginTime;
  String vipEndTime;
  int fansCount;
  int attentionCount;

  UserInfoItemModel({
    this.id,
    this.grade,
    this.numPhone,
    this.userName,
    this.userPass,
    this.email,
    this.about,
    this.createTime,
    this.headPic,
    this.freeCount,
    this.enable,
    this.vipDay,
    this.vipBeginTime,
    this.vipEndTime,
    this.fansCount,
    this.attentionCount,
  });

  UserInfoItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grade = json['grade'];
    numPhone = json['numPhone'];
    userName = json['userName'];
    userPass = json['userPass'];
    email = json['email'];
    about = json['about'];
    createTime = json['createTime'];
    headPic = json['headPic'];
    freeCount = json['freeCount'];
    enable = json['enable'];
    vipDay = json['vipDay'];
    vipBeginTime = json['vipBeginTime'];
    vipEndTime = json['vipEndTime'];
    fansCount = json['fansCount'];
    attentionCount = json['attentionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? "";
    data['grade'] = this.grade ?? 0;
    data['numPhone'] = this.numPhone ?? "";
    data['userName'] = this.userName ?? "";
    data['userPass'] = this.userPass ?? "";
    data['email'] = this.email ?? "";
    data['about'] = this.about ?? "";
    data['createTime'] = this.createTime ?? "";
    data['headPic'] = this.headPic ?? "";
    data['freeCount'] = this.freeCount ?? 0;
    data['enable'] = this.enable ?? false;
    data['vipDay'] = this.vipDay ?? 0;
    data['vipBeginTime'] = this.vipBeginTime ?? "";
    data['vipEndTime'] = this.vipEndTime ?? "";
    data['fansCount'] = this.fansCount ?? 0;
    data['attentionCount'] = this.attentionCount ?? 0;
    return data;
  }
}
