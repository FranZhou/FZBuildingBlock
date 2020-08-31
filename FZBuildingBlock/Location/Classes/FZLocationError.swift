//
//  FZLocationError.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation

public struct FZLocationError: Error {
    public var error: Error?
    public var code: Int
    public var message: String

    public init(code: Int, message: String) {
        self.error = nil
        self.code = code
        self.message = message
    }

    public init(error: Error) {
        self.error = error
        self.code = (error as NSError).code
        self.message = error.localizedDescription
    }

    /// 未获取到新的定位地点, code = 100
    public static var oldCoordinateError: FZLocationError {
        return FZLocationError(code: 100, message: "未获取到新的定位地点")
    }

    /// 未开启定位权限, code = 200
    public static var noOpenLocationAuthorization: FZLocationError {
        return FZLocationError(code: 200, message: "未开启指定定位权限")
    }

    /// 还未获取到定位地点, code = 300
    public static var locationUpdateNotyet: FZLocationError {
        return FZLocationError(code: 300, message: "还未获取到定位地点")
    }
}
