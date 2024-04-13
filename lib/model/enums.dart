enum ActiveScreen { first, second }

enum FormType { signup, signin }

enum Roundness {
  full,
  partial,
}

enum FileCategory {
  resume,
}

enum AnimationDuration { long, medium, short }

extension AnimationDurationExtension on AnimationDuration {
  Duration get value {
    switch (this) {
      case AnimationDuration.long:
        return const Duration(milliseconds: 4000);
      case AnimationDuration.medium:
        return const Duration(milliseconds: 500);
      case AnimationDuration.short:
        return const Duration(milliseconds: 500);
    }
  }
}

extension FileCategoryExtension on FileCategory {
  String get value {
    switch (this) {
      case FileCategory.resume:
        return 'Resume';
    }
  }
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
