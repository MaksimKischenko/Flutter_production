enum AppFlavour {
  full, helppay, mdom
}

extension AppFlavourExtension on AppFlavour {
  static const _mapNameToFlavour = <String, AppFlavour>{
    'full': AppFlavour.full,
    'helppay': AppFlavour.helppay,
    'mdom': AppFlavour.mdom,
  };

  static AppFlavour fromName(String value) => _mapNameToFlavour[value]
      ?? AppFlavour.mdom;
}