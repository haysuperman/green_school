/*
 * ====================================================
 * package   : net
 * author    : Created by nansi.
 * time      : 2019/3/21  4:25 PM 
 * remark    : 
 * ====================================================
 */

class ResultData {
  var data;
  bool result;
  int code;
  var headers;

  ResultData(this.data, this.result, this.code, {this.headers});
}
