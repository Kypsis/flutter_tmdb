import 'dart:math';

String intToDollars(int amount) {
  return "\$${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},")}";
}

int getRandomIndex(int max) {
  return Random().nextInt(max);
}
