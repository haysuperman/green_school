import 'dart:io';

main() {

  var file = File.fromUri(Uri.parse("${Uri.base}static/font/iconfont.css"));
  var fileOut = File.fromUri(Uri.parse("${Uri.base}lib/utils/GSImageResource.dart"));

  var read = file.readAsStringSync();
  var originRead = fileOut.readAsStringSync();

  var result = originRead;
  result += """
  
  
class GSIcon {
  GSIcon._();
""";

  var split = read.split(".icon");
  split.forEach((str) {
    if (str.contains("before")) {
      var split = str.split(":");
      result += "  static const IconData " +
          split[0].replaceAll("-", "_") +
          " = const IconData(" +
          split[2].replaceAll("\"\\", "0x").split("\"")[0] +
          ", fontFamily: \"GSIcon\");\n";
    }
  });
  result+="}";
  fileOut.writeAsStringSync(result);
}