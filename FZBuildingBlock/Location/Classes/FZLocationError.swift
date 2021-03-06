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

    public init?(error: Error?) {
        if let error = error {
            self.error = error
            self.code = (error as NSError).code
            self.message = error.localizedDescription
        } else {
            return nil
        }
    }
}
