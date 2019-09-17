//
//  FZTextField.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/11.
//

import Foundation

/// Support for setting up multiple delegates
open class FZTextField: UITextField {

    public init() {
        super.init(frame: CGRect.zero)
        self.setupDefaultConfig()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupDefaultConfig()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override weak open var delegate: UITextFieldDelegate? {
        set {
            _delegate = newValue
        }
        get {
            return _delegate
        }
    }

    /// stored property of delegate
    fileprivate weak var _delegate: UITextFieldDelegate?

    /// other delegate handlers
    fileprivate var delegateHandlers: [UITextFieldDelegate] = []

    /// limit max input length, Less than or equal to 0 means no limit, default is 0
    @objc open var maxInputLength: Int = 0

    /// edgeInsets, default is UIEdgeInsets.zero
    @objc open var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero

    deinit {
        delegateHandlers.removeAll()
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - Default Config
extension FZTextField {

    fileprivate func setupDefaultConfig() {
        // The delegate is set to self by default
        super.delegate = self

        // add notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChangeNotification(_:)), name: UITextField.textDidChangeNotification, object: self)
    }

}

// MARK: - delegate Handler
extension FZTextField {

    /// add delegateHandler
    ///
    /// - Parameter delegateHandler: UITextFieldDelegate to add
    @objc open func addDelegateHandler(_ delegateHandler: UITextFieldDelegate) {
        /// To avoid repeated additions, remove first
        removeDelegateHandler(delegateHandler)
        /// keep it in delegateHandlers
        delegateHandlers.append(delegateHandler)
    }

    /// remove delegateHandler
    ///
    /// - Parameter delegateHandler: UITextFieldDelegate to remove
    @objc open func removeDelegateHandler(_ delegateHandler: UITextFieldDelegate) {
        delegateHandlers.removeAll { (_delegate: UITextFieldDelegate) -> Bool in
            return _delegate === delegateHandler
        }
    }

}

extension FZTextField {

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return realRect(forBounds: bounds)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return realRect(forBounds: bounds)
    }

    fileprivate func realRect(forBounds bounds: CGRect) -> CGRect {
        let edgeInsets = self.edgeInsets

        var realRect = bounds
        realRect.origin.x += edgeInsets.left
        realRect.origin.y += edgeInsets.top
        realRect.size.width += edgeInsets.left + edgeInsets.right
        realRect.size.height += edgeInsets.top + edgeInsets.bottom

        return realRect
    }
}

// MARK: - maxLimitLength
extension FZTextField {

    /// handler UITextField.textDidChangeNotification
    ///
    /// - Parameter notification: notification
    @objc fileprivate func handleTextDidChangeNotification(_ notification: Notification) {
        if maxInputLength > 0 {
            handle(textField: self, maxLimitLength: maxInputLength)
        }
    }

    fileprivate func handle(textField: UITextField, maxLimitLength: Int) {
        if maxLimitLength > 0 {
            let text = textField.text ?? ""

            // zh-Hans Simplified Chinese
            // zh-Hant Traditional Chinese
            if let language = textField.textInputMode?.primaryLanguage,
                language == "zh-Hans" || language == "zh-Hant"{
                if let range = textField.markedTextRange,
                    let _ = textField.position(from: range.start, offset: 0) {
                    // Input Chinese, do not do processing

                } else {
                    if text.count > maxLimitLength {
                        textField.text = text[fz_safe: 0 ..< maxLimitLength]
                    }
                }
            } else {
                if text.count > maxLimitLength {
                    textField.text = text[fz_safe: 0..<Int(maxLimitLength)]
                }
            }
        }
    }

}

// MARK: - UITextFieldDelegate
extension FZTextField: UITextFieldDelegate {

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.

        var shouldBeginEditing = true

        if let _delegate = delegate {
            shouldBeginEditing = shouldBeginEditing && (_delegate.textFieldShouldBeginEditing?(textField) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldBeginEditing = shouldBeginEditing && (_delegate.textFieldShouldBeginEditing?(textField) ?? true)
        }

        return shouldBeginEditing
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder

        if let _delegate = delegate {
            _delegate.textFieldDidBeginEditing?(textField)
        }

        for _delegate in delegateHandlers {
            _delegate.textFieldDidBeginEditing?(textField)
        }

    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

        var shouldEndEditing = true

        if let _delegate = delegate {
            shouldEndEditing = shouldEndEditing && (_delegate.textFieldShouldEndEditing?(textField) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldEndEditing = shouldEndEditing && (_delegate.textFieldShouldEndEditing?(textField) ?? true)
        }

        return shouldEndEditing
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

        if let _delegate = delegate {
            _delegate.textFieldDidEndEditing?(textField)
        }

        for _delegate in delegateHandlers {
            _delegate.textFieldDidEndEditing?(textField)
        }
    }

    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:

        if let _delegate = delegate {
            _delegate.textFieldDidEndEditing?(textField, reason: reason)
        }

        for _delegate in delegateHandlers {
            _delegate.textFieldDidEndEditing?(textField, reason: reason)
        }

    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text

        var shouldChangeCharacters = true

        if let _delegate = delegate {
            shouldChangeCharacters = shouldChangeCharacters && (_delegate.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldChangeCharacters = shouldChangeCharacters && (_delegate.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true)
        }

        return shouldChangeCharacters
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)

        var shouldClear = true

        if let _delegate = delegate {
            shouldClear = shouldClear && (_delegate.textFieldShouldClear?(textField) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldClear = shouldClear && (_delegate.textFieldShouldClear?(textField) ?? true)
        }

        return shouldClear
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.

        var shouldReturn = true

        if let _delegate = delegate {
            shouldReturn = shouldReturn && (_delegate.textFieldShouldReturn?(textField) ?? true)
        }

        for _delegate in delegateHandlers {
            shouldReturn = shouldReturn && (_delegate.textFieldShouldReturn?(textField) ?? true)
        }

        return shouldReturn
    }

}
