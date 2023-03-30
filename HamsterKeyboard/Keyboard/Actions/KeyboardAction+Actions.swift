import Foundation
import KeyboardKit

extension KeyboardAction {
//  // 用于注入 HamsterInputViewController 并兼容 KeyboardKit
//  typealias HamsterGestureAction = (HamsterKeyboardViewController?) -> GestureAction

  func hamsterStanderAction(for gesture: KeyboardGesture) -> GestureAction? {
    switch gesture {
    case .doubleTap: return hamsterStandardDoubleTapAction
    case .longPress: return hamsterStandardLongPressAction
    case .press: return hamsterStandardPressAction
    case .release: return hamsterStandardReleaseAction
    case .repeatPress: return hamsterStandardRepeatAction
    }
  }

  /**
   The action that by default should be triggered when the
   action is double tapped.
   */
  var hamsterStandardDoubleTapAction: GestureAction? { nil }

  /**
   The action that by default should be triggered when the
   action is long pressed.
   */
  var hamsterStandardLongPressAction: GestureAction? {
    switch self {
    case .space: return { _ in }
    default: return nil
    }
  }

  /**
   The action that by default should be triggered when the
   action is pressed.
   */
  var hamsterStandardPressAction: GestureAction? {
    switch self {
    case .backspace: return { $0?.deleteBackward() }
    case .keyboardType(let type): return { $0?.setKeyboardType(type) }
    default: return nil
    }
  }

  /**
   The action that by default should be triggered when the
   action is released.
   */
  var hamsterStandardReleaseAction: GestureAction? {
    switch self {
    case .character(let char): return { $0?.insertText(char) }
    case .characterMargin(let char): return { $0?.insertText(char) }
    case .dismissKeyboard: return { $0?.dismissKeyboard() }
    case .emoji(let emoji): return { $0?.insertText(emoji.char) }
    case .moveCursorBackward: return { $0?.adjustTextPosition(byCharacterOffset: -1) }
    case .moveCursorForward: return { $0?.adjustTextPosition(byCharacterOffset: 1) }
    case .nextLocale: return { $0?.selectNextLocale() }
    case .nextKeyboard: return { $0?.selectNextKeyboard() }
    case .primary: return { $0?.insertText(.newline) }
    case .shift(let currentState):
      return {
        switch currentState {
        case .lowercased: $0?.setKeyboardType(.alphabetic(.uppercased))
        case .auto, .capsLocked, .uppercased: $0?.setKeyboardType(.alphabetic(.lowercased))
        }
      }
    case .space: return { $0?.insertText(.space) }
    case .tab: return { $0?.insertText(.tab) }
    // 自定义按键动作处理
    case .custom(let name): return { $0?.insertText(name) }
    default: return nil
    }
  }

  /**
   The action that by default should be triggered when the
   action is pressed, and repeated until it is released.
   */
  var hamsterStandardRepeatAction: GestureAction? {
    switch self {
    case .backspace: return hamsterStandardPressAction
    default: return nil
    }
  }
}