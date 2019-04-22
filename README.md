# tmdb-challenge iOS App

## Tools & Technologies

The project is developed in Xcode 10.2.1, iOS 12 SDK, Swift 5 and minimum deployment target as iOS 10.

**OS & Devices:** iOS 10+, iPhone and iPad

**Programming approach:** ReactiveX using RxSwift and RxCocoa

**Architecture:** MVVM-C with Coordinator

**Dependency Manager:** Cocoapods

**Dependecies:** RxSwift, RealmSwift, Alamofire, AlamofireImage, ReachabilitySwift, NVActivityIndicatorView, XCDYouTubeKit & MaterialComponents/Snackbar

**Core Modules:** MCoreKit, MUIKit

**Code documentation:** Using jazzy [Application DOCS](http://yasirmturk.github.io/tmdb-challenge/), [MCoreKit DOCS](http://yasirmturk.github.io/tmdb-challenge/MCoreKit), [MUIKit DOCS](http://yasirmturk.github.io/tmdb-challenge/MUIKit)

**Test using:** XCTest and RxBlocking

**Lint using:** Swiftlint

**Custom views:**

## Description

Below is an overview of the Functionality implemented:

- Fetch and display the list of popular movies
- User can see details of the selected movie
- User can Watch trailer using In-App YouTube player
- Filter the movie list by searching on the title
- View the movie list and cached details, posters, etc.

### MCoreKit

This is a group of classes and extensions taken for commonly used functionality across diffent projects. This module is may not be specific to One App and can be used in other projects

### MUIKit

This is also a group of classes and extensions but specific to the UI functionality

### Tests

Written test case for Decoding, Stub API, Live API and Models only

## Screenshots
