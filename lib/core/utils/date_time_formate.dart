import 'dart:developer';

import 'package:intl/intl.dart';

String? formatDateTime(String inputDateTime) {
  try {
    DateTime dateTime = DateFormat(
      "yyyy-MM-dd HH:mm:ss",
    ).parseStrict(inputDateTime);

    return DateFormat("MMM dd yyyy hh:mm a").format(dateTime);
  } catch (e) {
    log("Invalid date format: $e");
    return null;
  }
}
