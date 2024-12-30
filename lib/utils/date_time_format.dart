import 'package:intl/intl.dart';

class DateTimeFormat {
  static String formatDateTime(String input) {
    // Extract date and time parts from the string
    final datePart = input.split(' ')[0];
    final timePart =
        input.substring(input.indexOf('TimeOfDay(') + 10, input.indexOf(')'));

    // Parse the extracted parts
    DateTime parsedDate = DateTime.parse(datePart);
    List<String> timeParts = timePart.split(':');
    parsedDate = parsedDate.add(Duration(
        hours: int.parse(timeParts[0]), minutes: int.parse(timeParts[1])));

    // Get current date to compare
    DateTime now = DateTime.now();

    // Check if the date is today
    bool isToday = parsedDate.year == now.year &&
        parsedDate.month == now.month &&
        parsedDate.day == now.day;

    // Format the output
    String formattedTime =
        DateFormat.jm().format(parsedDate); // Format time as AM/PM
    return isToday
        ? 'Today at $formattedTime'
        : '${DateFormat.yMMMd().format(parsedDate)} at $formattedTime';
  }
}
