//
//  FZAssociatedObjects.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/4.
//

import Foundation

public final class FZAssociatedObjects: NSObject {

    /// default singleton instance
    public static let `default` = FZAssociatedObjects()

    /// associatedObjects holder
    private let associatedObjects: NSMapTable<AnyObject, FZAssociatedObjectManager> = {
        let associatedObjects = NSMapTable<AnyObject, FZAssociatedObjectManager>.weakToStrongObjects()
        return associatedObjects
    }()

    /// lock
    private let lock = NSLock()

    // MARK: - init
    private override init() {

    }

}

/// private
extension FZAssociatedObjects {

    /// remove all associated value for object
    /// - Parameter object: object
    private func removeAll(forObject object: AnyObject) {
        associatedObjects.removeObject(forKey: object)
    }

    /// remove associated value with object and key
    /// - Parameters:
    ///   - object: object
    ///   - key: key
    private func remove(forObject object: AnyObject, key: AnyObject) {
        if let objectManager = associatedObjects.object(forKey: object) {
            FZAssociationPolicyType.allCases.forEach { (policy) in
                objectManager.setObjectAssociated(value: nil, key: key, policy: policy)
            }
        }
    }

    /// set associated value
    /// - Parameters:
    ///   - object: object
    ///   - value: value
    ///   - key: key
    ///   - policy: policy
    private func setValue(forObject object: AnyObject, _ value: AnyObject?, _ key: AnyObject, _ policy: FZAssociationPolicyType) {
        var objectManager: FZAssociatedObjectManager!
        objectManager = associatedObjects.object(forKey: object)
        if objectManager == nil {
            objectManager = FZAssociatedObjectManager(associatedObject: object)
            associatedObjects.setObject(objectManager, forKey: object)
        }
        objectManager.setObjectAssociated(value: value, key: key, policy: policy)
    }

    /// get associated value
    /// - Parameters:
    ///   - object: object
    ///   - key: key
    /// - Returns: value
    private func getValue(forObject object: AnyObject, _ key: AnyObject) -> AnyObject? {
        var value: AnyObject?
        if let objectManager = associatedObjects.object(forKey: object) {
            for policy in FZAssociationPolicyType.allCases {
                value = objectManager.getObjectAssociatedPolicyValue(key: key, policy: policy)
                if value != nil {
                    break
                }
            }
        }
        return value
    }
}

/// public
extension FZAssociatedObjects {

    /// remove all associated Objects for object
    /// - Parameter object: object
    public func removeAssociatedObjects(_ object: AnyObject) {
        lock.lock()
        defer {
            lock.unlock()
        }
        removeAll(forObject: object)
    }

    /// set associated Object
    /// - Parameters:
    ///   - object: object
    ///   - key: key
    ///   - value: value
    ///   - policy: policy
    public func setAssociatedObject(_ object: AnyObject, key: AnyObject, value: AnyObject?, policy: FZAssociationPolicyType) {
        lock.lock()
        defer {
            lock.unlock()
        }
        remove(forObject: object, key: key)

        setValue(forObject: object, value, key, policy)
    }

    /// get associated Object
    /// - Parameters:
    ///   - object: object
    ///   - key: key
    /// - Returns: value
    public func getAssociatedObject(_ object: AnyObject, key: AnyObject) -> AnyObject? {

        lock.lock()
        defer {
            lock.unlock()
        }

        return getValue(forObject: object, key)
    }

}

/// class method
extension FZAssociatedObjects {

    /// remove all associated Objects for object
    /// - Parameter object: object
    public class func removeAssociatedObjects(_ object: AnyObject) {
        FZAssociatedObjects.default.removeAssociatedObjects(object)
    }

    /// set associated Object
    /// - Parameters:
    ///   - object: object
    ///   - key: key
    ///   - value: value
    ///   - policy: policy
    public class func setAssociatedObject(_ object: AnyObject, key: AnyObject, value: AnyObject?, policy: FZAssociationPolicyType) {
        FZAssociatedObjects.default.setAssociatedObject(object, key: key, value: value, policy: policy)
    }

    /// get associated Object
    /// - Parameters:
    ///   - object: object
    ///   - key: key
    /// - Returns: value
    public class func getAssociatedObject(_ object: AnyObject, key: AnyObject) -> AnyObject? {
        FZAssociatedObjects.default.getAssociatedObject(object, key: key)
    }
}
