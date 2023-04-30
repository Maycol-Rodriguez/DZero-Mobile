import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String baseUrl = dotenv.env['BASE_URL']!;
  static String cloudName = dotenv.env['CLOUD_NAME']!;
  static String uploadPreset = dotenv.env['UPLOAD_PRESET']!;

  static String webApiKeyFirebase = dotenv.env['WEB_API_KEY_FIREBASE']!;
  static String webAppIdFirebase = dotenv.env['WEB_APP_ID_FIREBASE']!;
  static String webMessageSenderIdFirebase =
      dotenv.env['WEB_MESSAGE_SENDER_ID_FIREBASE']!;
  static String webProjectIdFirebase = dotenv.env['WEB_PROJECT_ID_FIREBASE']!;
  static String webAuthDomainFirebase = dotenv.env['WEB_AUTH_DOMAIN_FIREBASE']!;
  static String webStorageBucketFirebase =
      dotenv.env['WEB_STORAGE_BUCKET_FIREBASE']!;
  static String webMeasurementIdFirebase =
      dotenv.env['WEB_MEASUREMENT_ID_FIREBASE']!;

  static String androidApiKeyFirebase = dotenv.env['ANDROID_API_KEY_FIREBASE']!;
  static String androidAppIdFirebase = dotenv.env['ANDROID_APP_ID_FIREBASE']!;
  static String androidMessageSenderIdFirebase =
      dotenv.env['ANDROID_MESSAGE_SENDER_ID_FIREBASE']!;
  static String androidProjectIdFirebase =
      dotenv.env['ANDROID_PROJECT_ID_FIREBASE']!;
  static String androidStorageBucketFirebase =
      dotenv.env['ANDROID_STORAGE_BUCKET_FIREBASE']!;

  static String iosApiKeyFirebase = dotenv.env['IOS_API_KEY_FIREBASE']!;
  static String iosAppIdFirebase = dotenv.env['IOS_APP_ID_FIREBASE']!;
  static String iosMessageSenderIdFirebase =
      dotenv.env['IOS_MESSAGE_SENDER_ID_FIREBASE']!;
  static String iosProjectIdFirebase = dotenv.env['IOS_PROJECT_ID_FIREBASE']!;
  static String iosStorageBucketFirebase =
      dotenv.env['IOS_STORAGE_BUCKET_FIREBASE']!;
  static String iosClientIdFirebase = dotenv.env['IOS_CLIENT_ID_FIREBASE']!;
  static String iosBundleIdFirebase = dotenv.env['IOS_BUNDLE_ID_FIREBASE']!;
}
