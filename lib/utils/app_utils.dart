class AppUtils {
  static String normalizePhoneNumber(String number) {
    if (number.isEmpty) return "";
    number = number.replaceAll("[0-9]", "");
    if (number.substring(0, 1).compareTo("0") == 0 &&
        number.substring(1, 2).compareTo("0") != 0) {
      number = number.substring(1);
    } else if (number.length < 10) {
      number = number;
    }

    if (number.startsWith("+233")) number = number.replaceFirst("+233", "");
    number = number.replaceAll("^[0]{1,4}", "");
    return number;
  }
}
