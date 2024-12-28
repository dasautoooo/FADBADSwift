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
    
    public func reset() {}
    
    // MARK: - Operator overloading
    
    subscript (_ index: Int) -> Double {
        get {
            return taylorBridge.getSubscriptValue(Int32(index))
        }
        
        set(newValue) {
            taylorBridge.setSubscriptValue(Int32(index), newValue)
        }
        
    }
    
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
    
    // prefix -
    
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
    
}

func sqrt(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.sqrt(value.taylorBridge))
}


func sin(_ value: TaylorValue) -> TaylorValue {
    return TaylorValue(fadbad.bridge.sin(value.taylorBridge))
}
