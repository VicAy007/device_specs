import 'package:flutter/material.dart';

abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;

  static const BorderRadius chip = BorderRadius.all(
    Radius.circular(sm),
  );

  static const BorderRadius module = BorderRadius.all(
    Radius.circular(lg),
  );

  static const BorderRadius input = BorderRadius.all(
    Radius.circular(md),
  );
}
