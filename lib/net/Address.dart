/*
 * ====================================================
 * package   : net
 * author    : Created by nansi.
 * time      : 2019/3/14  3:20 PM
 * remark    :
 * ====================================================
 */
class Address {
  static const String host = "http://api.green.akuhome.com/";
//  static const String host = "http://school.loseget.cn:10050/";
  static const String test_host = "http://192.168.31.114:23000/";
  static String pic_prefix;
  static String currentHost;

  static bool isTest = true;

  //http://api.green.akuhome.com/api/picture/Resize/
  static toggleEnvironment(isTest) {
    currentHost = isTest ? test_host : host;
    initAddress();
    pic_prefix = "${currentHost}api/picture/Resize/";
  }

  static initAddress() {
    UserAddress.initAddress();
    HomeAddress.initAddress();
    NewsAddress.initAddress();
  }
}

class UserAddress {
  static String prefix;
  static String sendSms;
  static String autoLogin;      ///cellphone    studentNumber   smsCode
  static String login;      ///cellphone    studentNumber   smsCode
  static String activities;
  static String payInfo;
  static String verifyOderPayStatus;
  static String parentBook;
  static String signUp;
  static String signUpProgress;

  static initAddress() {
    prefix = "${Address.currentHost}api/v1/User/";
    sendSms = "${Address.currentHost}api/v1/Sms/SendSms/Send";
    login =  "${prefix}Login/Login";
    autoLogin =  "${prefix}Login/AutoLogin";
    activities = "${prefix}Home/Activities";
    payInfo = "${prefix}Pay/PayActivity";
    verifyOderPayStatus = "${prefix}Pay/PayCheck";
    parentBook = "${prefix}Home/Activity/ParentBook";
    signUp = "${prefix}Home/Register";
    signUpProgress = "${prefix}Home/Progress";
  }
}

class HomeAddress {
  static String prefix;
  static String payList;
  static String score;

  static initAddress() {
    prefix = "${Address.currentHost}api/v1/User/Home";
    payList = "$prefix/PayList";
    score = "$prefix/Score";
  }
}

class NewsAddress {
  static String prefix;
  static String newsList;
  static String news_prefix;

  static initAddress() {
    prefix = "${Address.currentHost}api/v1/News";
    newsList = "$prefix/Manage/List";
    news_prefix = "$prefix/Manage/Article/";
  }
}
