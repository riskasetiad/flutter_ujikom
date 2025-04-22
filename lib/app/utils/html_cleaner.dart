import 'package:html/parser.dart' as htmlParser;

String parseHtmlString(String htmlString) {
  final document = htmlParser.parse(htmlString);
  return document.body?.text ?? '';
}
