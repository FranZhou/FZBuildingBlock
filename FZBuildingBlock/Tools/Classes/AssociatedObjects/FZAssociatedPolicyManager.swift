//
//  FZAssociatedPolicyManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/4.
//

import Foundation

class FZAssociatedPolicyManager {

    private let associatedObjectPolicy: FZAssociationPolicyType.RawValue

    /// associatedObjects holder
    private var policyValueMap: NSMapTable<AnyObject, AnyObject>?

    init(associatedObjectPolicy: FZAssociationPolicyType.RawValue) {
        self.associatedObjectPolicy = associatedObjectPolicy
    }

}

extension FZAssociatedPolicyManager {

    public func getPoliceAssociatedValue(forKey key: AnyObject) -> AnyObject? {
        var value = policyValueMap?.object(forKey: key)

        let policyType = FZAssociationPolicyType(rawValue: associatedObjectPolicy)
        if policyType == .weak,
            let weakValue = value as? FZAssociationWeakValueBox {
            value = weakValue.value
        }

        return value
    }

    public func setPoliceAssociated(value: AnyObject?, forKey key: AnyObject) {
        let policyType = FZAssociationPolicyType(rawValue: associatedObjectPolicy)
        if policyValueMap == nil {
            policyValueMap = NSMapTable<AnyObject, AnyObject>.strongToStrongObjects()
        }
        if let value = value {
            switch policyType {
            case .weak:
                policyValueMap?.setObject(FZAssociationWeakValueBox(value), forKey: key)
            default:
                policyValueMap?.setObject(value, forKey: key)
            }
        } else {
            policyValueMap?.setObject(nil, forKey: key)
        }
    }

}
