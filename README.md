# Hello Chat Application

Hello Chat is an app made with **Flutter** framework

- An android application made with the help of Flutter, Firebase. 
- A fully functional chat application with image sharing capability that allows users to chat with each other(one to one or group chat).
- User's can authenticate using Firebase Auth. 
- Users all Details and messages will be stored in firestore database. 
- Users can send and receive data in real time.
- for state management provider is used.


## Features

- Signin/signup using Firebase
- Forget Password 
- Send and receive messages in real time 
- Stream to get chats from Firestore database 
- Both text and images can be shared 
- Chats can be deleted 
- one to one and group chats 
- Message sent time 
- Shows user status(online and offline)
- last active time of user 
- Search user via username


## Additional Dependencies Required

```bash
firebase_core: ^1.6.0
firebase_analytics: ^8.3.1
firebase_storage: ^10.0.3
firebase_auth: ^3.1.0
cloud_firestore: ^2.5.1
provider: ^6.0.0
file_picker: ^4.0.1
get_it: ^7.2.0
flutter_spinkit: ^5.1.0
passwordfield: ^0.1.0
flutter_keyboard_visibility: ^5.1.0
timeago: ^3.1.0
```

Add the above lines in your pubspec.yaml file under dependencies section
and run command


## Deployment

To deploy this project

* Clone this repo

* Run this command
```bash
  flutter pub get
```
* Integrate your project with [Firebase](https://console.firebase.google.com/u/0/)

* Create a AVD through Android Studio or use a physical mobile through usb debbuging

* Run this command
 ```bash
 flutter run
 ```


## Screens

|    Register Screen    |  Login Screen    |
|       :--------:   | :-------: |
| ![](https://github.com/jatinkesharwani/hello_chat/blob/a09834aaccb24ad00f2b5bb0308951f12aae290d/assets/readme%20images/register%20page.png) | ![](https://github.com/jatinkesharwani/hello_chat/blob/a09834aaccb24ad00f2b5bb0308951f12aae290d/assets/readme%20images/login%20page.png) |

|    Users List Screen   | Search Users Screen |
|:------:          |:---------------: |
|![](https://github.com/jatinkesharwani/hello_chat/blob/a09834aaccb24ad00f2b5bb0308951f12aae290d/assets/readme%20images/chats%20page.png)|![](https://github.com/jatinkesharwani/hello_chat/blob/a09834aaccb24ad00f2b5bb0308951f12aae290d/assets/readme%20images/users%20page.png)|

| Users Chats Screen  | Create Group Chat Demo |
|:------:          |:---------------: |
|![](https://github.com/jatinkesharwani/hello_chat/blob/a09834aaccb24ad00f2b5bb0308951f12aae290d/assets/readme%20images/users%20chats%20page.png)|![](https://github.com/jatinkesharwani/hello_chat/blob/a09834aaccb24ad00f2b5bb0308951f12aae290d/assets/readme%20images/users%20chats%20page.png)|




## 🚀 Technologies

- [Flutter v2.5.3](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_2.5.3-stable.zip)
- [Dart v2.8.4](https://dart.dev/get-dart)
- [Firebase](https://firebase.google.com/docs)

## 🤝 Contribute

To contribute, fork the repository and push the changes to the **master** branch. Then submit a pull request for merging with the source. If your code passes the review and checks it will be merged into the master branch.

## 💬 Feedback

Feel free to send us feedback on gmail => "jatinkesharwani360@gmail.com"  or [file an issue](https://github.com/jatinkesharwani/hello_chat/issues). Feature requests are always welcome.
