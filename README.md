
# Rzume Application Frontend

## Overview

Welcome to the frontend of the Rzume Application. Rzume is a comprehensive job tracking application designed to streamline the job application process for users. It empowers individuals to efficiently manage and organize information related to their job applications. The application offers a user-friendly interface and a set of features to enhance the job hunting experience. This application is designed to provide a seamless user experience through various screens, including Splash, Start, Home, OTP Verification, Signup, Signin, Reset Password, and Create Password screens.

## Screens

### Splash Screen

The Splash screen is the initial view displayed when the application loads, featuring an animated introduction. It serves as an engaging entry point to the Rzume app.

### Start Screen

After the splash animation, the Start screen appears. Users can proceed by clicking the "Get Started" button.

### Signup Screen

The Signup screen allows users to create an account using their email and password or by using their Google or LinkedIn accounts.

### OTP Verification Screen

Upon successful signup, an OTP verification is sent to the user's email. The OTP Verification screen facilitates entering the code to verify the user's identity.

### Signin Screen

Users can log in using their credentials on the Signin screen. If they've just completed the signup process, they can navigate directly from the verified screen.

### Reset Password and Create Password Screen

These screens handle the process of resetting and creating a password.

## Technical Details

### OTP Verification

The OTP Verification screen is a crucial component of the Rzume Application, ensuring secure user authentication. This screen employs a counter utility to manage the countdown timer for OTP entry.

Counter Utility Overview
The counter utility is a versatile tool that relies on Flutter's ChangeNotifier to efficiently propagate updates about the timer counter. This is achieved through the notifyListeners function, a fundamental mechanism for signaling changes in the state.

Integration with OTP Verification Screen
The OTP Verification screen seamlessly integrates the CounterModel object to leverage its functionality. The CounterModel is responsible for managing and exposing properties related to the countdown timer.

To capture and respond to updates in the timer, the OTP Verification screen employs the Flutter ListenableBuilder. This widget listens to listenables, such as the CounterModel, allowing the screen to react dynamically to changes in the timer's state.

### Animations

Animations play a crucial role in enhancing the user experience, and the Rzume Application employs the AnimationBuilder for this purpose.

Favorite Button Animation
The animation for the favorite button is carefully crafted using the AnimationBuilder. This requires a controller to govern the animation's behavior. Subsequently, a variable is created to define the animation.

Given the unique flow desired for the favorite icon animation, a TweenSequence is employed. This sequence comprises weighted tweens, each specifying a start and end point. The weight assigned to each tween determines the percentage of the animation that it contributes.

To ensure optimal performance, the animation is appropriately disposed of within a dispose function.

Bell Button Animation
Similar to the favorite button, the bell button animation is orchestrated using the AnimationBuilder and follows best practices for animation management.

These animation techniques contribute to a visually engaging and interactive user interface, elevating the overall user experience within the Rzume Application.

### Architecture

The Rzume Application adopts a structured architecture to ensure maintainability, scalability, and a seamless user experience. Key components of the architecture include authentication screens, animations, and a versatile AuthPageLayout widget.

Auth Screens Architecture
The authentication screens, including Signup, Signin, Password Reset, OTP Verification, and Verified Screens, share a common architectural foundation. They are all orchestrated by the AuthPageLayout widget, which provides a consistent layout structure for each screen.

AuthPageLayout Widget
The AuthPageLayout widget serves as the cornerstone of the authentication screens. It defines the base layout that encapsulates shared components across different authentication screens. This widget accepts properties such as pageContent, footerText, and showBacknav to customize its appearance and behavior.

pageContent: Contains the specific contents for each screen, ensuring a dynamic and adaptable structure.
footerText: Defines the text displayed beneath the screen, offering additional information or instructions.
showBacknav: Determines whether a back navigation button should be displayed, providing users with intuitive navigation.
This consistent layout approach enhances code maintainability and promotes a unified visual identity across authentication screens.



## Documentation

Please note that the documentation is still being updated. Be aware of this while referencing this README.

Feel free to explore and contribute to the Rzume Application frontend!
