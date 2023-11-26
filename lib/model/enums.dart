enum ActiveScreen { first, second }

enum FormType { signup, signin }

enum Roundness {
  full,
  partial,
}

extension RoundnessExtension on Roundness {
  double get value {
    switch (this) {
      case Roundness.full:
        return 41.0;
      case Roundness.partial:
        return 10.0;
        /* assign a value for 'signin' */;
    }
  }
}
