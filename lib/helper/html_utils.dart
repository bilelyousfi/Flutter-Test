

String stripHtml(String htmlString) {
  final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);
  return htmlString.replaceAll(exp, '').trim(); // Return plain text without HTML tags
}
