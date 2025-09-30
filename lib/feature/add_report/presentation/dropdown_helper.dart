import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/feature/add_report/enums/enums.dart';

final skinColors = <SkinColor, String>{
  SkinColor.light: 'add_report.skin_color_light'.tr(),
  SkinColor.wheat: 'add_report.skin_color_wheat'.tr(),
  SkinColor.tan: 'add_report.skin_color_tan'.tr(),
  SkinColor.dark: 'add_report.skin_color_dark'.tr(),
};

final eyeColors = <EyeColor, String>{
  EyeColor.brown: 'add_report.eye_color_brown'.tr(),
  EyeColor.blue: 'add_report.eye_color_blue'.tr(),
  EyeColor.green: 'add_report.eye_color_green'.tr(),
  EyeColor.hazel: 'add_report.eye_color_hazel'.tr(),
  EyeColor.gray: 'add_report.eye_color_gray'.tr(),
  EyeColor.black: 'add_report.eye_color_black'.tr(),
  EyeColor.amber: 'add_report.eye_color_amber'.tr(),
};

final hairColor = <HairColor, String>{
  HairColor.black: 'add_report.hair_color_black'.tr(),
  HairColor.brown: 'add_report.hair_color_brown'.tr(),
  HairColor.blonde: 'add_report.hair_color_blonde'.tr(),
  HairColor.red: 'add_report.hair_color_red'.tr(),
  HairColor.gray: 'add_report.hair_color_gray'.tr(),
  HairColor.white: 'add_report.hair_color_white'.tr(),
};

SkinColor? stringToSkinColor(String value) {
  try {
    return SkinColor.values.firstWhere(
      (element) =>
          element.toString() == 'SkinColor.$value' ||
          element.toString() == value,
    );
  } catch (e) {
    return null;
  }
}

EyeColor? stringToEyeColor(String value) {
  try {
    return EyeColor.values.firstWhere(
      (element) =>
          element.toString() == 'EyeColor.$value' ||
          element.toString() == value,
    );
  } catch (e) {
    return null;
  }
}

HairColor? stringToHairColor(String value) {
  try {
    return HairColor.values.firstWhere(
      (element) =>
          element.toString() == 'HairColor.$value' ||
          element.toString() == value,
    );
  } catch (e) {
    return null;
  }
}
