/// All spacing values used in the app come from here.
/// Covers both horizontal gaps (between items in a row)
/// and vertical gaps (between sections on a screen).
/// Never hardcode a spacing value inline in a widget.
class AppSpacing {
  AppSpacing._();

  // Horizontal gaps
  static const double xSmall   = 4.0;
  static const double small    = 8.0;
  static const double medium   = 16.0;
  static const double large    = 24.0;
  static const double xLarge   = 32.0;

  // Vertical section gaps
  static const double sectionGapSmall  = 12.0;
  static const double sectionGapMedium = 24.0;
  static const double sectionGapLarge  = 40.0;

  // Card / container padding
  static const double cardPadding    = 16.0;
  static const double screenPadding  = 20.0;
}
