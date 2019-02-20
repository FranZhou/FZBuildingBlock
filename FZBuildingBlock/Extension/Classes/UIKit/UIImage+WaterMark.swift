//
//  UIImage+WaterMark.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/3.
//

import Foundation
import CoreGraphics


// MARK: - 铺满全图的水印
extension UIImage{
    
    /// 在图片上打满文字水印
    ///
    /// - Parameters:
    ///   - mark: 水印文字
    ///   - markAttributes: default nil,水印文字相关属性
    ///   - horizontalSpace: default 30,水印文字的水平间距
    ///   - horizontalAutoOffset: default NO, 水平方向是否自动偏移
    ///   - verticalSpace: default 30,水印文字的垂直间距
    ///   - verticalAutoOffset: default NO,垂直方向是否自动偏移
    ///   - rotation: default 0,水印文字旋转角度(单位: 度)
    /// - Returns:
    public func fz_fullWaterMark(with mark: String, markAttributes:  [NSAttributedString.Key : Any]? = nil, horizontalSpace: CGFloat = 30, horizontalAutoOffset: Bool = false, verticalSpace: CGFloat = 30, verticalAutoOffset: Bool = false, rotation: Double = 0) -> UIImage?{
        
        return self.fz_fullWaterMark(with: NSAttributedString(string: mark, attributes: markAttributes), horizontalSpace: horizontalSpace, horizontalAutoOffset: horizontalAutoOffset, verticalSpace: verticalSpace, verticalAutoOffset: verticalAutoOffset, rotation: rotation)
    }
    
    
    /// 在图片上打满文字水印
    ///
    /// - Parameters:
    ///   - attributedMark: 水印文字
    ///   - horizontalSpace: default 30,水印文字的水平间距
    ///   - horizontalAutoOffset: default NO, 水平方向是否自动偏移
    ///   - verticalSpace: default 30,水印文字的垂直间距
    ///   - verticalAutoOffset: default NO,垂直方向是否自动偏移
    ///   - rotation: default 0,水印文字旋转角度(单位: 度)
    /// - Returns:
    public func fz_fullWaterMark(with attributedMark: NSAttributedString, horizontalSpace: CGFloat = 30, horizontalAutoOffset: Bool = false, verticalSpace: CGFloat = 30, verticalAutoOffset: Bool = false, rotation: Double = 0) -> UIImage?{
        // 没有水印文字
        if attributedMark.string.count == 0{
            return self
        }
        
        // 需要打水印图片的size为{0,0}
        if self.size.equalTo(.zero){
            return self
        }
        
        let oriWidth = self.size.width
        let oriHeight = self.size.height
        
        // 为了防止图片失真，绘制区域宽高和原始图片宽高一样
        UIGraphicsBeginImageContextWithOptions(CGSize(width: oriWidth, height: oriHeight), false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: oriWidth, height: oriHeight))
        
        // 获取文字高度宽度
        let markWidth = attributedMark.size().width
        let markHeight = attributedMark.size().height
        
        // 开始旋转上下文矩阵，绘制水印文字
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.saveGState()
        defer {
            context.restoreGState()
        }
        
        // 将绘制原点（0，0）调整到源image的中心
        context.translateBy(x: oriWidth/2.0, y: oriHeight/2.0)
        
        if rotation.truncatingRemainder(dividingBy: 360) != 0.0 {
            // 以绘制原点为中心旋转
            context.rotate(by: CGFloat(rotation/180*Double.pi))
        }
        
        // 将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
        context.translateBy(x: -oriWidth/2.0, y: -oriHeight/2.0)
        
        // 计算需要绘制的列数和行数
        // 最终是在一个最大的正方形上绘制水印图片，改正方形中心点和r图片中心点重合，并且将图片完全覆盖住
        let sqrtLength = sqrt(oriWidth*oriWidth + oriHeight*oriHeight)
        let horizontalCount = Int(sqrtLength/(markWidth+horizontalSpace) + 1)
        let verticalCount = Int(sqrtLength/(markHeight+verticalSpace) + 1)
        
        // 计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
        let originX = -(sqrtLength-oriWidth)/2.0
        let originY = -(sqrtLength-oriHeight)/2.0
        
        // 开始绘制水印
        // 垂直
        for i in 0..<verticalCount {
            let currentOffsetY = originY + (markHeight + verticalSpace) * CGFloat(i)
            var tempX = originX
            var tempY = currentOffsetY
            
            // 水平绘制
            for j in 0..<horizontalCount{
                // 最大偏移量为水平或垂直间距的一半 避免覆盖
                tempX = originX + (markWidth + horizontalSpace) * CGFloat(j) + getOffset(maxOffset: horizontalSpace/2, allowOffset: horizontalAutoOffset)
                tempY = currentOffsetY + getOffset(maxOffset: verticalSpace/2, allowOffset: verticalAutoOffset)
                
                attributedMark.draw(in: CGRect(x: tempX, y: tempY, width: markWidth, height: markHeight))
            }
        }
        
        // 根据上下文制作成图片
        let waterMarkImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return waterMarkImage
    }
    
    
    /// 在图片上打满图片水印
    ///
    /// - Parameters:
    ///   - markImage: 水印图片
    ///   - horizontalSpace: default 30,水印图片的水平间距
    ///   - horizontalAutoOffset: default NO, 水平方向是否自动偏移
    ///   - verticalSpace: default 30,水印图片的垂直间距
    ///   - verticalAutoOffset: default NO,垂直方向是否自动偏移
    ///   - rotation: default 0,水印文字旋转角度(单位: 度)
    /// - Returns:
    public func fz_fullWaterMark(with markImage: UIImage, horizontalSpace: CGFloat = 30, horizontalAutoOffset: Bool = false, verticalSpace: CGFloat = 30, verticalAutoOffset: Bool = false, rotation: Double = 0) -> UIImage? {
        // 水印图片size为{0,0}
        if markImage.size.equalTo(.zero){
            return self
        }
        
        // 需要打水印图片的size为{0,0}
        if self.size.equalTo(.zero){
            return self
        }
        
        let oriWidth = self.size.width
        let oriHeight = self.size.height
        
        // 为了防止图片失真，绘制区域宽高和原始图片宽高一样
        UIGraphicsBeginImageContextWithOptions(CGSize(width: oriWidth, height: oriHeight), false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: oriWidth, height: oriHeight))
        
        // 获取水印图片高度宽度
        let markWidth = markImage.size.width
        let markHeight = markImage.size.height
        
        // 开始旋转上下文矩阵，绘制水印文字
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.saveGState()
        defer {
            context.restoreGState()
        }
        
        // 将绘制原点（0，0）调整到源image的中心
        context.translateBy(x: oriWidth/2.0, y: oriHeight/2.0)
        
        if rotation.truncatingRemainder(dividingBy: 360) != 0.0 {
            // 以绘制原点为中心旋转
            context.rotate(by: CGFloat(rotation/180*Double.pi))
        }
        
        // 将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
        context.translateBy(x: -oriWidth/2.0, y: -oriHeight/2.0)
        
        // 计算需要绘制的列数和行数
        // 最终是在一个最大的正方形上绘制水印文字，改正方形中心点和r图片中心点重合，并且将图片完全覆盖住
        let sqrtLength = sqrt(oriWidth*oriWidth + oriHeight*oriHeight)
        let horizontalCount = Int(sqrtLength/(markWidth+horizontalSpace) + 1)
        let verticalCount = Int(sqrtLength/(markHeight+verticalSpace) + 1)
        
        // 计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
        let originX = -(sqrtLength-oriWidth)/2.0
        let originY = -(sqrtLength-oriHeight)/2.0
        
        // 开始绘制水印
        // 垂直
        for i in 0..<verticalCount {
            let currentOffsetY = originY + (markHeight + verticalSpace) * CGFloat(i)
            var tempX = originX
            var tempY = currentOffsetY
            
            // 水平绘制
            for j in 0..<horizontalCount{
                // 最大偏移量为水平或垂直间距的一半 避免覆盖
                tempX = originX + (markWidth + horizontalSpace) * CGFloat(j) + getOffset(maxOffset: horizontalSpace/2, allowOffset: horizontalAutoOffset)
                tempY = currentOffsetY + getOffset(maxOffset: verticalSpace/2, allowOffset: verticalAutoOffset)
                
                markImage.draw(in: CGRect(x: tempX, y: tempY, width: markWidth, height: markHeight))
            }
        }
        
        // 根据上下文制作成图片
        let waterMarkImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return waterMarkImage
    }
    
    
    /// 自动生成随机偏移量
    ///
    /// - Parameters:
    ///   - maxOffset: 最大偏移量
    ///   - allowOffset: 是否需要偏移
    /// - Returns:
    fileprivate func getOffset(maxOffset: CGFloat, allowOffset: Bool) -> CGFloat{
        if allowOffset && maxOffset > 0{
            return -maxOffset + CGFloat(arc4random()).truncatingRemainder(dividingBy: (2*maxOffset))
        } else {
            return 0
        }
    }
    
    
}



// MARK: - 单个水印
extension UIImage{
    
    /// 在图片上加上单个文字水印
    ///
    /// - Parameters:
    ///   - mark: 水印文字
    ///   - markAttributes: default nil,水印文字相关属性
    ///   - drawPoint: 水印绘制位置
    ///   - rotation: default 0,水印文字旋转角度(单位: 度)
    /// - Returns:
    public func fz_waterMark(with mark: String, markAttributes:  [NSAttributedString.Key : Any]? = nil, drawPoint: CGPoint, rotation: Double = 0) -> UIImage?{
        return self.fz_waterMark(with: NSAttributedString(string: mark, attributes: markAttributes), drawPoint: drawPoint, rotation: rotation)
    }
    
    /// 在图片上加上单个文字水印
    ///
    /// - Parameters:
    ///   - mark: 水印文字
    ///   - markAttributes: default nil,水印文字相关属性
    ///   - drawRect: 水印绘制区域
    ///   - rotation: default 0,水印文字旋转角度(单位: 度)
    /// - Returns:
    public func fz_waterMark(with mark: String, markAttributes:  [NSAttributedString.Key : Any]? = nil, drawRect: CGRect, rotation: Double = 0) -> UIImage?{
        return self.fz_waterMark(with: NSAttributedString(string: mark, attributes: markAttributes), drawRect: drawRect, rotation: rotation)
    }
    
    /// 在图片上加上单个文字水印
    ///
    /// - Parameters:
    ///   - attributedMark: 水印文字
    ///   - drawPoint: 水印绘制位置
    ///   - rotation: default 0,水印文字旋转角度(单位: 度)
    /// - Returns:
    public func fz_waterMark(with attributedMark: NSAttributedString, drawPoint: CGPoint, rotation: Double = 0) -> UIImage?{
        // 需要打水印图片的size为{0,0}
        if self.size.equalTo(.zero){
            return self
        }
        
        // 没有水印文字
        if attributedMark.string.count == 0{
            return self
        }
        
        // 水印文字转换成图片
        guard let markImage = UIImage.fz_image(with: attributedMark)?.fz_rotate(with: rotation) else {
            return self
        }
        
        return self.fz_waterMark(with: markImage, drawRect: CGRect(origin: drawPoint, size: markImage.size))
    }
    
    
    /// 在图片上加上单个文字水印
    ///
    /// - Parameters:
    ///   - attributedMark: 水印文字
    ///   - drawRect: 水印绘制区域
    ///   - rotation: default 0,水印文字旋转角度(单位: 度)
    /// - Returns:
    public func fz_waterMark(with attributedMark: NSAttributedString, drawRect: CGRect, rotation: Double = 0) -> UIImage?{
        // 需要打水印图片的size为{0,0}
        if self.size.equalTo(.zero){
            return self
        }
        
        // 没有水印文字
        if attributedMark.string.count == 0{
            return self
        }
        
        // 水印文字转换成图片
        guard let markImage = UIImage.fz_image(with: attributedMark)?.fz_rotate(with: rotation) else {
            return self
        }
        
        return self.fz_waterMark(with: markImage, drawRect: drawRect)
    }
    
    
    /// 在图片上加单个水印图片
    ///
    /// - Parameters:
    ///   - markImage: 水印图片
    ///   - drawPoint: 绘制位置
    /// - Returns:
    public func fz_waterMark(with markImage: UIImage, drawPoint: CGPoint) -> UIImage?{
        if self.size.equalTo(.zero){
            return self
        }
        
        if markImage.size.equalTo(.zero){
            return self
        }
        
        return self.fz_waterMark(with: markImage, drawRect: CGRect(origin: drawPoint, size: markImage.size))
    }
    
    
    /// 在图片上加单个水印图片
    ///
    /// - Parameters:
    ///   - markImage: 水印图片
    ///   - drawRect: 绘制区域
    /// - Returns:
    public func fz_waterMark(with markImage: UIImage, drawRect: CGRect) -> UIImage?{
        if self.size.equalTo(.zero){
            return self
        }
        
        if markImage.size.equalTo(.zero){
            return self
        }
        
        if drawRect.size.equalTo(.zero){
            return self
        }
        
        let oriWidth = self.size.width
        let oriHeight = self.size.height
        
        // 为了防止图片失真，绘制区域宽高和原始图片宽高一样
        UIGraphicsBeginImageContextWithOptions(CGSize(width: oriWidth, height: oriHeight), false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: oriWidth, height: oriHeight))
        
        markImage.draw(in: drawRect)
        
        let waterMarkImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return waterMarkImage
    }
}


