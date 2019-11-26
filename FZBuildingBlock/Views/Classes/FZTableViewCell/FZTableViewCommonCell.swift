//
//  FZTableViewCommonCell.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/1.
//

import UIKit

@objc open class FZTableViewCommonCell: FZTableViewCell {

    // MARK: -

    // MARK: cell data model
    @objc public var cellModel: FZTableViewCellModel?

    // MARK: separate line
    /// top line
    @objc open lazy var topLineView: UIView = {
        let v = UIView()
        return v
    }()

    /// bottom line
    @objc open lazy var bottomLineView: UIView = {
        let v = UIView()
        return v
    }()

    // MARK: icon
    /// left icon image view
    @objc open lazy var leftIconImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        return v
    }()

    /// right icon image view
    @objc open lazy var rightIconImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        return v
    }()

    // MARK: left
    @objc open lazy var leftLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .left
        return v
    }()

    @objc private var leftView: UIView?

    // MARK: center
    @objc open lazy var centerLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        return v
    }()

    @objc private var centerView: UIView?

    // MARK: right
    @objc open lazy var rightLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .right
        return v
    }()

    @objc private var rightView: UIView?

    // MARK: -
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: -
extension FZTableViewCommonCell {

    open override func layoutSubviews() {
        super.layoutSubviews()

        guard let cellModel = cellModel else {
            return
        }

        // cell 高度宽度
        let width = self.fz.width
        let height = self.fz.height

        // top line
        var topLineHeight: CGFloat = 0
        do {
            if cellModel.showTopLine {
                topLineView.fz.x = cellModel.topLineLeftDistance
                topLineView.fz.y = 0
                topLineView.fz.height = cellModel.topLineHeight
                topLineView.fz.width = width - cellModel.topLineLeftDistance - cellModel.topLineLeftDistance
                topLineHeight = cellModel.topLineHeight
            }
        }

        // bottom line
        var bottomLineHeight: CGFloat = 0
        do {
            if cellModel.showBottomLine {
                topLineView.fz.x = cellModel.bottomLineLeftDistance
                topLineView.fz.y = height - cellModel.topLineHeight
                topLineView.fz.height = cellModel.topLineHeight
                topLineView.fz.width = width - cellModel.bottomLineLeftDistance - cellModel.bottomLineLeftDistance
                bottomLineHeight = cellModel.bottomLineHeight
            }
        }

        let centerY = (height - topLineHeight - bottomLineHeight) / 2.0 + topLineHeight

        // left icon
        var leftDistance = cellModel.leftDistance
        do {
            if !leftIconImageView.isHidden {
                leftDistance += leftIconImageView.fz.width + cellModel.leftIconDistance

                leftIconImageView.fz.x = cellModel.leftDistance
                leftIconImageView.fz.outerCenterY = centerY
            }
        }

        // right icon
        var rightDistance = cellModel.rightDistance
        do {
            if !rightIconImageView.isHidden {
                rightDistance += rightIconImageView.fz.width + cellModel.rightIconDistance

                rightIconImageView.fz.x = width - rightIconImageView.fz.width - cellModel.rightIconDistance
                rightIconImageView.fz.outerCenterY = centerY
            }
        }

        // 可展示的最大宽度（cell宽度减去左右间距）
        let maxWidth = width - leftDistance - rightDistance

        // 左 中 右 展示优先级   中 > 左 > 右
        // 如果都是自定义view， 请自己控制frame达到UI要求
        // 请注意cell高度是外部设置的

        // center
        var centerWidth: CGFloat = 0
        let centerMinDistance = cellModel.centerMinDistance
        do {
            if let view = centerView {
                view.fz.outerCenterX = contentView.fz.innerCenterX
                view.fz.outerCenterY = centerY

                centerWidth = view.fz.width
            } else {
                centerLabel.fz.width = maxWidth
                centerLabel.fz.height = CGFloat.greatestFiniteMagnitude

                centerLabel.sizeToFit()
                centerLabel.fz.outerCenterX = contentView.fz.innerCenterX
                centerLabel.fz.outerCenterY = centerY

                centerWidth = centerLabel.fz.width
            }
        }

        // left
        do {
            if let view = leftView {
                view.fz.x = leftDistance
                view.fz.outerCenterY = centerY
            } else {
                var leftMaxWidth = maxWidth
                if centerWidth > 0 {
                    leftMaxWidth = width / 2.0 - leftDistance - centerWidth / 2.0 - centerMinDistance
                }
                leftLabel.fz.width = leftMaxWidth
                leftLabel.fz.height = CGFloat.greatestFiniteMagnitude

                leftLabel.sizeToFit()
                leftLabel.fz.x = leftDistance
                leftLabel.fz.outerCenterY = centerY
            }
        }

        // right
        do {
            if let view = centerView {
                view.fz.x = width - rightDistance - view.fz.width
                view.fz.outerCenterY = centerY
            } else {
                if centerWidth > 0 {
                    // 中间有视图，有点显示宽度有限制
                    let rightMaxWidth = width / 2.0 - rightDistance - centerWidth / 2.0 - centerMinDistance
                    rightLabel.fz.width = rightMaxWidth
                    rightLabel.fz.height = CGFloat.greatestFiniteMagnitude

                    rightLabel.sizeToFit()
                    rightLabel.fz.x = width - rightDistance - rightLabel.fz.width
                    rightLabel.fz.outerCenterY = centerY
                } else {
                    // 中间没有视图时
                    rightLabel.fz.width = maxWidth
                    rightLabel.fz.height = CGFloat.greatestFiniteMagnitude
                    rightLabel.sizeToFit()

                    let rightMaxWidth = rightLabel.fz.width
                    if let view = leftView {
                        // 左边显示的是自定义视图, 中间没有视图
                        let leftWidth = view.fz.width
                        if leftWidth + rightMaxWidth + centerMinDistance < maxWidth {
                            // 左右能显示完全
                            rightLabel.fz.x = width - rightDistance - rightLabel.fz.width
                            rightLabel.fz.outerCenterY = centerY
                        } else {
                            // 左边自定义视图显示完全，右边label换行显示
                            rightLabel.fz.width = maxWidth - leftWidth - centerMinDistance
                            rightLabel.fz.height = CGFloat.greatestFiniteMagnitude

                            rightLabel.sizeToFit()
                            rightLabel.fz.x = width - rightDistance - rightLabel.fz.width
                            rightLabel.fz.outerCenterY = centerY
                        }
                    } else {
                        // 左边是label，右边也是label
                        let leftWidth = leftLabel.fz.width
                        if leftWidth + rightMaxWidth + centerMinDistance <= maxWidth {
                            // 左右label都能显示完全
                            rightLabel.fz.x = width - rightDistance - rightLabel.fz.width
                            rightLabel.fz.outerCenterY = centerY
                        } else {
                            // 左右label不能同时显示完全
                            if leftWidth <= (maxWidth - centerMinDistance) / 2.0 {
                                // 左边内容少于一半，保证左边完全显示，右边换行
                                rightLabel.fz.width = maxWidth - leftWidth - centerMinDistance
                                rightLabel.fz.height = CGFloat.greatestFiniteMagnitude

                                rightLabel.sizeToFit()
                                rightLabel.fz.x = width - rightDistance - rightLabel.fz.width
                                rightLabel.fz.outerCenterY = centerY
                            } else if rightMaxWidth <= (maxWidth - centerMinDistance) / 2.0 {
                                // 右边内容少于一半，保证右边完全显示，左边换行
                                rightLabel.fz.x = width - rightDistance - rightLabel.fz.width
                                rightLabel.fz.outerCenterY = centerY

                                leftLabel.fz.width = maxWidth - rightMaxWidth - centerMinDistance
                                leftLabel.fz.height = CGFloat.greatestFiniteMagnitude

                                leftLabel.sizeToFit()
                                leftLabel.fz.x = leftDistance
                                leftLabel.fz.outerCenterY = centerY
                            } else {
                                // 左右都长,左右都换行显示，宽度比6:4
                                let _leftWidth = (maxWidth - centerMinDistance) * 0.6

                                // left label
                                leftLabel.fz.width = _leftWidth
                                leftLabel.fz.height = CGFloat.greatestFiniteMagnitude

                                leftLabel.sizeToFit()
                                leftLabel.fz.x = leftDistance
                                leftLabel.fz.outerCenterY = centerY

                                // right label
                                rightLabel.fz.width = maxWidth - _leftWidth - centerMinDistance
                                rightLabel.fz.height = CGFloat.greatestFiniteMagnitude

                                rightLabel.sizeToFit()
                                rightLabel.fz.x = width - rightDistance - rightLabel.fz.width
                                rightLabel.fz.outerCenterY = centerY

                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: private functions
extension FZTableViewCommonCell {

    private func setupCellUI() {
        contentView.addSubview(topLineView)
        contentView.addSubview(bottomLineView)

        contentView.addSubview(leftIconImageView)
        contentView.addSubview(leftLabel)

        contentView.addSubview(centerLabel)

        contentView.addSubview(rightLabel)
        contentView.addSubview(rightIconImageView)
    }
}

// MARK: - override 
extension FZTableViewCommonCell {

    open override func updateCell(withData data: Any? = nil, atIndexPath indexPath: IndexPath? = nil) {
        if let model = data as? FZTableViewCellModel {
            cellModel = model

            // background color
            contentView.backgroundColor = model.backgroundColor

            // top line
            do {
                topLineView.isHidden = !model.showTopLine
                if !topLineView.isHidden {
                    topLineView.backgroundColor = model.topLineBackgroundColor
                }
            }

            // bottom line
            do {
                bottomLineView.isHidden = !model.showBottomLine
                if !bottomLineView.isHidden {
                    bottomLineView.backgroundColor = model.bottomLineBackgroundColor
                }
            }

            // left icon
            do {
                leftIconImageView.image = nil

                if let iconImage = model.leftIconImage,
                    model.showLeftIcon {
                    leftIconImageView.isHidden = false
                    leftIconImageView.image = iconImage
                    let iconSize = model.leftIconImageSize.equalTo(.zero) ? iconImage.size : model.leftIconImageSize
                    leftIconImageView.frame.size = iconSize
                } else {
                    leftIconImageView.isHidden = true
                }
            }

            // left label or view
            do {
                leftView?.removeFromSuperview()
                leftView = nil

                leftLabel.text = nil
                leftLabel.attributedText = nil

                if let view = model.leftView {
                    leftLabel.isHidden = true
                    leftView = view
                    contentView.addSubview(view)
                } else {
                    leftLabel.isHidden = false
                    if let attributedString = model.leftAttributedString {
                        leftLabel.attributedText = attributedString
                    } else {
                        leftLabel.text = model.leftString
                    }
                }
            }

            // center label or view
            do {
                centerView?.removeFromSuperview()
                centerView = nil

                centerLabel.text = nil
                centerLabel.attributedText = nil

                if let view = model.centerView {
                    centerLabel.isHidden = true
                    centerView = view
                    contentView.addSubview(view)
                } else {
                    centerLabel.isHidden = false
                    if let attributedString = model.centerAttributedString {
                        centerLabel.attributedText = attributedString
                    } else {
                        centerLabel.text = model.centerString
                    }
                }
            }

            // right label or view
            do {
                rightView?.removeFromSuperview()
                rightView = nil

                rightLabel.text = nil
                rightLabel.attributedText = nil

                if let view = model.rightView {
                    rightLabel.isHidden = true
                    rightView = view
                    contentView.addSubview(view)
                } else {
                    rightLabel.isHidden = false
                    if let attributedString = model.rightAttributedString {
                        rightLabel.attributedText = attributedString
                    } else {
                        rightLabel.text = model.rightString
                    }
                }
            }

            // right icon
            do {
                rightIconImageView.image = nil

                if let iconImage = model.rightIconImage,
                    model.showRightIcon {
                    rightIconImageView.isHidden = false
                    rightIconImageView.image = iconImage
                    let iconSize = model.rightIconImageSize.equalTo(.zero) ? iconImage.size : model.rightIconImageSize
                    rightIconImageView.frame.size = iconSize
                } else {
                    rightIconImageView.isHidden = true
                }
            }
        }
    }

}
