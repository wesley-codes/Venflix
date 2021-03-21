

getImagePoster(String poster) {
  return "https://image.tmdb.org/t/p/original/$poster";
}

getDuration(int min) {
  final double convertToHrs = (min / 60);
  var convertToHoursExponent = convertToHrs.toStringAsFixed(0);
  var convertToHoursRemove = convertToHoursExponent.substring(0);
  final String convertToHoursAsString = convertToHoursRemove.toString();
  var arr = convertToHoursAsString.split("0");
  final int convertToMinutes = min % 60;
  return "${arr[0].toString().padLeft(2) + "h"} ${convertToMinutes.toString().padLeft(2, "0") + "min"}";
}
