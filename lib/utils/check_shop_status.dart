import 'package:intl/intl.dart';

String checkShopStatus(String openingTime, String closingTime) {
  DateFormat format = DateFormat("hh:mm a");
  DateTime now = DateTime.now();

  // Parse opening and closing times
  DateTime opening = format.parse(openingTime);
  DateTime closing = format.parse(closingTime);

  // Set the parsed times to today
  opening = DateTime(
    now.year,
    now.month,
    now.day,
    opening.hour,
    opening.minute,
  );
  closing = DateTime(
    now.year,
    now.month,
    now.day,
    closing.hour,
    closing.minute,
  );

  // If the closing time is earlier in the day than the opening time, it means the shop closes past midnight
  if (closing.isBefore(opening)) {
    closing = closing.add(Duration(days: 1)); // Add one day to closing time
  }

  // Check if the current time is within the opening and closing hours
  if (now.isAfter(opening) && now.isBefore(closing)) {
    return "Open";
  } else {
    return "Closed";
  }
}
