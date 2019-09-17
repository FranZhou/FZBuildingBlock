//
//  FZAttribute.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

/// 基于 NSAttributedNames 的封装，请根据使用情况自行添加类型
///
/// - font: 字体. 默认:Helvetica(Neue) 12
/// - paragraphStyle: 段落样式. NSParagraphStyle, default defaultParagraphStyle
/// - foregroundColor: 字体颜色. UIColor, default blackColor
/// - backgroundColor: 背景颜色. UIColor, default nil: no background
/// - ligature: 连笔字. NSNumber containing integer, default 1: default ligatures, 0: no ligatures
/// - kern: 字符间距. NSNumber containing floating point value, in points; amount to modify default kerning. 0 means kerning is disabled.
/// - strikethrough: 删除线(strikethroughStyle, strikethroughColor).
///                  strikethroughStyle： NSNumber containing integer, default 0: no strikethrough
///                  strikethroughColor：UIColor, default nil: same as foreground color
/// - underline: 下划线(underlineStyle, underlineColor).
///              underlineStyle： NSUnderlineStyle， default 0: no strikethrough
///              underlineColor：UIColor, default nil: same as foreground color
/// - stroke: 字体描边(strokeWidth, strokeColor).
///           strokeWidth：NSNumber containing floating point value, in percent of font point size, default 0: no stroke; positive for stroke alone, negative for stroke and fill (a typical value for outlined text would be 3.0)
///           strokeColor：UIColor, default nil: same as foreground color
/// - shadow: 阴影. NSShadow, default nil: no shadow
/// - textEffect: 设置文本特殊效果,目前只有图版印刷效果可用. NSString, default nil: no text effect
/// - attachment: 设置文本附件,常用插入图片. NSTextAttachment, default nil
/// - link: 链接，二选一即可. NSURL (preferred) or NSString
/// - baselineOffset: 基准线偏移. NSNumber containing floating point value, in points; offset from baseline, default 0
/// - obliqueness: 字体倾斜. NSNumber containing floating point value; skew to be applied to glyphs, default 0: no skew
/// - expansion: 字体加粗. NSNumber containing floating point value; log of expansion factor to be applied to glyphs, default 0: no expansion
/// - writingDirection: 文字方向. NSArray of NSNumbers representing the nested levels of writing direction overrides as defined by Unicode LRE, RLE, LRO, and RLO characters.
///                     The control characters can be obtained by masking NSWritingDirection and NSWritingDirectionFormatType values.
///                     LRE: NSWritingDirectionLeftToRight|NSWritingDirectionEmbedding,
///                     RLE: NSWritingDirectionRightToLeft|NSWritingDirectionEmbedding,
///                     LRO: NSWritingDirectionLeftToRight|NSWritingDirectionOverride,
///                     RLO: NSWritingDirectionRightToLeft|NSWritingDirectionOverride,

/// - verticalGlyphForm: 水平或者竖直文本 在iOS没卵用，不支持竖版. An NSNumber containing an integer value.  0 means horizontal text.  1 indicates vertical text.  If not specified, it could follow higher-level vertical orientation settings.  Currently on iOS, it's always horizontal.  The behavior for any other value is undefined.
public enum FZAttribute {
    case font(UIFont)
    case paragraphStyle(NSParagraphStyle)
    case foregroundColor(UIColor)
    case backgroundColor(UIColor)
    case ligature(Int)
    case kern(Int)
    case strikethrough(UInt, UIColor?)
    case underline(NSUnderlineStyle, UIColor?)
    case stroke(CGFloat, UIColor?)
    case shadow(NSShadow)
    case textEffect(String)
    case attachment(NSTextAttachment)
    case link(NSURL?, String?)
    case baselineOffset(CGFloat)
    case obliqueness(CGFloat)
    case expansion(CGFloat)
    case writingDirection(Array<Int>)
    case verticalGlyphForm(Int)

    var value: [NSAttributedString.Key: Any] {
        return fill()
    }

    func fill(in result: [NSAttributedString.Key: Any] = [:]) -> [NSAttributedString.Key: Any] {
        var result = result
        switch self {
        case .font(let font):
            result[.font] = font

        case .paragraphStyle(let paragraphStyle):
            result[.paragraphStyle] = paragraphStyle

        case .foregroundColor(let color):
            result[.foregroundColor] = color

        case .backgroundColor(let color):
            result[.backgroundColor] = color

        case .ligature(let ligature):
            result[.ligature] = ligature

        case .kern(let kern):
            result[.kern] = kern

        case .strikethrough(let strikethroughStyle, let strikethroughColor):
            result[.strikethroughStyle] = strikethroughStyle
            if let color = strikethroughColor {
                result[.strikethroughColor] = color
            }

        case .underline(let underlineStyle, let underlineColor):
            result[.underlineStyle] = underlineStyle
            if let color = underlineColor {
                result[.underlineColor] = color
            }

        case .stroke(let strokeWidth, let strokeColor):
            result[.strokeWidth] = strokeWidth
            if let color = strokeColor {
                result[.strokeColor] = color
            }

        case .shadow(let shadow):
            result[.shadow] = shadow

        case .textEffect(let textEffect):
            result[.textEffect] = textEffect

        case .attachment(let attachment):
            result[.attachment] = attachment

        case .link(let url, let urlString):
            // NSURL (preferred) or NSString
            if let urlString = urlString {
                result[.link] = urlString
            }
            if let url = url {
                result[.link] = url
            }

        case .baselineOffset(let baselineOffset):
            result[.baselineOffset] = baselineOffset

        case .obliqueness(let obliqueness):
            result[.obliqueness] = obliqueness

        case .expansion(let expansion):
            result[.expansion] = expansion

        case .writingDirection(let writingDirection):
            result[.writingDirection] = writingDirection

        case .verticalGlyphForm(let verticalGlyphForm):
            result[.verticalGlyphForm] = verticalGlyphForm

        }
        return result
    }
}
