//
//  TaylorValue.swift
//  FADBADSwift
//
//  Created by Leonard Chan on 12/27/24.
//

import fadbadxx

typealias T = TaylorValue

public class TaylorValue {
    fileprivate var taylorBridge: fadbad.bridge.TaylorBridge
    
    public init (_ value: Double) {
        taylorBridge = fadbad.bridge.TaylorBridge(value)
    }
    
    fileprivate init (_ bridge: fadbad.bridge.TaylorBridge) {
        taylorBridge = bridge
    }
    
    public func evaluate(to i: UInt) {
        taylorBridge.eval(UInt32(i))
    }
    
    public func reset() {
        taylorBridge.reset()
    }
    
    // MARK: - Operator overloading
    
    subscript (_ index: Int) -> Double {
        get {
            return taylorBridge.getSubscriptValue(Int32(index))
        }
        
        set(newValue) {
            taylorBridge.setSubscriptValue(Int32(index), newValue)
        }
        
    }
    
    // MARK: - Operator overloading: Binary
    
    static func + (lhs: TaylorValue, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildAddition(lhs.taylorBridge, rhs.taylorBridge))
    }
    
    static func + (lhs: TaylorValue, rhs: Double) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildAddition(lhs.taylorBridge, rhs))
    }
    
    static func + (lhs: Double, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildAddition(lhs, rhs.taylorBridge))
    }
    
    static func - (lhs: TaylorValue, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs.taylorBridge, rhs.taylorBridge))
    }
    
    static func - (lhs: TaylorValue, rhs: Double) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs.taylorBridge, rhs))
    }
    
    static func - (lhs: Double, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs, rhs.taylorBridge))
    }
    
    static func * (lhs: TaylorValue, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildMultiplication(lhs.taylorBridge, rhs.taylorBridge))
    }
    
    static func * (lhs: TaylorValue, rhs: Double) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildMultiplication(lhs.taylorBridge, rhs))
    }
    
    static func * (lhs: Double, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildMultiplication(lhs, rhs.taylorBridge))
    }
    
    static func / (lhs: TaylorValue, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs.taylorBridge, rhs.taylorBridge))
    }
    
    static func / (lhs: TaylorValue, rhs: Double) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs.taylorBridge, rhs))
    }
    
    static func / (lhs: Double, rhs: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildDivision(lhs, rhs.taylorBridge))
    }
    
    // MARK: - Operator overloading: Unary
    
    static prefix func - (value: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildUnaryMinus(value.taylorBridge))
    }
    
    static prefix func + (value: TaylorValue) -> TaylorValue {
        return TaylorValue(fadbad.bridge.BuildUnaryPlus(value.taylorBridge))
    }
    
}

func pow(_ value1: TaylorValue, _ value2: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.pow(value1.taylorBridge, value2.taylorBridge))
}

func pow(_ value1: Double, _ value2: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.pow(value1, value2.taylorBridge))
}

func pow(_ value1: TaylorValue, _ value2: Double) -> TaylorValue {
    return TaylorValue(fadbad.bridge.pow(value1.taylorBridge, value2))
}

func square(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.square(value.taylorBridge))
}

func exp(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.exp(value.taylorBridge))
}

func log(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.log(value.taylorBridge))
}

func sqrt(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.sqrt(value.taylorBridge))
}

func sin(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.sin(value.taylorBridge))
}

func cos(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.cos(value.taylorBridge))
}

func tan(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.tan(value.taylorBridge))
}

func asin(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.asin(value.taylorBridge))
}

func acos(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.acos(value.taylorBridge))
}

func atan(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.atan(value.taylorBridge))
}

func differentiate(_ value: TaylorValue, to order: UInt) -> TaylorValue {
    return TaylorValue(fadbad.bridge.differentiate(value.taylorBridge, UInt32(order)))
}
