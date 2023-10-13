//
//  TextContentView.swift
//
//
//  Created by morse on 2023/8/10.
//

import HamsterKit
import HamsterUIKit
import UIKit

/**
 该视图渲染系统键盘按钮的文本。

 注意：文本行数限制为 1 行，如果按钮操作是 input 类型且文本为小写，则会有垂直方向的偏移。
 */
public class TextContentView: NibLessView {
  private let keyboardContext: KeyboardContext
  private let item: KeyboardLayoutItem
  /// 按钮样式
  public var style: KeyboardButtonStyle {
    didSet {
      setNeedsLayout()
    }
  }

  /// 文本内容
  private var text: String

  /// 是否为输入类型操作
  private let isInputAction: Bool

  private lazy var label: UILabel = {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.lineBreakMode = .byTruncatingTail
    label.numberOfLines = 1
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.2

    return label
  }()

  private lazy var leftSwipeLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    label.numberOfLines = 1
    label.textColor = .secondaryLabel
    return label
  }()

  private lazy var rightSwipeLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    label.numberOfLines = 1
    label.textColor = .secondaryLabel
    return label
  }()

  private lazy var swipeLabelContainer: UIStackView = {
    let view = UIStackView(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.axis = .horizontal
    view.alignment = .center
    view.distribution = .equalSpacing

    for swipe in item.swipes {
      if swipe.display, swipe.direction == .up {
        if keyboardContext.upSwipeOnLeft {
          leftSwipeLabel.text = swipe.labelText
          view.addArrangedSubview(leftSwipeLabel)
        } else {
          rightSwipeLabel.text = swipe.labelText
          view.addArrangedSubview(rightSwipeLabel)
        }
      }

      if swipe.display, swipe.direction == .down {
        if keyboardContext.upSwipeOnLeft {
          rightSwipeLabel.text = swipe.labelText
          view.addArrangedSubview(rightSwipeLabel)
        } else {
          leftSwipeLabel.text = swipe.labelText
          view.addArrangedSubview(leftSwipeLabel)
        }
      }
    }

    return view
  }()

  private lazy var containerView: UIView = {
    let containerView = UIView(frame: .zero)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(label)

    if swipeLabelContainer.arrangedSubviews.isEmpty {
      NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: useOffset ? -2 : 0),
        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        label.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 1.0),
        containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 1.0)
      ])
    } else {
      containerView.addSubview(swipeLabelContainer)
      NSLayoutConstraint.activate([
        swipeLabelContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
        swipeLabelContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 3),
        swipeLabelContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -3),
        swipeLabelContainer.heightAnchor.constraint(equalToConstant: 12),

        label.topAnchor.constraint(equalTo: swipeLabelContainer.bottomAnchor, constant: useOffset ? -2 : 0),
        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        label.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 1.0),
        containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 1.0)
      ])
    }

    return containerView
  }()

  /// 是否使用偏移
  /// 即在Y轴向上偏移
  var useOffset: Bool {
    isInputAction && text.isLowercased
  }

  /// 是否向右偏移
  var offsetRight: Bool {
    text.isMatchChineseParagraph && !text.isPairSymbolsBegin
  }

  init(keyboardContext: KeyboardContext, item: KeyboardLayoutItem, style: KeyboardButtonStyle, text: String, isInputAction: Bool) {
    self.keyboardContext = keyboardContext
    self.item = item
    self.style = style
    self.text = text
    self.isInputAction = isInputAction

    super.init(frame: .zero)
  }

  override public func didMoveToWindow() {
    super.didMoveToWindow()

    setupTextView()
  }

  override public func layoutSubviews() {
    super.layoutSubviews()

    label.text = text
    label.font = style.font?.font
    label.textColor = style.foregroundColor

    leftSwipeLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    leftSwipeLabel.textColor = keyboardContext.secondaryLabelColor

    rightSwipeLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    rightSwipeLabel.textColor = keyboardContext.secondaryLabelColor
  }

  func setupTextView() {
    addSubview(containerView)
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  func setTextValue(_ text: String) {
    label.text = text
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TextContentView_Previews: PreviewProvider {
  static func textContent(text: String, action: KeyboardAction) -> some View {
    return UIViewPreview {
      let view = TextContentView(
        keyboardContext: KeyboardContext.preview,
        item: KeyboardLayoutItem(action: .character("a"), size: .init(width: .available, height: 24), insets: .zero, swipes: []),
        style: .preview1,
        text: text,
        isInputAction: action.isInputAction)
      view.frame = .init(x: 0, y: 0, width: 80, height: 80)
      return view
    }
  }

  static var previews: some View {
    HStack {
      textContent(text: "A", action: .character("A"))
      textContent(text: "a", action: .character("a"))
      textContent(text: "lower", action: .character("lower"))
      textContent(text: "lower", action: .backspace)
      textContent(text: "lowerlowerlowerlower", action: .backspace)
    }
  }
}

#endif