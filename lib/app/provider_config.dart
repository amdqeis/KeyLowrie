class ProviderConfig {
  const ProviderConfig._();

  static const apiVersion = 'v1beta';
  static const endpoint = 'https://generativelanguage.googleapis.com';
  static const model = 'gemini-2.0-flash';
  static const responseSchemaVersion = 2;

  /// Daftar model Gemini yang valid untuk dipilih user.
  /// Format: (modelId, label, keterangan)
  static const availableModels = [
    (
      id: 'gemini-3.7-flash',
      label: 'Gemini 3.7 Flash',
      note: 'Terbaru • Paling cerdas',
    ),
    (
      id: 'gemini-3.6-flash',
      label: 'Gemini 3.6 Flash',
      note: 'Sangat cepat & cerdas',
    ),
    (
      id: 'gemini-3.5-flash',
      label: 'Gemini 3.5 Flash',
      note: 'Rekomendasi • Seimbang',
    ),
    (
      id: 'gemini-3.5-flash-lite',
      label: 'Gemini 3.5 Flash Lite',
      note: 'Cepat • Hemat kuota',
    ),
    (
      id: 'gemini-3.1-flash-lite',
      label: 'Gemini 3.1 Flash Lite',
      note: 'Ringan • Paling hemat',
    ),
    (
      id: 'gemini-3.0-flash',
      label: 'Gemini 3.0 Flash',
      note: 'Generasi 3 dasar',
    ),
  ];
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
