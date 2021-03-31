//
//  Date+Component.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2021/3/10.
//

import Foundation

extension FZBuildingBlockWrapper where Base == Date {

    /// 纪元
    public var era: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.era, from: base)
        }
    }

    /// 年
    public var year: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.year, from: base)
        }
    }

    /// 月
    public var month: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.month, from: base)
        }
    }

    /// 日
    public var day: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.day, from: base)
        }
    }

    /// 时
    public var hour: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.hour, from: base)
        }
    }

    /// 分
    public var minute: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.minute, from: base)
        }
    }

    /// 秒
    public var second: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.second, from: base)
        }
    }

    /// 一周的第几天
    public var weekday: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.weekday, from: base)
        }
    }

    /// 本月的第几个weekday
    public var weekdayOrdinal: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.weekdayOrdinal, from: base)
        }
    }

    /// 季度，0-3 ，0表示12月1月2月
    public var quarter: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.quarter, from: base)
        }
    }

    /// 本月第几周
    public var weekOfMonth: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.weekOfMonth, from: base)
        }
    }

    /// 本年第几周
    public var weekOfYear: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.weekOfYear, from: base)
        }
    }

    /// ISO8601标准下的年份。该标准一年有52或53周，在最后一周时，可能会出现该周属于2020年，但在ISO8601标准，该周属于2021年。
    public var yearForWeekOfYear: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.yearForWeekOfYear, from: base)
        }
    }

    /// 纳秒
    public var nanosecond: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.nanosecond, from: base)
        }
    }

    /// 日历
    public var calendar: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.calendar, from: base)
        }
    }

    /// 时区
    public var timeZone: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(Calendar.Component.timeZone, from: base)
        }
    }

}
