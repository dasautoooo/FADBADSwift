//
//  TaylorValue.swift
//  FADBADSwift
//
//  Created by Leonard Chan on 12/27/24.
//

import fadbadxx

/// A typealias for the `TaylorValue` class, representing a value in a Taylor series.
typealias T = TaylorValue

/// Represents a value in a Taylor series expansion, supporting operations like addition,
/// subtraction, multiplication, division, and symbolic differentiation.
///
/// Taylor series provide a mathematical representation of a function as an infinite sum
/// of terms, calculated from the derivatives of the function at a single point.
public class TaylorValue {
    
    /// The underlying bridge object to interact with the FADBAD library.
    fileprivate var taylorBridge: fadbad.bridge.TaylorBridge
    
    // MARK: - Initializers
    
    /// Creates a new Taylor series value with a constant value.
    ///
    /// ```swift
    /// let x = T(1.0)
    /// // Represents a Taylor series centered at 1.0
    /// ```
    ///
    /// - Parameter value: The constant value of the Taylor series.
    public init (_ value: Double) {
        taylorBridge = fadbad.bridge.TaylorBridge(value)
    }
    
    fileprivate init (_ bridge: fadbad.bridge.TaylorBridge) {
        taylorBridge = bridge
    }
    
    // MARK: - Public functions
    
    /// Computes the coefficients of the Taylor series expansion up to the specified order.
    ///
    /// This method evaluates the series to determine all terms up to the given degree.
    ///
    /// ```swift
    /// let x = T(1.0)
    /// x[1] = 1
    /// x.evaluate(to: 5)
    /// // Computes coefficients for x, x^2/2!, ..., x^5/5!
    /// ```
    ///
    /// - Parameter i: The maximum order of the Taylor expansion to compute.
    public func evaluate(to i: UInt) {
        taylorBridge.eval(UInt32(i))
    }
    
    /// Resets the Taylor series, clearing all computed coefficients while retaining the base value.
    ///
    /// This method is useful for reinitializing the series without creating a new instance.
    ///
    /// ```swift
    /// let x = T(1.0)
    /// x.evaluate(to: 5)
    /// x.reset()
    /// // Clears all computed coefficients
    /// ```
    public func reset() {
        taylorBridge.reset()
    }
    
    // MARK: - Operator overloading
    
    /// Accesses the coefficient of a specific order in the Taylor series.
    ///
    /// The subscript provides access to the k-th order coefficient in the series.
    ///
    /// ```swift
    /// let x = T(1.0)
    /// x[1] = 1.0
    /// // Sets the first derivative coefficient to 1.0
    /// ```
    ///
    /// - Parameter index: The order of the coefficient to access or modify.
    /// - Returns: The coefficient of the specified order.
    subscript (_ index: Int) -> Double {
        get {
            return taylorBridge.getSubscriptValue(Int32(index))
        }
        
        set(newValue) {
            taylorBridge.setSubscriptValue(Int32(index), newValue)
        }
        
    }
    
    // MARK: - Operator overloading: Binary
    
    /// Adds two Taylor series values.
    ///
    /// ```swift
    /// let x = T(1.0)
    /// let y = T(2.0)
    /// let result = x + y
    /// // Represents the series for 3.0
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side of the addition.
    ///   - rhs: The right-hand side of the addition.
    /// - Returns: A new Taylor series representing the sum.
    static func + (lhs: TaylorValue, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildAddition(lhs.taylorBridge, rhs.taylorBridge))
    }
    
    /// Adds a Taylor series value and a constant.
    ///
    /// ```swift
    /// let x = T(1.0)
    /// let result = x + 3.0
    /// // Represents the series for 4.0
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The Taylor series value.
    ///   - rhs: The constant value.
    /// - Returns: A new Taylor series representing the sum.
    static func + (lhs: TaylorValue, rhs: Double) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildAddition(lhs.taylorBridge, rhs))
    }
    
    /// Adds a Taylor series value and a constant.
    ///
    /// ```swift
    /// let x = T(1.0)
    /// let result = x + 3.0
    /// // Represents the series for 4.0
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The Taylor series value.
    ///   - rhs: The constant value.
    /// - Returns: A new Taylor series representing the sum.
    static func + (lhs: Double, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildAddition(lhs, rhs.taylorBridge))
    }
    
    /// Subtracts one Taylor series value from another.
    ///
    /// ```swift
    /// let x = T(5.0)
    /// let y = T(3.0)
    /// let result = x - y
    /// // Represents the series for x - y
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side Taylor series value.
    ///   - rhs: The right-hand side Taylor series value.
    /// - Returns: A new Taylor series representing the difference.
    static func - (lhs: TaylorValue, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs.taylorBridge, rhs.taylorBridge))
    }
    
    /// Subtracts a constant from a Taylor series value.
    ///
    /// ```swift
    /// let x = T(5.0)
    /// let result = x - 3.0
    /// // Represents the series for x - 3
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The Taylor series value.
    ///   - rhs: The constant value.
    /// - Returns: A new Taylor series representing the difference.
    static func - (lhs: TaylorValue, rhs: Double) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs.taylorBridge, rhs))
    }
    
    /// Subtracts a Taylor series value from a constant.
    ///
    /// ```swift
    /// let y = T(3.0)
    /// let result = 5.0 - y
    /// // Represents the series for 5 - y
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The constant value.
    ///   - rhs: The Taylor series value.
    /// - Returns: A new Taylor series representing the difference.
    static func - (lhs: Double, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs, rhs.taylorBridge))
    }
    
    /// Multiplies two Taylor series values.
    ///
    /// ```swift
    /// let x = T(2.0)
    /// let y = T(3.0)
    /// let result = x * y
    /// // Represents the series for x * y
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side Taylor series value.
    ///   - rhs: The right-hand side Taylor series value.
    /// - Returns: A new Taylor series representing the product.
    static func * (lhs: TaylorValue, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildMultiplication(lhs.taylorBridge, rhs.taylorBridge))
    }
    
    /// Multiplies a Taylor series value and a constant.
    ///
    /// ```swift
    /// let x = T(2.0)
    /// let result = x * 3.0
    /// // Represents the series for x * 3
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The Taylor series value.
    ///   - rhs: The constant value.
    /// - Returns: A new Taylor series representing the product.
    static func * (lhs: TaylorValue, rhs: Double) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildMultiplication(lhs.taylorBridge, rhs))
    }
    
    /// Multiplies a constant and a Taylor series value.
    ///
    /// ```swift
    /// let y = T(3.0)
    /// let result = 2.0 * y
    /// // Represents the series for 2 * y
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The constant value.
    ///   - rhs: The Taylor series value.
    /// - Returns: A new Taylor series representing the product.
    static func * (lhs: Double, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildMultiplication(lhs, rhs.taylorBridge))
    }
    
    /// Divides one Taylor series value by another.
    ///
    /// ```swift
    /// let x = T(6.0)
    /// let y = T(2.0)
    /// let result = x / y
    /// // Represents the series for x / y
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The numerator Taylor series value.
    ///   - rhs: The denominator Taylor series value.
    /// - Returns: A new Taylor series representing the quotient.
    static func / (lhs: TaylorValue, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs.taylorBridge, rhs.taylorBridge))
    }
    
    /// Divides a Taylor series value by a constant.
    ///
    /// ```swift
    /// let x = T(6.0)
    /// let result = x / 2.0
    /// // Represents the series for x / 2
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The numerator Taylor series value.
    ///   - rhs: The constant denominator value.
    /// - Returns: A new Taylor series representing the quotient.
    static func / (lhs: TaylorValue, rhs: Double) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs.taylorBridge, rhs))
    }
    
    /// Divides a constant by a Taylor series value.
    ///
    /// ```swift
    /// let y = T(2.0)
    /// let result = 6.0 / y
    /// // Represents the series for 6 / y
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The constant numerator value.
    ///   - rhs: The denominator Taylor series value.
    /// - Returns: A new Taylor series representing the quotient.
    static func / (lhs: Double, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs, rhs.taylorBridge))
    }
    
    // MARK: - Operator overloading: Unary
    
    /// Negates a Taylor series value.
    ///
    /// ```swift
    /// let x = T(1.0)
    /// let result = -x
    /// // Represents the series for -1.0
    /// ```
    ///
    /// - Parameter value: The Taylor series value to negate.
    /// - Returns: A new Taylor series representing the negation.
    static prefix func - (value: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildUnaryMinus(value.taylorBridge))
    }
    
    /// Returns the positive value of a Taylor series.
    ///
    /// ```swift
    /// let x = T(2.0)
    /// let result = +x
    /// // Represents the series for x
    /// ```
    ///
    /// - Parameter value: The input Taylor series value.
    /// - Returns: The same Taylor series value.
    static prefix func + (value: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildUnaryPlus(value.taylorBridge))
    }
    
}

/// Computes the power of a Taylor series value raised to another Taylor series value.
///
/// ```swift
/// let base = T(2.0)
/// let exponent = T(3.0)
/// let result = pow(base, exponent)
/// // Represents the series for 2^3
/// ```
///
/// - Parameters:
///   - value1: The base value.
///   - value2: The exponent value.
/// - Returns: A new Taylor series representing the result.
func pow(_ value1: TaylorValue, _ value2: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.pow(value1.taylorBridge, value2.taylorBridge))
}

/// Computes the power of a constant base raised to a Taylor series exponent.
///
/// ```swift
/// let exponent = T(3.0)
/// let result = pow(2.0, exponent)
/// // Represents the series for 2^x
/// ```
///
/// - Parameters:
///   - value1: The constant base value.
///   - value2: The Taylor series exponent.
/// - Returns: A new Taylor series representing the result.
func pow(_ value1: Double, _ value2: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.pow(value1, value2.taylorBridge))
}

/// Computes the power of a Taylor series base raised to a constant exponent.
///
/// ```swift
/// let base = T(2.0)
/// let result = pow(base, 3.0)
/// // Represents the series for x^3
/// ```
///
/// - Parameters:
///   - value1: The Taylor series base value.
///   - value2: The constant exponent.
/// - Returns: A new Taylor series representing the result.
func pow(_ value1: TaylorValue, _ value2: Double) -> TaylorValue {
    return TaylorValue(fadbad.bridge.pow(value1.taylorBridge, value2))
}

/// Squares a Taylor series value.
///
/// ```swift
/// let x = T(2.0)
/// let result = square(x)
/// // Represents the series for x^2
/// ```
///
/// - Parameter value: The input Taylor series value.
/// - Returns: A new Taylor series representing the square.
func square(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.square(value.taylorBridge))
}

/// Computes the exponential of a Taylor series value.
///
/// ```swift
/// let x = T(1.0)
/// let result = exp(x)
/// // Represents the series for e^x
/// ```
///
/// - Parameter value: The input Taylor series value.
/// - Returns: A new Taylor series representing the exponential.
func exp(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.exp(value.taylorBridge))
}

/// Computes the natural logarithm of a Taylor series value.
///
/// ```swift
/// let x = T(2.71828)
/// let result = log(x)
/// // Represents the series for ln(x)
/// ```
///
/// - Parameter value: The input Taylor series value.
/// - Returns: A new Taylor series representing the logarithm.
func log(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.log(value.taylorBridge))
}

/// Computes the square root of a Taylor series value.
///
/// ```swift
/// let x = T(4.0)
/// let result = sqrt(x)
/// // Represents the series for √4
/// ```
///
/// - Parameter value: The input Taylor series value.
/// - Returns: A new Taylor series representing the square root.
func sqrt(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.sqrt(value.taylorBridge))
}

/// Computes the sine of a Taylor series value.
///
/// ```swift
/// let x = T(0.5)
/// let result = sin(x)
/// // Represents the series for sin(x)
/// ```
///
/// - Parameter value: The input Taylor series value.
/// - Returns: A new Taylor series representing the sine.
func sin(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.sin(value.taylorBridge))
}

/// Computes the cosine of a Taylor series value.
///
/// ```swift
/// let x = T(0.5)
/// let result = cos(x)
/// // Represents the series for cos(x)
/// ```
///
/// - Parameter value: The input Taylor series value.
/// - Returns: A new Taylor series representing the cosine.
func cos(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.cos(value.taylorBridge))
}

/// Computes the tangent of a Taylor series value.
///
/// ```swift
/// let x = T(0.5)
/// let result = tan(x)
/// // Represents the series for tan(x)
/// ```
///
/// - Parameter value: The input Taylor series value.
/// - Returns: A new Taylor series representing the tangent.
func tan(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.tan(value.taylorBridge))
}

/// Computes the arcsine of a Taylor series value.
///
/// ```swift
/// let x = T(0.5)
/// let result = asin(x)
/// // Represents the series for arcsin(x)
/// ```
///
/// - Parameter value: The input Taylor series value.
/// - Returns: A new Taylor series representing the arcsine.
func asin(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.asin(value.taylorBridge))
}

/// Computes the arccosine of a Taylor series value.
///
/// ```swift
/// let x = T(0.5)
/// let result = acos(x)
/// // Represents the series for arccos(x)
/// ```
///
/// - Parameter value: The input Taylor series value.
/// - Returns: A new Taylor series representing the arccosine.
func acos(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.acos(value.taylorBridge))
}

/// Computes the arctangent of a Taylor series value.
///
/// ```swift
/// let x = T(0.5)
/// let result = atan(x)
/// // Represents the series for arctan(x)
/// ```
///
/// - Parameter value: The input Taylor series value.
/// - Returns: A new Taylor series representing the arctangent.
func atan(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.atan(value.taylorBridge))
}

/// Computes the differentiation of a Taylor series with respect to its independent variable up to a specified order.
///
/// This function calculates the b-th derivative of the Taylor series represented by `value` with respect to
/// the variable marked as the independent variable (typically achieved by setting the first-order coefficient to 1, e.g., `x[1] = 1.0`).
/// The result is a new Taylor series representing the b-th derivative.
///
/// ```swift
/// let x = T(1.0)
/// x[1] = 1.0  // Mark x as the independent variable
/// let f = T(2.0) * sqrt(x) + sin(sqrt(x))  // Define a function in terms of x
/// let derivative = differentiate(f, to: 2)
/// // Represents the second derivative of f with respect to x
/// ```
///
/// - Parameters:
///   - value: The Taylor series to differentiate. This represents the function f(x) whose derivatives are computed.
///   - order: The order b of the derivative to compute.
/// - Returns: A new Taylor series representing the computed b-th derivative of the input function.
func differentiate(_ value: TaylorValue, to order: UInt) -> TaylorValue {
    return TaylorValue(fadbad.bridge.differentiate(value.taylorBridge, UInt32(order)))
}
