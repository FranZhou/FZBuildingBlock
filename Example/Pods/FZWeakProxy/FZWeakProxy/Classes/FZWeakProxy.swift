//
//  FZWeakProxy.swift
//  FZWeakProxy
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation

/// swift cannot inherit from NSProxy
public final class FZWeakProxy<T>: NSObject where T: NSObject {

    /// proxy target
    public private(set) weak var target: T?

    // MARK: - init

    public init(target: T) {
        self.target = target
        super.init()
    }

    // MARK: - NSObject
    public class func proxy(withTarget target: T) -> FZWeakProxy<T> {
        return FZWeakProxy(target: target)
    }

    public override func copy() -> Any {
        guard let target = target else {
            fatalError("target is released")
        }
        return target.copy()
    }

    public override func mutableCopy() -> Any {
        guard let target = target else {
            fatalError("target is released")
        }
        return target.mutableCopy()
    }

//    open class func instancesRespond(to aSelector: Selector!) -> Bool

//    open class func conforms(to protocol: Protocol) -> Bool

    public override func method(for aSelector: Selector!) -> IMP! {
        guard let target = target else {
            fatalError("target is released")
        }
        return target.method(for: aSelector)
    }

//    open class func instanceMethod(for aSelector: Selector!) -> IMP!

    public override func doesNotRecognizeSelector(_ aSelector: Selector!) {
        guard let target = target else {
            fatalError("target is released")
        }
        return target.doesNotRecognizeSelector(aSelector)
    }

    public override func forwardingTarget(for aSelector: Selector!) -> Any? {
        guard let target = target else {
            return nil
        }
        return target
    }

//    open class func isSubclass(of aClass: AnyClass) -> Bool

//    open class func resolveClassMethod(_ sel: Selector!) -> Bool

//    open class func resolveInstanceMethod(_ sel: Selector!) -> Bool

//    open class func hash() -> Int

//    open class func superclass() -> AnyClass?

//    open class func description() -> String

//    open class func debugDescription() -> String

    // MARK: - NSObjectProtocol

    public override func isEqual(_ object: Any?) -> Bool {
        guard let target = target else {
            return false
        }
        return target.isEqual(object)
    }

    public override var hash: Int {
        guard let target = target else {
            fatalError("target is released")
        }
        return target.hash
    }

    public override var superclass: AnyClass? {
        guard let target = target else {
            fatalError("target is released")
        }
        return target.superclass
    }

//    func `self`() -> Self

    public override func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
        guard let target = target else {
            fatalError("target is released")
        }
        return target.perform(aSelector)
    }

    public override func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
        guard let target = target else {
            fatalError("target is released")
        }
        return target.perform(aSelector, with: object)
    }

    public override func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
        guard let target = target else {
            fatalError("target is released")
        }
        return target.perform(aSelector, with: object1, with: object2)
    }

    public override func isProxy() -> Bool {
        return true
    }

    public override func isKind(of aClass: AnyClass) -> Bool {
        guard let target = target else {
            return false
        }
        return target.isKind(of: aClass)
    }

    public override func isMember(of aClass: AnyClass) -> Bool {
        guard let target = target else {
            return false
        }
        return target.isMember(of: aClass)
    }

    public override func conforms(to aProtocol: Protocol) -> Bool {
        guard let target = target else {
            return false
        }
        return target.conforms(to: aProtocol)
    }

    public override func responds(to aSelector: Selector!) -> Bool {
        guard let target = target else {
            return false
        }
        return target.responds(to: aSelector)
    }

    public override var description: String {
        guard let target = target else {
            fatalError("target is released")
        }
        return target.description
    }

    public override var debugDescription: String {
        guard let target = target else {
            fatalError("target is released")
        }
        return target.debugDescription
    }

}
