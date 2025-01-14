# OneSignal CLI

### :warning: This tool is currently in [Beta](https://github.com/OneSignal/cli/issues/5) :warning:

The OneSignal CLI is a tool to work with OneSignal projects.

# Mac Setup
1. Have Homebrew installed
2. Run `brew tap OneSignal/cli https://github.com/OneSignal/cli`
3. Run `brew install onesignal-cli`
4. Run `/usr/local/Cellar/onesignal-cli/{CLI_Version_Number}/bin/bundle install` Example: `/usr/local/Cellar/onesignal-cli/0.0.3/bin/bundle install`

## Available commands

* `onesignal help` Lists the available commands in the OneSignal CLI
* `onesignal install-sdk`  Install the OneSignal SDK in the project

## Installation Command
This command can be used to add the OneSignal SDK to your mobile application project.
Currently only supports iOS and Android Native SDK install.

For iOS the command will: 
* Add push notification capabilities and background modes
* Add the OneSignal cocoapod or Swift Package
* Create and setup a Notification Service Extension
* Setup an App Group for communication with the NSE.

Note that this command does not yet add initialization code to your app so please follow [step 5 of the guide](https://documentation.onesignal.com/docs/ios-sdk-setup#step-5---add-the-onesignal-initialization-code) to complete installation.

For Android the command will: 
* Add the OneSignal gradle dependencies under project and app build.gradle file
* Add the OneSignal initialization code under Application Class. If no application class is available, the CLI tool will create it for you at the given path.

Note: Re sync gradle might be needed after calling install-sdk

Options:
* type - iOS or Android. Type of SDK to install. Required.
* target - name of the App target to install in. Defaults to the entrypoint name. iOS only.

Arguments:
* Entrypoint - Name of the target XCProject (iOS) or Application class file directory (Android). For Android, if no application class is available, the CLI will create it in the directory and name file provided. For the CLI to create the file for you, you will need to provide the directory inside the project and file name with the extension where you want the Application file to be created. Example: app/src/main/java/com/onesignal/testapplication/BaseApp.java
* LANG - programming language to use for ios (objc, swift) or Android (java, kotlin)
* APPID - Optional. OneSignal App ID. Not yet used for iOS installs.

Example Usage, run the following command on the root project directory where OneSignal SDK is going to be use
* iOS: `onesignal install-sdk --type iOS --entrypoint MyApp --lang objc --appid <APPID>`
* Android: `onesignal install-sdk --type android --entrypoint app/src/main/java/com/onesignal/testapplication/BaseApp.kt --appid <APPID>`

## Limitations / Comming Soon
* React Native, Flutter, Unity, Xamarin, and Cordova aren't currently supported. Stay tuned for support in a future release! 
* macOS is currently the only officially supported operating system.
