//
//  ClosuresExtensions.swift
//  CashApp
//
//  Created by iMokhles on 05/01/2018.
//  Copyright © 2018 iMokhles. All rights reserved.
//

import Foundation
class DicWrapper<K: Hashable, V> {
    var dic = [K: V]()
}

class ArrayWrapper<T> {
    var array = [T]()
}

class ClosureWrapper<T> {
    var closure: (T) -> Void
    init(_ closure: @escaping (T) -> Void) {
        self.closure = closure
    }
}

public protocol Attachable {
    
    func set(_ attachObj: Any?, forKey key: inout UInt)
    func getAttach(forKey key: inout UInt) -> Any?
    
}

extension Attachable {
    
    public func set(_ attachObj: Any?, forKey key: inout UInt) {
        objc_setAssociatedObject(self, &key, attachObj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func getAttach(forKey key: inout UInt) -> Any? {
        return objc_getAssociatedObject(self, &key)
    }
}
