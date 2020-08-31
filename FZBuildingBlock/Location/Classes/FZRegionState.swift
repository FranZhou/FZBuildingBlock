//
//  FZRegionState.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation
import CoreLocation

open class FZRegionState: NSObject {

    public let regionState: CLRegionState

    public init(regionState: CLRegionState) {
        self.regionState = regionState
        super.init()
    }
}
