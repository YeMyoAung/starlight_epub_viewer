# Starlight Epub Viewer (Paid Version - 50,000MMK)

starlight_epub_viewer is an epub ebook reader that encapsulates the [folioreader](https://folioreader.github.io/FolioReaderKit/) framework.
It supports iOS and android.


## Features
| Name | Android | iOS |
|------|-------|------|
| Reading Time Left / Pages left | ✅ | ✅ |
| Last Read Locator | ✅ | ✅ |
| Highlight And Notes | ✅ | ✅ |
| Load ePub from Asset | ✅ | ✅ |
| Share | ✅ | ✅ |
| Distraction Free Reading | ✅ | ✅ |



## ScreenShots (Android)
<a href="#ScreenShotsAndroid">
  <img src="https://user-images.githubusercontent.com/26484667/148074830-95b4a42a-e70c-4594-972c-1a8fd56f9774.png" width="200px">
</a>&nbsp;&nbsp;
<a href="#ScreenShotsAndroid">
  <img src="https://user-images.githubusercontent.com/26484667/148074873-906f43f9-c26c-4cbf-9300-8c24340ea4ac.png" width="200px">
</a>&nbsp;&nbsp;
<a href="#ScreenShotsAndroid">
  <img src="https://user-images.githubusercontent.com/26484667/148074930-2f235c25-3a91-465c-901e-fb15441869cf.png" width="200px">
</a>&nbsp;&nbsp;
<a href="#ScreenShotsAndroid">
  <img src="https://user-images.githubusercontent.com/26484667/148075228-167be8be-279b-4fd3-b7d2-e8cdc1bb9f38.png" width="200px">
</a>&nbsp;&nbsp;


## ScreenShots (Ios)
<a href="#ScreenShotsIos">
  <img src="https://user-images.githubusercontent.com/26484667/148074164-f29ef150-5723-4556-860c-98ab533f4e9c.PNG" width="200px">
</a>&nbsp;&nbsp;
<a href="#ScreenShotsIos">
  <img src="https://user-images.githubusercontent.com/26484667/148074263-75723093-b422-4364-a649-387630ebc7b8.PNG" width="200px">
</a>&nbsp;&nbsp;
<a href="#ScreenShotsIos">
  <img src="https://user-images.githubusercontent.com/26484667/148074389-a73c2e0a-ed56-4c39-9071-c23f0b9e3c14.PNG" width="200px">
</a>&nbsp;&nbsp;
<a href="#ScreenShotsIos">
  <img src="https://user-images.githubusercontent.com/26484667/148074461-51eecf90-555f-4b1a-b7d2-eba49c06926e.PNG" width="200px">
</a>&nbsp;&nbsp;


## Installation

Add starlight_epub_viewer as dependency to your pubspec file.

```
   starlight_epub_viewer: 
    git:
      url: https://github.com/YeMyoAung/starlight_epub_viewer.git
```
## Android Setup

No additional integration steps are required for Android.

## Ios Setup

This plugin requires `Swift` to work on iOS.

Add the following lines in the `Podfile` file of your iOS project
```
platform :ios, '9.0'
...
target 'Runner' do
  use_frameworks!
  use_modular_headers!
  pod 'FolioReaderKit', :git => 'https://github.com/YeMyoAung/starlight_folioreader.git'
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

## Usage

First of all you need to import our package.

```dart
import 'package:starlight_epub_viewer/starlight_epub_viewer.dart';
```

And then you can use easily.

```dart
  /// Config
  StarlightEpubViewer.setConfig(
    ///for viewer color
    themeColor: Colors.blue,
    ///night mode for viewer
    nightMode: false,
    ///scroll direction for viewer
    scrollDirection: StarlightEpubViewerScrollDirection.ALLDIRECTIONS,
    ///if you want to share your epub file
    allowSharing: true,
    ///enable the inbuilt Text-to-Speech
    enableTts: true,
    ///if you want to show remaining 
    setShowRemainingIndicator: true,
  );
  
  /// Open From File
  StarlightEpubViewer.open(
      "file path",
  );
  
  /// Open From Assets Folder
  StarlightEpubViewer.openAsset(
      "assets file path",
  );
  
```


## Contact Us

[Starlight Studio](https://www.facebook.com/starlightstudio.of/)
	
