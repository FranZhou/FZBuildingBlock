//
//  FZCaptchaView.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/25.
//

import UIKit

/// 验证码视图
open class FZCaptchaView: UIView {

    private enum CaptchaColorType {
        case background
        case font
        case interferenceLine
    }

    // MARK: - color

    /// 颜色随机池
    public var colorRandomPool: [UIColor] = []

    /// 背景颜色随机池，优先级 backgroundColorRandomPool > colorRandomPool > default
    public var backgroundColorRandomPool: [UIColor] = []

    // MARK: - font

    /// 字体名随机池，设置后会在这里随机获取字体名，配合minFontSize和maxFontSize
    public var fontNameRandomPool: [String] = []

    /// 字体随机池，优先级为 fontRandomPool > fontNameRandomPool > default
    public var fontRandomPool: [UIFont] = []

    /// 字体颜色随机池， 优先级 fontColorRandomPool > colorRandomPool > default
    public var fontColorRandomPool: [UIColor] = []

    /// 字体最小size， default = 12
    public var minFontSize: CGFloat = 12

    /// 字体最大size，default = 20
    public var maxFontSize: CGFloat = 20

    // MARK: - 干扰线相关

    /// 验证码干扰线条数，default = 6
    public var captchaLineCount: Int = 6

    /// 分割线最小宽度，default = 0.5
    public var minInterferenceLineWidth: CGFloat = 0.5

    /// 分割线最大宽度，default = 2
    public var maxInterferenceLineWidth: CGFloat = 2

    /// 分割线颜色随机池， 优先级 interferenceLineColorRandomPool > colorRandomPool > default
    public var interferenceLineColorRandomPool: [UIColor] = []

    // MARK: - 旋转角度

    /// 验证码旋转最小角度，default = -90
    public var minRotation: CGFloat = -90

    /// 验证码旋转最大角度，default = 90
    public var maxRotation: CGFloat = 90

    // MARK: - 验证码

    /// 验证码字符串个数
    fileprivate var captchaStringCount: Int {
        get {
            if let str = self.captchaString {
                return str.count
            }
            return 0
        }
    }

    /// 验证码字符串
    public var captchaString: String? {
        didSet {
            refreshCaptcha()
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = randomColor(type: .background)
    }
}

// MARK: - Public
extension FZCaptchaView {

    /// 刷新展示验证码
    public func refreshCaptcha() {
        setNeedsDisplay()
    }

}

// MARK: - Private
extension FZCaptchaView {

    /// 在多个数组里取随机数
    /// - Parameter pools: pools description
    /// - Returns: description
    private func randomElementInPools<T>(pools: Array<Array<T>>) -> T? {
        for pool in pools {
            if let element = randomElement(in: pool) {
                return element
            }
        }
        return nil
    }

    /// 生产随机数
    /// - Parameters:
    ///   - from: from description
    ///   - to: to description
    /// - Returns: description
    private func random(from: CGFloat, to: CGFloat) -> CGFloat {
        let min: CGFloat = CGFloat.minimum(from, to)
        let max: CGFloat = CGFloat.maximum(from, to)
        return CGFloat(arc4random()).truncatingRemainder(dividingBy: max - min) + min
    }

    /// 取数组内的随机位置
    /// - Parameter array: array description
    /// - Returns: description
    private func randomElement<T>(in array: Array<T>) -> T? {
        if array.count > 0 {
            let count = array.count
            let index = Int(arc4random()) % count
            return array[fz_safe: index]
        }
        return nil
    }

}

// MARK: - 随机字体
extension FZCaptchaView {

    /// 随机字体，fontRandomPool > fontNameRandomPool > default
    /// - Returns: description
    private func randomFont() -> UIFont {
        let fontSize = random(from: minFontSize, to: maxFontSize)
        if fontRandomPool.count > 0,
            let font = randomElement(in: fontRandomPool) {
            return font
        } else if fontNameRandomPool.count > 0,
            let fontName = randomElement(in: fontNameRandomPool),
            let font = UIFont(name: fontName, size: fontSize) {
            return font
        }
        return UIFont.systemFont(ofSize: fontSize)
    }

}

// MARK: - 随机分割线宽度
extension FZCaptchaView {
    /// 随机分割线宽度
    /// - Returns: description
    private func randomInterferenceLineWidth() -> CGFloat {
        let min: CGFloat = CGFloat.minimum(minInterferenceLineWidth, maxInterferenceLineWidth)
        let max: CGFloat = CGFloat.maximum(minInterferenceLineWidth, maxInterferenceLineWidth)

        let count = captchaStringCount > 0 ? captchaStringCount : 1
        let step = count > 1 ? (max - min) / CGFloat(count - 1) : max - min

        return min + step * CGFloat(arc4random()).truncatingRemainder(dividingBy: CGFloat(count + 1))
    }
}

// MARK: - 随机倾斜角度
extension FZCaptchaView {
    /// 随机倾斜角度
    /// - Returns: description
    private func randomRotation() -> CGFloat {
        return random(from: minRotation, to: maxRotation)
    }
}

// MARK: - 随机颜色
extension FZCaptchaView {

    /// 随机颜色
    /// - Parameters:
    ///   - type: type description
    ///   - alpha: alpha description
    /// - Returns: description
    private func randomColor(type: CaptchaColorType, alpha: CGFloat = 1.0) -> UIColor {
        switch type {
        case .background:
            return randomBackgroundColor(alpha: alpha)
        case .font:
            return randomFontColor(alpha: alpha)
        case .interferenceLine:
            return randomInterferenceLineColor(alpha: alpha)
        }
    }

    /// 随机背景色，优先级 backgroundColorRandomPool > colorRandomPool
    /// - Parameter alpha: alpha description
    /// - Returns: description
    private func randomBackgroundColor(alpha: CGFloat = 1.0) -> UIColor {
        if let color = randomElementInPools(pools: [backgroundColorRandomPool, colorRandomPool]) {
            return color
        }
        return UIColor.fz.randomColor(alpha: alpha)
    }

    /// 随机字体颜色，优先级 fontColorRandomPool > colorRandomPool
    /// - Parameter alpha: alpha description
    /// - Returns: description
    private func randomFontColor(alpha: CGFloat = 1.0) -> UIColor {
        if let color = randomElementInPools(pools: [fontColorRandomPool, colorRandomPool]) {
            return color
        }
        return UIColor.fz.randomColor(alpha: alpha)
    }

    /// 随机分割线颜色，优先级 interferenceLineColorRandomPool > colorRandomPool
    /// - Parameter alpha: alpha description
    /// - Returns: description
    private func randomInterferenceLineColor(alpha: CGFloat = 1.0) -> UIColor {
        if let color = randomElementInPools(pools: [interferenceLineColorRandomPool, colorRandomPool]) {
            return color
        }
        return UIColor.fz.randomColor(alpha: alpha)
    }
}

// MARK: - 绘制验证码
extension FZCaptchaView {

    open override func draw(_ rect: CGRect) {

        // 背景颜色
        backgroundColor = randomColor(type: .background)

        let totalW = rect.size.width
        let totalH = rect.size.height

        let w = totalW / CGFloat(captchaStringCount > 0 ? captchaStringCount : 1)
        let h = totalH

        // 验证码
        UIColor.fz.randomColor().set()
        if let captchaString = captchaString {
            for (index, char) in captchaString.enumerated() {
                let str = String(char)
                // 字体
                let font = randomFont()
                // 字体颜色
                let fontColor = randomColor(type: .font)
                // 旋转角度
                let rotationradian = randomRotation()

                if rotationradian != 0,
                    let orginImage = UIImage.fz_image(withString: str, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: fontColor]),
                    let image = orginImage.fz.rotate(withRotation: rotationradian) {
                    // 有角度倾斜时
                    let size = image.size

                    // 随机位置
                    let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w - size.width) + w * CGFloat(index)
                    let y = CGFloat(arc4random()).truncatingRemainder(dividingBy: h - size.height)

                    image.draw(at: CGPoint(x: x, y: y))
                } else {
                    // 没有角度倾斜时
                    let size = str.boundingRect(with: CGSize(width: w, height: h), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size

                    // 随机位置
                    let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w - size.width) + w * CGFloat(index)
                    let y = CGFloat(arc4random()).truncatingRemainder(dividingBy: h - size.height)

                    (str as NSString).draw(at: CGPoint(x: x, y: y), withAttributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: fontColor])

                }
            }
        }

        // 干扰线
        let context = UIGraphicsGetCurrentContext()
        for _ in 0 ..< captchaLineCount {
            context?.setLineWidth(randomInterferenceLineWidth())
            context?.setStrokeColor(randomColor(type: .interferenceLine, alpha: 0.5).cgColor)

            // 起始点坐标
            let sx = CGFloat(arc4random()).truncatingRemainder(dividingBy: totalW)
            let sy = CGFloat(arc4random()).truncatingRemainder(dividingBy: totalW)

            // 终点坐标
            let ex = CGFloat(arc4random()).truncatingRemainder(dividingBy: totalW)
            let ey = CGFloat(arc4random()).truncatingRemainder(dividingBy: totalW)

            context?.move(to: CGPoint(x: sx, y: sy))
            context?.addLine(to: CGPoint(x: ex, y: ey))
            context?.strokePath()
        }

    }
}
