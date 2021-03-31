//
//  Date+Utility.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2021/3/10.
//

import Foundation

extension FZBuildingBlockWrapper where Base == Date {

    /// 是否为同一天
    /// - Parameter other: other Date
    /// - Returns: Bool
    public func isSameDay(withDate other: Date) -> Bool {
        return base.fz.year == other.fz.year
            && base.fz.month == other.fz.month
            && base.fz.day == other.fz.day
    }

    /// 日期是否为今天
    /// - Returns: Bool
    public func isToday() -> Bool {
        return base.fz.isSameDay(withDate: Date.init())
    }

}

extension FZBuildingBlockWrapper where Base == Date {

    /// 日期偏移
    /// - Parameters:
    ///   - years: years description
    ///   - months: months description
    ///   - days: days description
    ///   - hours: hours description
    ///   - minutes: minutes description
    ///   - seconds: seconds description
    /// - Returns: description
    public func dateByAdding(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let gregorian = Calendar.init(identifier: Calendar.Identifier.gregorian)

        var addingComponents = DateComponents.init()
        addingComponents.setValue(years, for: Calendar.Component.year)
        addingComponents.setValue(months, for: Calendar.Component.month)
        addingComponents.setValue(days, for: Calendar.Component.day)
        addingComponents.setValue(hours, for: Calendar.Component.hour)
        addingComponents.setValue(minutes, for: Calendar.Component.minute)
        addingComponents.setValue(seconds, for: Calendar.Component.second)

        return gregorian.date(byAdding: addingComponents, to: base)
    }

    /// date转string
    /// - Parameter dateFormat: dateFormat description
    /// - Returns: description
    public func string(with dateFormat: String, locale: Locale = Locale.current) -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = dateFormat
        formatter.locale = locale
        return formatter.string(from: base)
    }
}


extension Date.fz{
    
    
    /// string转date
    /// - Parameters:
    ///   - dateString: dateString description
    ///   - dateFormat: dateFormat description
    /// - Returns: description
    public static func date(form dateString: String, dateFormat: String, locale: Locale = Locale.current) -> Date? {
        let formatter = DateFormatter.init()
        formatter.dateFormat = dateFormat
        formatter.locale = locale
        return formatter.date(from: dateString)
    }
    
    
    public static func date(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0, identifier: Calendar.Identifier = Calendar.Identifier.gregorian) -> Date? {
        let gregorian = Calendar.init(identifier: Calendar.Identifier.gregorian)

        var components = DateComponents.init()
        components.setValue(years, for: Calendar.Component.year)
        components.setValue(months, for: Calendar.Component.month)
        components.setValue(days, for: Calendar.Component.day)
        components.setValue(hours, for: Calendar.Component.hour)
        components.setValue(minutes, for: Calendar.Component.minute)
        components.setValue(seconds, for: Calendar.Component.second)
        
        return gregorian.date(from: components)
    }
    
}
