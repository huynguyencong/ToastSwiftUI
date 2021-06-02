# ToastSwiftUI

A simple way to show a toast or a popup in SwiftUI

## About

SwiftUI is a great thing that Apple brought to iOS developers in 2019. But it still hasn't provided us a way to show a toast, a short time message. Toast message is quite popular in iOS applications, even it is not a native view. This ToastSwiftUI open source will help you to do that easily.

Showing a popup is the same, not too difficult, but there is no native API for it. This open source also helps you.

![Demo ToastSwiftUI](Images/demo.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.0 or later
- iOS 13 or later

## Installation

#### Cocoapod

ToastSwiftUI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ToastSwiftUI'
```

Then run `pod install` in your command line.

#### Swift Package Manager
In Xcode, select menu File -> Swift Packages -> Add Package Dependency. Select a target, then add this link to the input field:
`https://github.com/huynguyencong/ToastSwiftUI.git`

#### Manual

Sometimes you don't want to use Cocoapod to install. In this case, you need to add it manually. It is very simple, just add Swift files in the `ToastSwiftUI/Classes` to your project.

## Usage

### Showing a popup

- Step 1: Add a @State variable to control when showing the popup.
```swift
@State private var isPresentingPopup = false
```

- Step 2: Add `popup` modifier to your view with the binding variable in step 1. `MyPopup` is a view that you want to show as a popup.
```swift
.popup(isPresenting: $isPresentingPopup, overlayColor: Color.black.opacity(0.4)) {
    MyPopup(isPresenting: $isPresentingPopup)
}
```

- Step 3: Show the toast by set variable in the step 1 to true. You can also dismiss it by set it to false:
```swift
self.isPresentingPopup = true
```

### Showing a toast

- Step 1: Add a @State variable to control when showing the toast.
```swift
@State private var isPresentingToast = false
```

- Step 2: Add `toast` modifier to your view with the binding variable in step 1.
```swift
.toast(isPresenting: $isPresentingToast, message: "Success", icon: .success)
```

- Step 3: Show the toast by set variable in the step 1 to true. You can also dismiss it by set it to false:
```swift
self.isPresentingPopup = true
```

See the completed code below, it has both above example to show both toast and popup:

```swift
import SwiftUI
import ToastSwiftUI

struct ContentView: View {
    // 1. Add @State variables to control when showing the toast or popup
    @State private var isPresentingPopup = false
    @State private var isPresentingToast = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show toast") {
                // 3a. Set state variable to true if you want to show the toast
                self.isPresentingToast = true
            }
            
            Button("Dismiss toast") {
                // 3b. Set state variable to false if you want to hide the toast
                self.isPresentingToast = false
            }
            
            Button("Show popup") {
                // 3c. Set state variable to true if you want to show the popup
                self.isPresentingPopup = true
            }
            
            Button("Dismiss popup") {
                // 3d. Set state variable to true if you want to hide the popup
                self.isPresentingPopup = false
            }
            
            Spacer()
        }
        .padding()
        
        // 2. Add a `popup` modifier to your view with the binding variable in step 1
        .popup(isPresenting: $isPresentingPopup) {
            MyPopup(isPresenting: $isPresentingPopup)
        }
        
        // 2. Add a `toast` modifier to your view with the binding variable in step 1
        .toast(isPresenting: $isPresentingToast, message: "Success", icon: .success)
    }
}
```

### Customization

#### `popup` modifier
- autoDismiss
    - none: No auto dismiss, you have to dismiss manually.
    - after(TimeInterval): Auto dismiss after a duration that you pass to.
    - auto(String): Auto dissmiss after a duration that calculated base on the text you show.
    
- hasShadow
- cornerRadius
- overlayColor
- isTapOutsideToDismiss

#### `toast` modifier
- autoDismiss
    - none: No auto dismiss, you have to dismiss manually.
    - after(TimeInterval): Auto dismiss after a duration that you pass to.
    - auto: Auto dissmiss after a duration that calculated base on the text you show.
    
- icon
    - info
    - error
    - success
    - custom(Image): Show icon as the image you provided.
    - loading: Show icon as a rotating loading indicator.
    
- backgroundColor
- textColor

## UIKit version
[EzPopup for UIKit](https://github.com/huynguyencong/EzPopup)


## Author

Huy Nguyen, conghuy2012@gmail.com

## License

ToastSwiftUI is available under the MIT license. See the LICENSE file for more info.
