//
//  FZRegion.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation
import CoreLocation

open class FZRegion: NSObject {

    public let region: CLRegion

    public init(region: CLRegion) {
        self.region = region
        super.init()
    }

    /**
     *  identifier
     *
     *  Discussion:
     *    Returns the region's identifier.
     */
    @available(iOS 4.0, *)
    open var identifier: String {
        get {
            return region.identifier
        }
    }

    /**
     *  notifyOnEntry
     *
     *  Discussion:
     *    App will be launched and the delegate will be notified via locationManager:didEnterRegion:
     *    when the user enters the region. By default, this is YES.
     */
    @available(iOS 7.0, *)
    open var notifyOnEntry: Bool {
        get {
            return region.notifyOnEntry
        }
        set {
            region.notifyOnEntry = newValue
        }
    }

    /**
     *  notifyOnExit
     *
     *  Discussion:
     *    App will be launched and the delegate will be notified via locationManager:didExitRegion:
     *    when the user exits the region. By default, this is YES.
     */
    @available(iOS 7.0, *)
    open var notifyOnExit: Bool {
        get {
            return region.notifyOnExit
        }
        set {
            region.notifyOnExit = newValue
        }
    }
}
