String capitalize(String text) {
  String t = text;
  final String up = text[0].toUpperCase();

  if (t.contains("_")) {
    t = text.replaceAll("_", " ");
    return t.replaceRange(0, 1, up);
  }

  return t.replaceRange(0, 1, up);
}
