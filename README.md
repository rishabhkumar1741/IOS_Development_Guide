# iOS Development Guide

Learning notes with explanations and examples. Use the topic index to jump to a section in the rendered Markdown preview.

## Topic index

> **1. [Swift vs SwiftUI](#1-swift-vs-swiftui)**
>
> - [Key differences](#key-differences)
> - [Example: Swift logic](#example-swift-logic)
> - [Example: a screen using SwiftUI](#example-a-screen-using-swiftui)
> - [System icons: SF Symbols](#system-icons-sf-symbols)
> - [Where Xcode fits](#where-xcode-fits)

> **2. [SwiftUI](#2-swiftui)**
>
> - [View](#view)
> - [VStack — vertical layout](#vstack--vertical-layout)
> - [HStack — horizontal layout](#hstack--horizontal-layout)
> - [ZStack — overlapping views](#zstack--overlapping-views)
> - [Modifiers](#modifiers)
> - [Spacer and Divider](#spacer-and-divider)
> - [Button and State](#button-and-state)
> - [ScrollView and ForEach](#scrollview-and-foreach)

---

## 1. Swift vs SwiftUI

### Key differences

**Swift is a programming language. SwiftUI is a framework you use with Swift to build an app's user interface (UI).** They work together.

| Question | Swift | SwiftUI |
| --- | --- | --- |
| What is it? | A general-purpose programming language. | Apple's framework for building user interfaces. |
| What does it provide? | Variables, functions, conditions, loops, structs, and other language features. | Views and controls such as `Text`, `Image`, `Button`, and layouts such as `VStack`. |
| What do I use it for? | Expressing logic, working with data, and writing application code, including UI code. | Describing what a screen displays and how it responds to state changes. |
| Can I use it independently? | Yes. Swift can be used without SwiftUI. | SwiftUI code is written in Swift. |

SwiftUI is **declarative**: you describe the interface for the current state, and the framework updates the display when that state changes. See [Apple's SwiftUI overview](https://developer.apple.com/swiftui/) and [About Swift](https://www.swift.org/about/).

### Example: Swift logic

```swift
let name = "Rishabh"

func greeting(for name: String) -> String {
    return "Hello, \(name)!"
}

print(greeting(for: name)) // Console output: Hello, Rishabh!
```

`let` creates a constant, and `func` defines a function. This example prints a message to the console; it does not create an app screen.

### Example: a screen using SwiftUI

```swift
import SwiftUI

struct GreetingView: View {
    let name = "Rishabh"

    var body: some View {
        VStack {
            Text("Hello, \(name)!")
                .font(.title)
            Text("I am learning iOS development.")
        }
        .padding()
    }
}
```

- `import SwiftUI` makes the framework available in this file.
- `struct`, `let`, and `var` are Swift language features.
- `View`, `Text`, and `VStack` come from SwiftUI.
- `VStack` arranges the two text views vertically.
- `.font(.title)` styles the greeting; `.padding()` adds space around the stack.

The screen displays a large greeting with the learning message underneath. **This entire example is Swift code that uses SwiftUI.**

### System icons: SF Symbols

**SF Symbols** are Apple's built-in icons. Use their names to display them in SwiftUI—no image download needed.

```swift
Image(systemName: "arrowshape.turn.up.left.2.fill")
    .font(.system(size: 30))
    .foregroundStyle(.blue)
```

**Output:** a blue, filled double-arrow icon turning left.

- `systemName:` selects a built-in icon by name.
- `.font(...)` sets its size to 30 points.
- `.foregroundStyle(.blue)` makes it blue.

In this icon's name, `.2` means double arrows and `.fill` means a filled shape. The whole string is one icon name.

**Built-in icon vs your own image:**

```swift
Image(systemName: "star.fill") // Apple's star icon
Image("MyImage")              // Your image in Assets.xcassets
```

**Find more icons:** open Apple's [SF Symbols app](https://developer.apple.com/sf-symbols/), choose an icon, and copy its name. Check its supported OS versions there too.

### Where Xcode fits

**Xcode is the development application** where you edit code, build, run, and debug your project. Swift is the language you write; SwiftUI provides the UI tools. Xcode's build process compiles your code and packages it with resources, such as images, into an app bundle.

Remember: **Swift = language · SwiftUI = UI framework · Xcode = development tool.**

---

## 2. SwiftUI

SwiftUI builds screens by combining small views. Put the short layout examples below inside a view's `body`; examples with `struct` define complete views.

### View

A **view** describes a piece of your interface: text, an image, a button, or a whole screen. `View` is the protocol your custom view conforms to.

```swift
import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text("Hello, SwiftUI!")
    }
}

#Preview {
    WelcomeView()
}
```

- `body` describes the content to display.
- `some View` means a specific view type whose exact name the compiler figures out.
- `#Preview` shows this view in Xcode's canvas.

**Output:** the text “Hello, SwiftUI!” [Apple: View](https://developer.apple.com/documentation/swiftui/view)

### VStack — vertical layout

Places views **one below another**.

```swift
VStack(alignment: .leading, spacing: 8) {
    Text("Rishabh")
    Text("iOS learner")
}
```

**Output:** the name above the description. `.leading` aligns their leading edges; `spacing: 8` leaves 8 points between them.

### HStack — horizontal layout

Places views **side by side**.

```swift
HStack(spacing: 8) {
    Image(systemName: "star.fill")
    Text("Favorite")
}
```

**Output:** a star beside “Favorite”, with an 8-point gap.

### ZStack — overlapping views

Places views **in layers**. By default, later views appear in front of earlier ones.

```swift
ZStack {
    Circle()
        .fill(.blue)
        .frame(width: 80, height: 80)
    Image(systemName: "star.fill")
        .foregroundStyle(.white)
}
```

**Output:** a white star centered over a blue circle.

| VStack | HStack | ZStack |
| --- | --- | --- |
| Top to bottom | Side by side | Back to front |
| Profile details | Icon + title | Icon over a background |

You can nest stacks: an `HStack` can contain an image beside a `VStack` of text. [Apple: Stack layouts](https://developer.apple.com/documentation/swiftui/building-layouts-with-stack-views)

### Modifiers

Modifiers customize a view's appearance, layout, or behavior. Each returns a modified view.

```swift
Text("Welcome")
    .font(.title)
    .foregroundStyle(.white)
    .padding(12)
    .background(.blue)
    .clipShape(RoundedRectangle(cornerRadius: 12))
```

**Output:** title-sized white text inside a padded blue shape with rounded corners.

- `.font` and `.foregroundStyle` set text style and color.
- `.padding(12)` adds 12 points around the text.
- `.background` adds the background; `.clipShape` clips the result.

**Order matters:**

```swift
VStack(spacing: 16) {
    Text("A").padding(12).background(.yellow)
    Text("B").background(.yellow).padding(12)
}
```

For **A**, yellow covers the padding too. For **B**, yellow covers the text area, with padding outside it. [Apple: Configuring views](https://developer.apple.com/documentation/swiftui/configuring-views)

### Spacer and Divider

`Spacer()` fills available space. `Divider()` draws a thin separator.

```swift
VStack {
    HStack {
        Text("Profile")
        Spacer()
        Image(systemName: "person.circle")
    }
    Divider()
    Text("Your account details")
}
.padding()
```

**Output:** a title and icon pushed toward opposite ends of the row, followed by a line and account text. [Apple: Spacer](https://developer.apple.com/documentation/swiftui/spacer)

### Button and State

A `Button` runs an action when tapped. `@State` stores local view state; changes update views that use it.

```swift
struct CounterView: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 12) {
            Text("Count: \(count)")
            Button("Add 1") {
                count += 1
            }
        }
    }
}
```

**Output:** starts at “Count: 0”. Each tap increases the number by one. Use `CounterView()` in a `#Preview` to try it. Keep `import SwiftUI` at the top of the file. [Apple: State](https://developer.apple.com/documentation/swiftui/state)

### ScrollView and ForEach

`ScrollView` lets overflowing content scroll. `ForEach` creates views from a collection or range.

```swift
ScrollView {
    VStack(spacing: 12) {
        ForEach(1..<21) { number in
            Text("Lesson \(number)")
        }
    }
    .padding()
}
```

**Output:** lessons 1–20 in a vertical column. Scroll when they exceed the available height. A `VStack` alone does not scroll. [Apple: ScrollView](https://developer.apple.com/documentation/swiftui/scrollview)
