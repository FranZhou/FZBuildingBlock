//
//  FZAssociatedObjectManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/4.
//

import Foundation

class FZAssociatedObjectManager {

    private weak var associatedObject: AnyObject?

    /// associatedObjects holder
    private let objectPolicyMap: NSMapTable<FZAssociationPolicyType.RawValue, FZAssociatedPolicyManager> = {
        let objectPolicyMap = NSMapTable<FZAssociationPolicyType.RawValue, FZAssociatedPolicyManager>.strongToStrongObjects()
        return objectPolicyMap
    }()

    init(associatedObject: AnyObject) {
        self.associatedObject = associatedObject
    }

}

extension FZAssociatedObjectManager {

    public func getObjectAssociatedPolicyValue(key: AnyObject, policy: FZAssociationPolicyType) -> AnyObject? {
        return objectPolicyMap.object(forKey: policy.rawValue)?.getPoliceAssociatedValue(forKey: key)

    }

    public func setObjectAssociated(value: AnyObject?, key: AnyObject, policy: FZAssociationPolicyType) {
        var policyManager: FZAssociatedPolicyManager!
        policyManager = objectPolicyMap.object(forKey: policy.rawValue)
        if policyManager == nil {
            policyManager = FZAssociatedPolicyManager(associatedObjectPolicy: policy.rawValue)
            objectPolicyMap.setObject(policyManager, forKey: policy.rawValue)
        }
        policyManager.setPoliceAssociated(value: value, forKey: key)
    }
}
