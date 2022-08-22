<p align="center">
  <img src="https://www.marcostmorais.com/labelbutton/cover2.png">
</p>
<p align="center">
    <img src="https://www.marcostmorais.com/labelbutton/cover.png">
</p>

![Swift Version](https://img.shields.io/badge/Swift-5.5-F16D39.svg?style=flat) ![Dependency frameworks](https://img.shields.io/badge/Supports-_Swift_Package_Manager-F16D39.svg?style=flat) [![Twitter](https://img.shields.io/badge/twitter-@marcostmorais-blue.svg?style=flat)](https://twitter.com/marcostmorais) ![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20iPadOS-blue)

**LocalShoutout** is a wrapper for Apple Platforms Local Notifications, powered by the UserNotifications framework. With LocalShoutout, you'll be able to easily create, schedule and cancel local notifications for any Apple platform.

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
- **Build your Notification**: Title, Body, Sound... You can customize as you please.

## 🚀 Get Started

### Using LocalShoutout in Production Code
Just **import LocalShoutout**:

```swift
import LocalShoutout
```

Then, you can use it as you please. Like this quick example:

```swift

```

An example using the **LabelButtonListView**. This is one option:
```swift

```

Or, you can also use it making your own stacks and verifying the dynamicTypeSize (no need for the LabelButtonView as it already does):


```swift

```

All examples are located on the Examples folder.

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

**macOS** 12+

**watchOS** 7+

**tvOS** 14+
