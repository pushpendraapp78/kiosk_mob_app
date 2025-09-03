import 'enums.dart';
import 'global_configuration.dart';

class CommonConstant {
  static Mode APP_MODE = Mode.DEV;
  static void initializeApp(Mode mode) async {
    APP_MODE = mode;
    await GlobalConfiguration()
        .loadFromAsset("configurations_${mode.name.toLowerCase()}");
  }
}
