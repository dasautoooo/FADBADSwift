# **FADBADSwift**

`FADBADSwift` is a Swift framework that bridges the powerful [FADBAD++](http://uning.dk/fadbad.html) C++ library to Swift. It allows you to work with Taylor series, perform mathematical operations, and compute derivatives. This project also explores how Swift and C++ can work together seamlessly.

Currently, the framework focuses on **Taylor Series Expansion**. **Forward** and **Backward mode differentiation** are under development.

## What Is FADBAD++?

The FADBAD++ library is a high-performance framework for automatic differentiation in C++. It provides tools for:

- Forward Mode Differentiation (FAD).
- Backward Mode Differentiation (BAD).
- Taylor Series Expansion.

FDBADSwift brings the functionality of FADBAD++ into the Swift ecosystem, starting with the Taylor series part.

## **Features**

- [x] **Taylor Series Representation**: Represent functions as Taylor series with simple initialization.
- [x] **Arithmetic Operations**: Support for `+`, `-`, `*`, `/` with Taylor series and constants.
- [x] **Symbolic Differentiation**: Compute derivatives of Taylor series to any order.
- [x] **Swift and C++ Interoperability**: Seamlessly bridge the powerful `fadbad` C++ library to Swift.
- [x] **Mathematical Functions**: Includes `sqrt`, `sin`, `cos`, `exp`, `log`, and more.
- [x] **Subscript Access**: Easily access or set Taylor series coefficients with subscript syntax.
- [x] **Evaluation**: Compute Taylor coefficients up to a specified order.
- [x] **Initial Value Problems (IVP)**: Solve simple ODEs using Taylor series expansion.

### **Work in Progress**
- [ ] **Forward Mode Differentiation**: Implement support for FAD (Forward Automatic Differentiation).
- [ ] **Backward Mode Differentiation**: Implement support for BAD (Backward Automatic Differentiation).
- [ ] **Generic Support**: Add support for generic numeric types (e.g., `Float`, `Double`).
- [ ] **Performance Optimization**: Improve Swift-C++ interop efficiency.

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding FADBADSwift as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift` or the Package list in Xcode.

```swift
dependencies: [
    .package(url: "https://github.com/dasautoooo/FADBADSwift.git", .upToNextMajor(from: "1.0.0"))
]
```

Then, you can depend on the `FADBADSwift` target in your package:

```swift
.product(name: "FADBADSwift", package: "FADBADSwift")
```

This will include the `FADBADSwift` library in your project, giving you access to all the Taylor series and differentiation features provided by the framework.

## Comprehensive Example: Taylor Series and ODEs

This example demonstrates the usage of `FADBADSwift` by computing the Taylor expansion of the function:

\[
f(x, y) = y \cdot \sqrt{x} + \sin(\sqrt{x})
\]

We calculate the Taylor coefficients of \( f(x, y) \) with respect to both \( x \) and \( y \).

### Code Example

```swift
import FADBADSwift

/// A function that demonstrates the usage of Taylor series expansion.
/// The function computes `y * sqrt(x) + sin(sqrt(x))` and evaluates its Taylor coefficients.
func funcExample(_ x: T, _ y: T) -> T {
    let z = sqrt(x) // Compute z = sqrt(x)
    return y * z + sin(z) // Compute f = y * z + sin(z)
}

func main() {
    // Step 1: Declare variables x, y, and f
    var x = T(1.0) // Initialize x as a Taylor series centered at 1.0
    var y = T(2.0) // Initialize y as a Taylor series centered at 2.0
    var f: T       // Declare f to store the result

    // Step 2: Mark x as the independent variable (dx/dx = 1)
    x[1] = 1.0

    // Step 3: Compute the function and record its computational graph (DAG)
    f = funcExample(x, y)

    // Step 4: Evaluate the Taylor expansion of f up to degree 10
    f.evaluate(to: 10)

    // Step 5: Print the value and Taylor coefficients with respect to x
    let fval = f[0] // Value of the function at x = 1, y = 2
    print("f(x, y) = \(fval)")
    for i in 0...10 {
        let c = f[i] // The i-th Taylor coefficient
        print("(1/\(i)!) * (d^\(i)f/dx^\(i)) = \(c)")
    }

    // Step 6: Reset the DAG
    f.reset()

    // Step 7: Change the values of x and y
    x[0] = 3.0 // New value for x
    y[0] = 4.0 // New value for y

    // Step 8: Mark y as the independent variable (dy/dy = 1)
    y[1] = 1.0

    // Step 9: Recompute and re-evaluate the Taylor expansion of f up to degree 10
    f = funcExample(x, y)
    f.evaluate(to: 10)

    // Step 10: Print the Taylor coefficients with respect to y
    for i in 0...10 {
        let c = f[i] // The i-th Taylor coefficient
        print("(1/\(i)!) * (d^\(i)f/dy^\(i)) = \(c)")
    }
}

// Call the main function to run the example
main()

```

### Explanation

1. **Define the Function**:  
   The function `funcExample` computes \( f(x, y) = y \cdot \sqrt{x} + \sin(\sqrt{x}) \). It takes two Taylor series variables as inputs and returns their computed result as a Taylor series.

2. **Independent Variables**:  
   The framework allows marking variables as independent by setting their first derivative coefficients to 1.  
   ```swift
   x[1] = 1.0 // dx/dx = 1
   y[1] = 1.0 // dy/dy = 1
   ```
3. **Evaluate Taylor Coefficients**:  
   The `evaluate(to:)` method calculates the coefficients of the Taylor series expansion of \( f(x, y) \) up to the specified order (10 in this example). These coefficients represent the derivatives of \( f(x, y) \) at the series' center.

   ```swift
   f.evaluate(to: 10)
   ```
4. **Reset for Reuse**:  
   The `reset()` method clears all computed coefficients in the Taylor series, allowing the computational graph (DAG) to be reused with new values or for a different independent variable. The base value of the series remains unchanged.

   ```swift
   f.reset() // Clear all computed coefficients
   ```
5. **Change Independent Variable**:  
   After resetting, you can switch the independent variable. Initially, `x` is the independent variable (\( dx/dx = 1 \)). By setting `y[1]` to 1, `y` is now marked as the independent variable (\( dy/dy = 1 \)).

   ```swift
   y[1] = 1.0 // Set y as the independent variable
   ```
6. **Print Results**:  
   Access the Taylor coefficients using subscript syntax (e.g., `f[i]`), where \( i \) is the order of the derivative. Iterate through the coefficients and print them to verify the Taylor expansion.

   ```swift
   for i in 0...10 {
       let c = f[i] // The i-th Taylor coefficient
       print("(1/\(i)!) * (d^\(i)f/dy^\(i)) = \(c)")
   }
   ```

## Credits

FADBADSwift is built on top of the [FADBAD++](http://uning.dk/fadbad.html) library, which was created by Claus Bendtsen and Ole Stauning. This framework adapts their powerful C++ library for use in Swift.

FADBAD++ is copyright 1996–2007 Claus Bendtsen and Ole Stauning. For non-commercial use, FADBAD++ is free to use. For commercial purposes, please contact the authors. The full copyright notice can be found in the source code and is summarized below.

For more information about FADBAD++, visit [the official website](http://uning.dk/fadbad.html).

---

## License

FADBADSwift is released under the GPL v3 license. See [LICENSE](./LICENSE) for details.

**FADBAD++ Copyright Notice:**

FADBAD++ is provided "as is," without any warranty of any kind, either expressed or implied. The authors are not responsible for any damages arising out of the use of the library. FADBAD++ may not be used in commercial packages without prior written permission from the authors. Verbatim copies of the source code may be distributed as long as this copyright notice is preserved.

By using FADBADSwift or FADBAD++, you agree to abide by the terms of the license.
