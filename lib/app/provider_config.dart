class ProviderConfig {
  const ProviderConfig._();

  static const apiVersion = 'v1beta';
  static const endpoint = 'https://generativelanguage.googleapis.com';
  static const model = 'gemini-flash-latest';
  static const responseSchemaVersion = 2;
  static const connectTimeout = Duration(seconds: 10);
  static const receiveTimeout = Duration(seconds: 30);
  static const apiKeyTestTimeout = Duration(seconds: 35);
  static const transientRetryCount = 1;
  static const transientRetryBackoff = Duration(milliseconds: 500);
  static const rateLimitCooldown = Duration(seconds: 60);
  static const transientCooldown = Duration(seconds: 15);
  static const chatInputMaxCharacters = 1000;
  static const undoWindow = Duration(seconds: 10);
  static const duplicateWindow = Duration(minutes: 2);
  static const targetWarningLowKcal = 1200;
  static const targetWarningHighKcal = 4000;
  static const targetMaximumKcal = 9999;
  static const reminderDefaultThresholdPercent = 70;
}
