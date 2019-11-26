//
//  KeyboardObserver.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/22.
//

import Foundation

/**
 提供键盘监听功能， 配合ObserveAble使用会更方便
 */
open class KeyboardObserver {

    public init() {

    }

    /// status 和键盘通知一一对应
    ///
    ///     public class let keyboardWillShowNotification: NSNotification.Name
    ///
    ///     public class let keyboardDidShowNotification: NSNotification.Name
    ///
    ///     public class let keyboardWillHideNotification: NSNotification.Name
    ///
    ///     public class let keyboardDidHideNotification: NSNotification.Name
    ///
    ///     // Like the standard keyboard notifications above, these additional notifications include
    ///     // a nil object and begin/end frames of the keyboard in screen coordinates in the userInfo dictionary.
    ///     @available(iOS 5.0, *)
    ///     public class let keyboardWillChangeFrameNotification: NSNotification.Name
    ///
    ///     @available(iOS 5.0, *)
    ///     public class let keyboardDidChangeFrameNotification: NSNotification.Name
    ///
    /// - willShow: keyboardWillShowNotification
    /// - didShow: keyboardDidShowNotification
    /// - willHide: keyboardWillHideNotification
    /// - didHide: keyboardDidHideNotification
    /// - willChangeFrame: keyboardWillChangeFrameNotification
    /// - didChangeFrame: keyboardDidChangeFrameNotification
    public enum KeyboardStatus: Int {
        case willShow
        case didShow
        case willHide
        case didHide
        case willChangeFrame
        case didChangeFrame
    }

    /// 键盘相关数据
    ///
    ///     //初始的 frame
    ///     @available(iOS 3.2, *)
    ///     public class let keyboardFrameBeginUserInfoKey: String // NSValue of CGRect
    ///
    ///     //结束的 frame
    ///     @available(iOS 3.2, *)
    ///     public class let keyboardFrameEndUserInfoKey: String // NSValue of CGRect
    ///
    ///     //持续的时间
    ///     @available(iOS 3.0, *)
    ///     public class let keyboardAnimationDurationUserInfoKey: String // NSNumber of double
    ///
    ///     //UIView.AnimationCurve
    ///     @available(iOS 3.0, *)
    ///     public class let keyboardAnimationCurveUserInfoKey: String // NSNumber of NSUInteger (UIViewAnimationCurve)
    ///
    ///     //是否是当前 App的键盘
    ///     @available(iOS 9.0, *)
    ///     public class let keyboardIsLocalUserInfoKey: String // NSNumber of BOOL
    ///
    ///
    public typealias KeyboardInfomation = (keyboardStatus: KeyboardObserver.KeyboardStatus, frameBegin: CGRect, frameEnd: CGRect, animationDuration: Double, animationCurve: UIView.AnimationCurve, isLocal: Bool)

    public typealias KeyboardStatusAction = (KeyboardInfomation) -> Void

    /// 销毁监听的通知
    private var deinitAction: (() -> Void)?

    // MARK: - 键盘各个状态的回调action

    /// 键盘通知回调
    public var keyboardStatushandle: KeyboardStatusAction?

    /// 最新的键盘状态，如果尚未触发，为nil
    public private(set) var lastKeyboardInfomation: KeyboardInfomation?

    // MARK: - 监听控制

    /// 开启键盘监听
    ///
    /// - Parameter queue: default = OperationQueue.main, 通知回调执行的操作队列
    public func startKeyboardObserver(observerQueue queue: OperationQueue = OperationQueue.main) {
        self.stopKeyboardObserver()

        let willShowObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: queue) { [weak self](notification) in
            self?.handleKeyboardInfomation(fromNotification: notification, status: .willShow)
        }

        let didShowObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: queue) { [weak self](notification) in
            self?.handleKeyboardInfomation(fromNotification: notification, status: .didShow)
        }

        let willHideObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: queue) { [weak self](notification) in
            self?.handleKeyboardInfomation(fromNotification: notification, status: .willHide)
        }

        let didHideObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: queue) { [weak self](notification) in
            self?.handleKeyboardInfomation(fromNotification: notification, status: .didHide)
        }

        let willChnageFrameObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: queue) { [weak self](notification) in
            self?.handleKeyboardInfomation(fromNotification: notification, status: .willChangeFrame)
        }

        let didChnageFrameObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidChangeFrameNotification, object: nil, queue: queue) { [weak self](notification) in
            self?.handleKeyboardInfomation(fromNotification: notification, status: .didChangeFrame)
        }

        deinitAction = {
            NotificationCenter.default.removeObserver(willShowObserver)
            NotificationCenter.default.removeObserver(didShowObserver)
            NotificationCenter.default.removeObserver(willHideObserver)
            NotificationCenter.default.removeObserver(didHideObserver)
            NotificationCenter.default.removeObserver(willChnageFrameObserver)
            NotificationCenter.default.removeObserver(didChnageFrameObserver)
        }
    }

    /// 停止键盘监听
    public func stopKeyboardObserver() {
        deinitAction?()
        deinitAction = nil
    }

    /// 获取键盘相关数据
    ///
    /// - Parameters:
    ///   - notification: 数据来源的通知对象
    ///   - status: 键盘当前状态
    private func handleKeyboardInfomation(fromNotification notification: Notification, status: KeyboardObserver.KeyboardStatus) {
        guard let frameBegin = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect,
            let frameEnd = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let animationCurveValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
            let animationCurve = UIView.AnimationCurve(rawValue: animationCurveValue.intValue)
            else {
                return
        }
        var isLocal = true
        if #available(iOS 9.0, *) {
            isLocal = notification.userInfo?[UIResponder.keyboardIsLocalUserInfoKey] as? Bool ?? true
        }
        self.lastKeyboardInfomation = (keyboardStatus: status, frameBegin: frameBegin, frameEnd: frameEnd, animationDuration: animationDuration, animationCurve: animationCurve, isLocal: isLocal)
        self.keyboardStatushandle?(self.lastKeyboardInfomation!)
    }

    // MARK: -

    deinit {
        deinitAction?()
    }

}
