# Serverless Contact App Example

An sample iOS application of inquiry form using serverless platform.

- [x] Firebase (Firestore + Cloud Functions for Firebase)
- [ ] AWS (WIP: API Gateway + Lambda + DynamoDB)

## [iOS] Build Instructions

Please install [CocoaPods](https://guides.cocoapods.org/using/getting-started.html) if you haven't.

1. Download the GoogleService-Info.plist file from [Firebase console](https://console.firebase.google.com)
See also docs at https://firebase.google.com/docs/ios/setup#add_firebase_to_your_app

2. Place the GoogleService-Info.plist at the root

```
$ tree . -L 1
.
├── Firebase/
├── GoogleService-Info.plist # here
├── README.md
└── iOS/
```

3. Install dependencies

```
$ cd iOS
$ pod install
```

4. Open `ServerlessContactAppExample.xcworkspace` and build

## [Firebase] Deploy functions

```
$ npm install -g firebase-tools
$ cd firebase
$ firebase deploy --only functions
```

See also docs at https://firebase.google.com/docs/functions/get-started
