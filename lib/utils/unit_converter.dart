class UnitConverter {
  // Weight conversions
  static double kgToLbs(double kg) => kg * 2.20462;
  static double lbsToKg(double lbs) => lbs / 2.20462;

  // Height conversions
  static double cmToInches(double cm) => cm / 2.54;
  static double inchesToCm(double inches) => inches * 2.54;

  // Formatting
  static String formatWeight(double weight, bool isKg) {
    return '${weight.toStringAsFixed(1)} ${isKg ? 'kg' : 'lbs'}';
  }

  static String formatHeight(double height, bool isCm) {
    if (isCm) {
      return '${height.toStringAsFixed(0)} cm';
    } else {
      // Convert to feet and inches
      final totalInches = height;
      final feet = (totalInches / 12).floor();
      final inches = (totalInches % 12).round();
      return '$feet\'$inches"';
    }
  }

  // Get display weight (converts from stored kg if needed)
  static double getDisplayWeight(double storedKg, bool displayInKg) {
    return displayInKg ? storedKg : kgToLbs(storedKg);
  }

  // Get display height (converts from stored cm if needed)
  static double getDisplayHeight(double storedCm, bool displayInCm) {
    return displayInCm ? storedCm : cmToInches(storedCm);
  }

  // Convert display weight to storage format (kg)
  static double toStorageWeight(double displayWeight, bool isKg) {
    return isKg ? displayWeight : lbsToKg(displayWeight);
  }

  // Convert display height to storage format (cm)
  static double toStorageHeight(double displayHeight, bool isCm) {
    return isCm ? displayHeight : inchesToCm(displayHeight);
  }
}
