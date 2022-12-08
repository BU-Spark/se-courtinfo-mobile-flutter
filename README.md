<h1>CourtInfo Flutter Application </h1>

<h2> Content </h2>

- [Getting Started](#getting-started)
  - [VSCode](#vscode)
  - [iOS](#ios)
- [Notes](#notes)
  - [TO-DO](#to-do)
  - [Reasons behind each decision](#reasons-behind-each-decision)
  - [Flutter Icons Widget](#flutter-icons-widget)
- [Demo](#demo)
  - [SUM'22 UI Design](#sum22-ui-design)
  - [SUM'22 Flutter Application](#sum22-flutter-application)
    - [Cropping Photos UX flow](#cropping-photos-ux-flow)

## Getting Started
To get started follow these steps:
1. Download [Flutter](https://docs.flutter.dev/get-started/install)
   
   You can run the following command to check whether all required Flutter's dependencies are installed correctly:
   ```
   flutter doctor
   ```
   <b>NOTE:</b> Either Xcode or Android Studio can be installed to use Flutter. There is no need for both to be installed to run the application. However, it is recommended to have both to test run the app on both OS.
2. Set up an [editor](https://docs.flutter.dev/get-started/editor?tab=vscode) (recommend using VSCode)
3. Clone the repository
    ```
    git clone <github link>
    ```

After these steps, run the following command to download the flutter packages inside the directory:
```
flutter pub get
```

### VSCode
If you chose VSCode as your editor, the application can be built and run on the VSCode. Click the "Run" option and then either click "Start With Debugging" or "Run Without Debugging" (Recommend running on the later option as the first option will automatically stops if it detects any error).

### iOS
For people who are developing the Flutter application using the iOS simulator, the iOS simulator doesn't support the usage of `camera` package; therefore, you'll have to connect the computer with your phone while developing the app to see changes or use Android simulator. 

To allow Flutter application to be installed onto your phone for development, go through the steps mentioned in this [medium article](https://medium.com/front-end-weekly/how-to-test-your-flutter-ios-app-on-your-ios-device-75924bfd75a8).

To open the Xcode as mentioned in the article, you can run the following commands in the repository directory:
```
cd /ios
open Runner.xcworkspace
```

## Notes
Keep in mind that scalability is not the first foremost factor to take into consideration since this application will only be used by Virgnia Fairfax County, meaning that the concurrent users will not amount to million or thousands of users.
### TO-DO
There are some comments (ex: `// TODO: ...`) throughout the codebase that note tasks that are needed to be completed. Here are a few to take note of: 

- [x] document screen
  - [x] directory logic (folder & document creation logic)
  - [x] sorting logic
  - [ ] querying documents from backend
  - [x] search logic
- [x] camera screen
  - [ ] enable/disable flash
- [x] displaying photos screen
  - [x] crop screen & logic
  - [ ] sending documents to backend
- [ ] loading screen
- [ ] setting screen
- [ ] error screen
- [ ] theme constants
- [ ] API service (for calling API on the backend)

### Reasons behind each decision
- Cropping screen not align with the UI design

    The cropping screen is created using a [third-party package](https://pub.dev/packages/image_cropper) that provides a pre-built screen since it uses other third-party packages according to each OS. The `image_cropper` package has some configurability, changing its background color and etc. Check out its [documentations](https://pub.dev/packages/image_cropper#customization) to see what is configurable.
- Documents stored in backend
    
    All documents scanned will not be stored locally but instead stored in the database. Therefore, each time document screen is opened, the application have to send HTTP request for documents data from the backend (or you could create a button to manually query to decrease the load on database).

### Flutter Icons Widget

Most of Flutter widgets are based of the Material design by Google, which is why the icons for `Icons` widget can be searched through this [Google fonts website](https://fonts.google.com/icons).

## Demo
### SUM'22 UI Design 
<img src="https://i.imgur.com/RCiLISB.png" />
<img src="https://i.imgur.com/JS870jG.png" />

### SUM'22 Flutter Application
#### Cropping Photos UX flow
1. <b>Take photo</b>
   
   Document screen &#8594; Press "Camera" icon button &#8594; Camera screen &#8594; Display photos screen
2. <b>Cropping photo</b>
   
   Press "Pen" icon button (top right) &#8594; Cropping screen &#8594; Display photos screen &#8594; Camera screen
3. <b>Retake photos</b>
   
   Display photos screen &#8594; Press "Retake button" (deletes the current photo) &#8594; Camera screen

![copping_photos_ux_flow](https://user-images.githubusercontent.com/52475722/190462137-20411110-6fe0-40cf-b953-421a5b5b9c4c.gif)
