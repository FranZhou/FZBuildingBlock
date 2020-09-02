//
//  FZLocationConfiguration.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation
import CoreLocation

public struct FZLocationConfiguration {

    /// 没有定位权限时，调用此方法交由外部处理
    public static var locationAuthorizationAction: ((CLAuthorizationStatus) -> Void)?

    /// 请求定位权限类型, 默认 always
    public static var requestAuthorizationType: FZLocationManager.AuthorizationType = .always

    /// 判断是否显示方向的校对
    public static var shouldDisplayHeadingCalibration: Bool = false

    /// 日志打印
    public static var locationLog: ((_ items: Any...) -> Void)?
}
