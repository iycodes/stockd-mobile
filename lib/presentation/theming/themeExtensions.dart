import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

/// Flutter code sample for [ThemeExtension].

@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors(
      {required this.primary,
      required this.primary2,
      required this.secondary,
      required this.secondary2,
      required this.lightGrey,
      required this.ash,
      required this.textColor,
      required this.accentColor1});

  final Color primary;
  final Color primary2;
  final Color secondary;
  final Color secondary2;
  final Color accentColor1;
  final Color lightGrey;
  final Color ash;
  final Color textColor;
  @override
  MyColors copyWith({
    Color? primary,
    Color? primary2,
    Color? secondary,
    Color? secondary2,
    Color? accentColor1,
    Color? lightGrey,
    Color? ash,
    Color? textColor,
  }) {
    return MyColors(
        primary: primary ?? this.primary,
        primary2: primary2 ?? this.primary2,
        secondary: secondary ?? this.secondary,
        secondary2: secondary2 ?? this.secondary2,
        accentColor1: accentColor1 ?? this.accentColor1,
        lightGrey: lightGrey ?? this.lightGrey,
        ash: ash ?? this.ash,
        textColor: textColor ?? this.textColor);
  }

  @override
  MyColors lerp(MyColors? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primary2: Color.lerp(primary2, other.primary2, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondary2: Color.lerp(secondary2, other.secondary2, t)!,
      lightGrey: Color.lerp(lightGrey, other.lightGrey, t)!,
      accentColor1: Color.lerp(accentColor1, other.accentColor1, t)!,
      ash: Color.lerp(ash, other.ash, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
    );
  }

  // // Optional
  // @override
  // String toString() => 'MyColors(brandColor: $brandColor, danger: $danger)';
}
