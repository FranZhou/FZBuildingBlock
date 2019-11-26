//
//  FZTextView.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/9.
//

import Foundation

/// Support for setting up multiple delegates
open class FZTextView: UITextView {

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupDefaultConfig()
    }

    public init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        setupDefaultConfig()
    }

    public init() {
        super.init(frame: CGRect.zero, textContainer: nil)
        setupDefaultConfig()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    weak override open var delegate: UITextViewDelegate? {
        set {
            _delegate = newValue
        }
        get {
            return _delegate
        }
    }

    /// stored property of delegate
    fileprivate weak var _delegate: UITextViewDelegate?

    /// other delegate handlers
    fileprivate var delegateHandlers: [UITextViewDelegate] = []

    /// limit max input length, Less than or equal to 0 means no limit, default is 0
    @objc open var maxInputLength: Int = 0

    /// placeholder Label
    @objc open fileprivate(set) var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.isUserInteractionEnabled = false
        return label
    }()

    deinit {
        delegateHandlers.removeAll()
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - defaultConfig
extension FZTextView {

    fileprivate func setupDefaultConfig() {
        // The delegate is set to self by default
        super.delegate = self

        // add notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChangeNotification(_:)), name: UITextView.textDidChangeNotification, object: self)
    }

    /// handler UITextField.textDidChangeNotification
    ///
    /// - Parameter notification: notification
    @objc fileprivate func handleTextDidChangeNotification(_ notification: Notification) {

        // maxLimitLength
        if maxInputLength > 0 {
            handle(textView: self, maxLimitLength: maxInputLength)
        }

        // placeholder
        updatePlaceholder()
    }

}

// MARK: - delegateHandler
extension FZTextView {

    /// add delegateHandler
    ///
    /// - Parameter delegateHandler: UITextViewDelegate to add
    @objc open func addDelegateHandler(_ delegateHandler: UITextViewDelegate) {
        /// To avoid repeated additions, remove first
        removeDelegateHandler(delegateHandler)
        /// keep it in delegateHandlers
        delegateHandlers.append(delegateHandler)
    }

    /// remove delegateHandler
    ///
    /// - Parameter delegateHandler: UITextViewDelegate to remove
    @objc open func removeDelegateHandler(_ delegateHandler: UITextViewDelegate) {
        delegateHandlers.removeAll { (_delegate: UITextViewDelegate) -> Bool in
            return _delegate === delegateHandler
        }
    }

}

// MARK: - placeholder
extension FZTextView {

    /// update placeholder
    fileprivate func updatePlaceholder() {
        var showPlaceholder = true

        // Whether placeholders are displayed
        if let text = self.text,
            text.count > 0 {
            showPlaceholder = false
        }

        if let attributedText = self.attributedText,
            attributedText.string.count > 0 {
            showPlaceholder = false
        }

        // Whether placeholders are set
        if let placeholderText = placeholderText,
            let placeholderAttributedText = placeholderAttributedText {
            showPlaceholder = showPlaceholder && (placeholderText.count > 0 || placeholderAttributedText.string.count > 0)

        } else if let placeholderText = placeholderText {
            showPlaceholder = showPlaceholder && (placeholderText.count > 0)

        } else if let placeholderAttributedText = placeholderAttributedText {
            showPlaceholder = showPlaceholder && (placeholderAttributedText.string.count > 0)

        } else {
            showPlaceholder = false
        }

        if showPlaceholder {

            if placeholderLabel.superview == nil {
                self.addSubview(placeholderLabel)
            }

            let textContainerInset = self.textContainerInset
            let lineFragmentPadding = self.textContainer.lineFragmentPadding

            placeholderLabel.textAlignment = self.textAlignment

            let x = lineFragmentPadding + textContainerInset.left
            let y = textContainerInset.top
            let width = self.bounds.width - x - lineFragmentPadding - textContainerInset.right
            let height = min(placeholderLabel.sizeThatFits(CGSize(width: width, height: CGFloat.leastNormalMagnitude)).height, self.bounds.height - textContainerInset.top - textContainerInset.bottom)
            placeholderLabel.frame = CGRect(x: x, y: y, width: width, height: height)

        } else {
            placeholderLabel.removeFromSuperview()
        }
    }

    @objc open var placeholderText: String? {
        set {
            placeholderLabel.text = newValue

            updatePlaceholder()
        }
        get {
            return placeholderLabel.text
        }
    }

    @objc open var placeholderAttributedText: NSAttributedString? {
        set {
            placeholderLabel.attributedText = newValue

            updatePlaceholder()
        }
        get {
            return placeholderLabel.attributedText
        }
    }

    @objc open var placeholderTextFont: UIFont {
        set {
            placeholderLabel.font = newValue

            updatePlaceholder()
        }
        get {
            return placeholderLabel.font
        }
    }

    @objc open var placeholderTextColor: UIColor {
        set {
            placeholderLabel.textColor = newValue

            updatePlaceholder()
        }
        get {
            return placeholderLabel.textColor
        }
    }

}

// MARK: - maxLimitLength
extension FZTextView {

    fileprivate func handle(textView: UITextView, maxLimitLength: Int) {
        if maxLimitLength > 0 {
            let text = textView.text ?? ""

            // zh-Hans Simplified Chinese
            // zh-Hant Traditional Chinese
            if let language = textView.textInputMode?.primaryLanguage,
                language == "zh-Hans" || language == "zh-Hant"{
                if let range = textView.markedTextRange,
                    let _ = textView.position(from: range.start, offset: 0) {
                    // Input Chinese, do not do processing

                } else {
                    if text.count > maxLimitLength {
                        textView.text = text[fz_safe: 0 ..< maxLimitLength]
                    }
                }
            } else {
                if text.count > maxLimitLength {
                    textView.text = text[fz_safe: 0..<Int(maxLimitLength)]
                }
            }
        }
    }

}

// MARK: - UITextViewDelegate
extension FZTextView: UITextViewDelegate {

    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        var shouldBeginEditing = true

        if let _delegate = self.delegate {
            shouldBeginEditing = shouldBeginEditing && (_delegate.textViewShouldBeginEditing?(textView) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldBeginEditing = shouldBeginEditing && (_delegate.textViewShouldBeginEditing?(textView) ?? true)
        }

        return shouldBeginEditing
    }

    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        var shouldEndEditing = true

        if let _delegate = self.delegate {
            shouldEndEditing = shouldEndEditing && (_delegate.textViewShouldEndEditing?(textView) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldEndEditing = shouldEndEditing && (_delegate.textViewShouldEndEditing?(textView) ?? true)
        }

        return shouldEndEditing
    }

    public func textViewDidBeginEditing(_ textView: UITextView) {
        if let _delegate = self.delegate {
            _delegate.textViewDidBeginEditing?(textView)
        }

        for _delegate in delegateHandlers {
            _delegate.textViewDidBeginEditing?(textView)
        }
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        if let _delegate = self.delegate {
            _delegate.textViewDidEndEditing?(textView)
        }

        for _delegate in delegateHandlers {
            _delegate.textViewDidEndEditing?(textView)
        }
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var shouldChange = true

        if let _delegate = self.delegate {
            shouldChange = shouldChange && (_delegate.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldChange = shouldChange && (_delegate.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true)
        }

        return shouldChange
    }

    public func textViewDidChange(_ textView: UITextView) {
        if let _delegate = self.delegate {
            _delegate.textViewDidChange?(textView)
        }

        for _delegate in delegateHandlers {
            _delegate.textViewDidChange?(textView)
        }
    }

    public func textViewDidChangeSelection(_ textView: UITextView) {
        if let _delegate = self.delegate {
            _delegate.textViewDidChangeSelection?(textView)
        }

        for _delegate in delegateHandlers {
            _delegate.textViewDidChangeSelection?(textView)
        }
    }

    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        var shouldInteractWithURL = true

        if let _delegate = self.delegate {
            shouldInteractWithURL = shouldInteractWithURL && (_delegate.textView?(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldInteractWithURL = shouldInteractWithURL && (_delegate.textView?(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction) ?? true)
        }

        return shouldInteractWithURL
    }

    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        var shouldInteractWithTextAttachment = true

        if let _delegate = self.delegate {
            shouldInteractWithTextAttachment = shouldInteractWithTextAttachment && (_delegate.textView?(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldInteractWithTextAttachment = shouldInteractWithTextAttachment && (_delegate.textView?(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction) ?? true)
        }

        return shouldInteractWithTextAttachment
    }

    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        var shouldInteractWithURL = true

        if let _delegate = self.delegate {
            shouldInteractWithURL = shouldInteractWithURL && (_delegate.textView?(textView, shouldInteractWith: URL, in: characterRange) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldInteractWithURL = shouldInteractWithURL && (_delegate.textView?(textView, shouldInteractWith: URL, in: characterRange) ?? true)
        }

        return shouldInteractWithURL
    }

    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        var shouldInteractWithTextAttachment = true

        if let _delegate = self.delegate {
            shouldInteractWithTextAttachment = shouldInteractWithTextAttachment && (_delegate.textView?(textView, shouldInteractWith: textAttachment, in: characterRange) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldInteractWithTextAttachment = shouldInteractWithTextAttachment && (_delegate.textView?(textView, shouldInteractWith: textAttachment, in: characterRange) ?? true)
        }

        return shouldInteractWithTextAttachment
    }

}
