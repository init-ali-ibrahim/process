String pluralize(int count, String one, String few, String many) {
  int lastTwoDigits = count % 100;
  int lastDigit = count % 10;

  if (lastTwoDigits >= 11 && lastTwoDigits <= 14) {
    return '$count $many';
  }

  if (lastDigit == 1) {
    return '$count $one';
  }

  if (lastDigit >= 2 && lastDigit <= 4) {
    return '$count $few';
  }

  return '$count $many';
}