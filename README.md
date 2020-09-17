# ToastSwiftUI

A simple way to show a toast message in SwiftUI

## About

SwiftUI is a great thing that Apple brought to iOS developers in 2019. But it still hasn't provided us a way to show a toast, a short time message. Toast message is quite popular in iOS applications, even it is not a native view. This ToastSwiftUI open source will help you to do that easily.

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

- Step 1: Add a @State variable to control when showing the toast.
```swift
@State private var isShowingToast = false
```

- Step 2: Add `toast` modifier to your view with the binding variable in step 1. You can use the built-in ToastView, or a custom view for toast view.
```swift
.toast(isPresenting: $isShowingToast, dismissType: .after(2)) {
    ToastView(message: "Hello world!", icon: .success)
}
```

- Step 3: Show the toast by set variable in the step 1 to true. You can also dismiss it by set it to false:
```swift
self.isShowingToast = true
```

See completed code below:

```swift
struct ContentView: View {
    // 1. 
    @State private var isShowingToast = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show toast") {
                // 3.
                self.isShowingToast = true
            }
            
            Button("Dismiss toast") {
                // 3.
                self.isShowingToast = false
            }
            
            Spacer()
        }
        .padding()
        
        // 2.
        .toast(isPresenting: $isShowingToast, dismissType: .after(2)) {
            ToastView(message: "Hello world!", icon: .success)
        }
    }
}
```

### Customization

#### toast modifier
- Dismiss type
    - none: No auto dismiss, you have to dismiss manually.
    - after(TimeInterval): Auto dismiss after a duration that you pass to.
    - auto(String): Auto dissmiss after a duration that calculated base on the text you show.

#### ToastView
- Icons
    - info
    - error
    - success
    - custom(Image): Show icon as the image you provided.
    - loading: Show icon as a rotating loading indicator.
    
- Background color

- Text color



## Author

Huy Nguyen, conghuy2012@gmail.com

## License

ToastSwiftUI is available under the MIT license. See the LICENSE file for more info.
