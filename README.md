![Swift Version](https://img.shields.io/badge/Swift-5.5-F16D39.svg?style=flat) ![Dependency frameworks](https://img.shields.io/badge/Supports-_Swift_Package_Manager-F16D39.svg?style=flat) [![Twitter](https://img.shields.io/badge/twitter-@marcostmorais-blue.svg?style=flat)](https://twitter.com/marcostmorais) ![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20iPadOS-blue)

**LocalShoutout** is a wrapper for Apple platforms **Local Notifications**, powered by the **UserNotifications** framework. With LocalShoutout, you'll be able to easily create, schedule and cancel local notifications for any Apple platform.

## ✨ Features

- **Authenticate**: Easily authenticate to be able to send local notifications for your app.
- **Schedule**: You can schedule a notification with a Date or DateComponent.
- **Repeat**: Want it to repeat? We've got you.
- **Repeat with an Interval**: You can repeat every minute, hour, day, week, month or year.
- **Built Swifty** and with **lightweight** in mind.
- **100% Swift**.
- **Three simple examples** are included in the package. All leveraging **SwiftUI's power**.
- **Documented**.
- **Cancel**: You can always cancel all notifications, a single one or a batch.
- **Delegate**: Want to capture all the events from scheduling to cancelling? Just adopt the **ShoutableDelegate**!
- **Build your Notification**: Title, Body, Sound... You can customize as you please.

## 🚀 Get Started

### Using LocalShoutout in Production Code
Just **import LocalShoutout**:

```swift
import LocalShoutout
```

Then, you can use it as you please. Declare it like this:

```swift
let shoutoutCenter: LocalShoutoutCenter = LocalShoutoutCenter()
```

And always remember to Authenticate if this is the first time you are using it on your app (if you try to schedule without authenticating, it will prompt the authentication for you):
```swift
shoutoutCenter.authenticate()
```

An example of how to create and schedule a notification:
```swift
// Creates the Notification Data
let notification = NotificationData(identifier: "com.marcostmorais.notifications.tenSecondsFromNow", title: "Let's Go!", body: "This is a notification")
        
// Creates a date
let date = Date().addingTimeInterval(10)
        
// Schedule!
shoutoutCenter.scheduleNotification(notification: notification, date: date, repeats: false)
```

Or, you can also cancel a pending notification:


```swift
shoutoutCenter.cancelNotification(identifier: "com.marcostmorais.notifications.tenSecondsFromNow")
```

And even cancel all pending notifications:


```swift
shoutoutCenter.cancelAllNotifications()
```

And finally, an example of how to create and schedule a notification using DateComponents:
```swift
// Creates the Notification Data
let notification = NotificationData(identifier: "com.marcostmorais.notifications.test", title: "Let's Go!", body: "This is a notification")
        
// Creates a dateComponents object that will represent a repeat at 33 minutes and 2 seconds every hour
var dateComponents = DateComponents()
dateComponents.minute = 33
dateComponents.second = 2
    
// Schedule!
shoutoutCenter.scheduleNotification(notification: notification, dateComponents: dateComponents, repeats: true, repeatInterval: .hour)
```

And remember, you can always capture the events using the ShoutableDelegate, which includes:

```swift
extension ShoutableDelegate {
    
    func centerDidStart(center: LocalShoutoutCenter) { }
    func centerDidEnd(center: LocalShoutoutCenter) { }
    
    func didAuthenticate(result: Result<Bool, Error>) { }
    
    func willScheduleNotification(center: LocalShoutoutCenter, notification: NotificationData) { }
    func didScheduleNotification(result: Result<NotificationData, Error>) { }
    
    func willCancelNotification(center: LocalShoutoutCenter) { }
    func didCancelNotification(center: LocalShoutoutCenter) { }
    
}
```
*Just set the **shoutoutCenter.delegate** wherever you want to delegate these events*.

## 📲 All examples are located on the Examples folder, including a Delegate one

## 🔨 Swift Package Manager

You can also add this library using Swift Package Manager.

1. Go to **File > Add Packages**.
2. The Add Package dialog will appear, by default with Apple packages.
3. In the upper right hand corner, paste https://github.com/MarcosAtMorais/LocalShoutout into the **search bar**.
4. Hit **Return** to kick off the search.
5. Click **Add Package**.
6. You're all set! Just **import LocalShoutout** whenever and wherever you want to use it.

## 🌟 Requirements

**iOS** 14+

**macOS** 11+

**watchOS** 7+

**tvOS** 14+
