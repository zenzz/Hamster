//
//  SpaceContentView.swift
//
//
//  Created by morse on 2023/8/10.
//

import Combine
import HamsterUIKit
import UIKit

class SpaceContentView: NibLessView {
  private let keyboardContext: KeyboardContext
  private let rimeContext: RimeContext
  private let item: KeyboardLayoutItem
  private var spaceText: String
  private var subscriptions = Set<AnyCancellable>()
  private var asciiState: Bool
  private var style: KeyboardButtonStyle
  private var oldBounds: CGRect = .zero

  private lazy var loadingLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .center
    label.numberOfLines = 1
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.2
    if keyboardContext.keyboardType.isCustom {
      label.text = item.key?.label.loadingText ?? ""
      if keyboardContext.showCurrentInputSchemaNameOnLoadingTextForSpaceButton, let text = rimeContext.currentSchema?.schemaName {
        label.text = text
      }
    } else {
      label.text = keyboardContext.loadingTextForSpaceButton
      if keyboardContext.showCurrentInputSchemaNameOnLoadingTextForSpaceButton, let text = rimeContext.currentSchema?.schemaName {
        label.text = text
      }
    }
    return label
  }()

  private lazy var textView: TextContentView = {
    var spaceText = ""
    if keyboardContext.keyboardType.isCustom {
      spaceText = item.key?.label.text ?? ""
      if keyboardContext.showCurrentInputSchemaNameForSpaceButton, let text = rimeContext.currentSchema?.schemaName {
        spaceText = text
      }
    } else {
      spaceText = keyboardContext.labelTextForSpaceButton
      if keyboardContext.showCurrentInputSchemaNameForSpaceButton, let text = rimeContext.currentSchema?.schemaName {
        spaceText = text
      }
    }

    // 数字键盘不显示
    if keyboardContext.keyboardType.isNumber {
      spaceText = self.spaceText
    }

    let textView = TextContentView(
      keyboardContext: keyboardContext,
      item: item,
      style: style,
      text: spaceText,
      isInputAction: true
    )
    return textView
  }()

  var isShowLoadingText: Bool {
    if keyboardContext.keyboardType.isNumber || !keyboardContext.enableLoadingTextForSpaceButton {
      return false
    }
    return true
  }

  init(keyboardContext: KeyboardContext, rimeContext: RimeContext, item: KeyboardLayoutItem, style: KeyboardButtonStyle, spaceText: String) {
    self.keyboardContext = keyboardContext
    self.rimeContext = rimeContext
    self.item = item
    self.style = style
    self.spaceText = spaceText
    self.asciiState = rimeContext.asciiMode

    super.init(frame: .zero)

    setupView()
    combine()
  }

  func setupView() {
    /// 数字键盘不显示加载文字
    if !isShowLoadingText {
      addSubview(textView)
      return
    }

    loadingLabel.textColor = style.foregroundColor
    loadingLabel.font = style.font
    loadingLabel.alpha = showLoadingTextAlphaValue
    addSubview(loadingLabel)

    textView.alpha = showTextViewAlphaValue
    addSubview(textView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    guard self.bounds != .zero, self.bounds != oldBounds else { return }

    self.oldBounds = self.bounds
    loadingLabel.frame = oldBounds
    textView.frame = oldBounds
  }

  override func setupAppearance() {
    loadingLabel.textColor = style.foregroundColor
    textView.setStyle(style)
  }

  func setStyle(_ style: KeyboardButtonStyle) {
    guard self.style != style else { return }
    self.style = style
    setupAppearance()
  }

  var showLoadingTextAlphaValue: CGFloat {
    guard keyboardContext.firstLoadingSpace else { return 0 }
    return isShowLoadingText ? 1 : 0
  }

  var showTextViewAlphaValue: CGFloat {
    guard keyboardContext.firstLoadingSpace else { return 1 }
    return isShowLoadingText ? 0 : 1
  }

  func combine() {
    rimeContext.$asciiMode
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in
        guard let self = self else { return }
        guard self.asciiState != $0 else { return }
        self.asciiState = $0
        loadingLabel.text = self.asciiState == false ? "中" : "英"
        self.textView.alpha = 0
        self.loadingLabel.alpha = 1
        loadingAnimate()
      }
      .store(in: &subscriptions)

    rimeContext.currentSchemaPublished
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in
        guard let self = self else { return }
        guard let schema = $0 else { return }
        guard !keyboardContext.keyboardType.isNumber else { return }

        if keyboardContext.showCurrentInputSchemaNameOnLoadingTextForSpaceButton {
          if loadingLabel.text != schema.schemaName {
            loadingLabel.text = schema.schemaName
            self.textView.alpha = 0
            self.loadingLabel.alpha = 1
            loadingAnimate()
          }
        }

        if keyboardContext.showCurrentInputSchemaNameForSpaceButton {
          textView.setTextValue(schema.schemaName)
        }
      }
      .store(in: &subscriptions)
  }

  override func didMoveToWindow() {
    super.didMoveToWindow()

    guard let _ = window else { return }
    if keyboardContext.firstLoadingSpace {
      self.keyboardContext.firstLoadingSpace = false
      if isShowLoadingText {
        loadingAnimate()
      }
    }
  }

  func loadingAnimate() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
      guard let self = self else { return }
      UIView.animate(withDuration: 0.35) {
        self.loadingLabel.alpha = 0
        self.textView.alpha = 1
      }
    }
  }
}
