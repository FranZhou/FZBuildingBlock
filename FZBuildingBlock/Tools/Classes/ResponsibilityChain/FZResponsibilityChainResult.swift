//
//  FZResponsibilityChainResult.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/17.
//

import Foundation

enum FZResponsibilityChainResult<T> {

    case next( @autoclosure () -> FZResponsibilityChainResult<T> )

    case finish( @autoclosure () -> T)

}
