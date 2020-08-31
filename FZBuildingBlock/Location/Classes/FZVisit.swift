//
//  FZVisit.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation
import CoreLocation

open class FZVisit: NSObject {

    public let visit: CLVisit

    public init(visit: CLVisit) {
        self.visit = visit
        super.init()
    }

    /**
     *  arrivalDate
     *
     *  Discussion:
     *    The date when the visit began.  This may be equal to [NSDate
     *    distantPast] if the true arrival date isn't available.
     */
    open var arrivalDate: Date {
        get {
            return visit.arrivalDate
        }
    }

    /**
     *  departureDate
     *
     *  Discussion:
     *    The date when the visit ended.  This is equal to [NSDate
     *    distantFuture] if the device hasn't yet left.
     */
    open var departureDate: Date {
        get {
            return visit.departureDate
        }
    }

    /**
     *  coordinate
     *
     *  Discussion:
     *    The center of the region which the device is visiting.
     */
    open var coordinate: CLLocationCoordinate2D {
        get {
            return visit.coordinate
        }
    }

    /**
     *
     *  horizontalAccuracy
     *
     *  Discussion:
     *    An estimate of the radius (in meters) of the region which the
     *    device is visiting.
     */
    open var horizontalAccuracy: CLLocationAccuracy {
        get {
            return visit.horizontalAccuracy
        }
    }
}
