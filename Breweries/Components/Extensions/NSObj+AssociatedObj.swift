//
//  NSObj+AssociatedObj.swift
//  Breweries
//
//  Created by Taras Chernysh on 15.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

enum AssociationPolicy {
    case assign
    case retainNonatomic
    case copyNonatomic
    case retain
    case copy
    
    fileprivate var rawValue: objc_AssociationPolicy {
        switch self {
        case .assign: return .OBJC_ASSOCIATION_ASSIGN
        case .retainNonatomic: return .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        case .copyNonatomic: return .OBJC_ASSOCIATION_COPY_NONATOMIC
        case .retain: return .OBJC_ASSOCIATION_RETAIN
        case .copy: return .OBJC_ASSOCIATION_COPY
        }
    }
}

enum ObjcRuntime {
    static func setAssociatedObject<T>(object: AnyObject,
                                       value: T,
                                       key: UnsafeRawPointer,
                                       policy: AssociationPolicy) {
        objc_setAssociatedObject(object, key, value as AnyObject, policy.rawValue)
    }
    
    static func getAssociatedObject<T>(object: AnyObject, key: UnsafeRawPointer) -> T? {
        return (objc_getAssociatedObject(object, key) as AnyObject) as? T
    }
}

extension NSObject {
    func setAssociatedObject<T>(value: T, key: UnsafeRawPointer, policy: AssociationPolicy) {
        ObjcRuntime.setAssociatedObject(object: self, value: value, key: key, policy: policy)
    }
    
    func getAssociatedObject<T>(key: UnsafeRawPointer) -> T? {
        return ObjcRuntime.getAssociatedObject(object: self, key: key)
    }
}
