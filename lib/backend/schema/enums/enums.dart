import 'package:ff_commons/flutter_flow/enums.dart';
export 'package:ff_commons/flutter_flow/enums.dart';

enum DaysOfTheWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (DaysOfTheWeek):
      return DaysOfTheWeek.values.deserialize(value) as T?;
    default:
      return null;
  }
}
