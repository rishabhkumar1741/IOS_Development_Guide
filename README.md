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

> **3. [Swift Programming Language](#3-swift-programming-language)**
>
> - [Setting up an Xcode playground](#setting-up-an-xcode-playground)
> - [let — constants](#let--constants)
> - [var — variables](#var--variables)
> - [Data types and storage](#data-types-and-storage)
> - [Value types](#value-types)
> - [Reference types](#reference-types)
> - [Arrays and common operations](#arrays-and-common-operations)
> - [Operators](#operators)
>   - [Unary prefix](#unary-prefix)
>   - [Unary postfix](#unary-postfix)
>   - [Binary infix](#binary-infix)
> - [If/else](#ifelse)
> - [Functions](#functions)
>   - [Define and call a function](#define-and-call-a-function)
>   - [Parameters and arguments](#parameters-and-arguments)
>   - [Return values](#return-values)
>   - [Argument labels](#argument-labels)
>   - [Default parameter values](#default-parameter-values)

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

---

## 3. Swift Programming Language

Started September 8, 2026. New Swift language topics will be added as subtopics here, with links in the main index.

### Setting up an Xcode playground

A playground lets you run small Swift examples without building an app screen. Your existing app can stay as it is.

1. In Xcode, choose **File → New → Playground…**
2. Choose **macOS → Blank** for basic Swift practice, then **Next**. Choose iOS instead if you need iOS frameworks.
3. Name it `SwiftPractice.playground`.
4. Save it beside your `.xcodeproj`, outside the app's source folder. If offered an **Add to** option, select your existing project to show it in the navigator.
5. Open the playground and enter the example below. Use its **▶ run control** to execute the code.

```swift
let name = "Rishabh"
print("Hello, \(name)!")
```

**Console output:** `Hello, Rishabh!`

`let` stores a constant, and `print` writes a message to the console. If the console is hidden, choose **View → Debug Area → Show Debug Area**.

If the playground isn't in the navigator, use **File → Add Files to “IOS_Development_Guide”…** and select it. It doesn't need app target membership.

[Apple: Using Xcode playgrounds](https://developer.apple.com/videos/play/wwdc2020/10096/)

### let — constants

Use `let` when a value should not be reassigned after initialization.

```swift
let language = "Swift"
print(language) // Swift

// language = "Python" // Error: cannot reassign a constant
```

Prefer `let` unless you need changes. A constant holding a class reference has a special case—see [Reference types](#reference-types).

### var — variables

Use `var` when a value needs to change.

```swift
var score = 10
score = 20
score += 5 // Same as score = score + 5
print(score) // 25
```

`var` allows a new value, but the variable's type stays fixed: `score = "Hello"` would be an error.

### Data types and storage

A **data type** describes what a value is. Swift can infer it, or you can write it explicitly.

```swift
let age = 25                  // Inferred as Int: whole number
var price: Double = 99.50     // Decimal number
let name: String = "Rishabh"  // Text
var isLearning: Bool = true   // true or false
```

For “store type”, distinguish **what is stored** from **how assignment behaves**:

| Concept | Meaning |
| --- | --- |
| `Int`, `String`, `Bool`, etc. | The kind of data |
| `let` / `var` | Whether the binding can change |
| Value / reference type | Whether assignment copies a value or shares an instance |

These categories don't specify a fixed stack-versus-heap memory location. [Swift: The Basics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/)

### Value types

Assignment gives you an independent value. Changing the copy does not change the original.

```swift
struct Score {
    var points = 10
}

let original = Score()
var copy = original
copy.points = 20

print(original.points) // 10
print(copy.points)     // 20
```

- Structs and enums are value types. Examples include `Int`, `String`, and `Array`.
- A `let` struct cannot have its properties changed, even if those properties use `var`.
- Arrays can share internal storage until a change requires copying. This optimization is called **copy-on-write**.

[Swift: Structures and Classes](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures/)

### Reference types

Class instances are reference types. Assignment can make two names refer to **the same object**.

```swift
class Player {
    var score = 10
}

let first = Player()
let second = first
second.score = 20

print(first.score)      // 20
print(second.score)     // 20
print(first === second) // true: same instance
```

Both names share one `Player`. `let` prevents assigning a different object to `second`, but its `var score` property can still change.

| Value type | Reference type |
| --- | --- |
| Assignment copies the value | Assignment shares the instance |
| Example: a `struct` | Example: a `class` |
| Changing the copy leaves the original intact | Changing the shared object is visible through both names |

A struct or array can contain class references; copying that container does **not** clone those objects. [Swift: Value and Reference Types](https://www.swift.org/documentation/articles/value-and-reference-types.html)

### Arrays and common operations

An array is an **ordered collection** with one element type. Indexes start at `0`, and duplicates are allowed.

```swift
var fruits: [String] = ["Apple", "Banana"]

fruits.append("Mango")                    // Add one at the end
fruits.append(contentsOf: ["Kiwi", "Pear"]) // Add several
fruits.insert("Orange", at: 1)            // Insert at index 1
fruits[0] = "Grape"                       // Replace the first item
fruits.remove(at: 1)                      // Remove Orange

print(fruits)       // ["Grape", "Banana", "Mango", "Kiwi", "Pear"]
print(fruits.count) // 5
print(fruits[0])    // Grape
```

**More useful operations** — continue with the same array:

```swift
print(fruits.isEmpty)           // false
print(fruits.contains("Mango")) // true
print(fruits.first ?? "Empty")  // Grape; fallback if empty

for fruit in fruits {
    print(fruit) // Each fruit on a separate line
}

fruits.removeAll()
print(fruits.count) // 0
```

- Create an empty array with `var items: [String] = []`.
- Use `var` to append, replace, or remove elements. A `let` array cannot be modified.
- Access, replacement, and `remove(at:)` require an existing index. An invalid index crashes; `first` safely returns `nil` when empty.

**Arrays are value types:**

```swift
let numbers = [1, 2]
var moreNumbers = numbers
moreNumbers.append(3)

print(numbers)     // [1, 2]
print(moreNumbers) // [1, 2, 3]
```

[Swift: Collection Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes/) · [Apple: Array](https://developer.apple.com/documentation/swift/array)

### Operators

An **operator** performs an action on values. Those values are called **operands**.

| Kind | Operands | Position | Example |
| --- | --- | --- | --- |
| Unary prefix | One | Before the value | `!isReady` |
| Unary postfix | One | After the value | `name!` |
| Binary infix | Two | Between values | `5 + 3` |

#### Unary prefix

Appears immediately **before** one operand.

```swift
let isReady = false
print(!isReady) // true: reverses the Boolean

let temperature = 8
print(-temperature) // -8: negates the number
```

These expressions produce new values; `isReady` and `temperature` stay unchanged.

#### Unary postfix

Appears immediately **after** one operand. Postfix `!` force-unwraps an optional.

```swift
let name: String? = "Rishabh"
print(name!) // Rishabh
```

`String?` can contain text or `nil` (no value). Using `!` on `nil` crashes. A safer way to provide a fallback is:

```swift
let nickname: String? = nil
print(nickname ?? "Guest") // Guest
```

**Notice:** `!isReady` means “not”; `name!` means “force-unwrap”. Position changes the meaning. [Swift: Operator declarations](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations/#Operator-Declaration)

#### Binary infix

Appears **between** two operands.

```swift
print(5 + 3)          // 8: addition
print(7 % 2)          // 1: remainder
print(10 >= 8)        // true: comparison
print(true && false)  // false: both must be true
print(true || false)  // true: at least one must be true
```

| Purpose | Operators |
| --- | --- |
| Arithmetic | `+`, `-`, `*`, `/`, `%` |
| Comparison | `==`, `!=`, `<`, `>`, `<=`, `>=` |
| Logical | `&&` (AND), `||` (OR) |
| Assignment | `=`, `+=`, `-=` |

`=` assigns; `==` compares. Integer division truncates: `5 / 2` is `2`, while `5.0 / 2.0` is `2.5`.

Use parentheses to control order: `(2 + 3) * 4` is `20`; `2 + 3 * 4` is `14`. [Swift: Basic Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators/)

### If/else

Use `if` to run code when a condition is `true`, and `else` for the alternative.

```swift
let age = 20

if age >= 18 {
    print("Adult")
} else {
    print("Under 18")
}
// Output: Adult
```

Add `else if` when you have more conditions:

```swift
let score = 75

if score >= 90 {
    print("Excellent")
} else if score >= 60 {
    print("Passed")
} else {
    print("Try again")
}
// Output: Passed
```

- Conditions are checked from top to bottom; only the first matching branch runs.
- `else` is optional and runs when none of the earlier conditions match.
- Conditions must be Boolean (`true` or `false`). Use `if score > 0`, not `if score`.

[Swift: If statements](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/#If-Statement)

### Functions

A **function** groups reusable code under a name. Define it once, then call it whenever needed. Try these examples in your playground.

#### Define and call a function

```swift
func sayHello() {
    print("Hello, Swift!")
}

sayHello() // Output: Hello, Swift!
```

- `func` declares the function; `sayHello` is its name.
- `{ ... }` contains its instructions.
- `sayHello()` calls it. Defining it alone does not run its body.

#### Parameters and arguments

Parameters let a function receive input.

```swift
func greet(name: String) {
    print("Hello, \(name)!")
}

greet(name: "Rishabh") // Hello, Rishabh!
greet(name: "Anu")     // Hello, Anu!
```

`name` is the **parameter** in the definition. `"Rishabh"` is the **argument** supplied by the caller. `String` specifies the input type.

#### Return values

Use `-> Type` to declare a result and `return` to send it back.

```swift
func add(a: Int, b: Int) -> Int {
    return a + b
}

let total = add(a: 4, b: 6)
print(total) // 10
```

`return` gives the caller a value and exits the function; `print` displays text in the console. Without a return type, a function returns `Void` (no meaningful result).

[Swift: Functions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/)

#### Argument labels

By default, the parameter name is also the label used when calling. You can customize the label or omit it with `_`.

```swift
func welcome(to name: String) {
    print("Welcome, \(name)!")
}

welcome(to: "Rishabh") // Welcome, Rishabh!

func square(_ number: Int) -> Int {
    return number * number
}

print(square(5)) // 25
```

- `to` is the external label; `name` is used inside the function.
- `_` removes the call-site label: `square(5)`.

#### Default parameter values

A default is used when the caller leaves that argument out.

```swift
func orderCoffee(size: String = "Medium") {
    print("Coffee size: \(size)")
}

orderCoffee()              // Coffee size: Medium
orderCoffee(size: "Large") // Coffee size: Large
```

[Swift: Function declarations](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations/#Function-Declaration)
