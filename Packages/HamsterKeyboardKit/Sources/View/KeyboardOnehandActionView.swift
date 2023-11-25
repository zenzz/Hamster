//
//  File.swift
//  
//
//  Created by matt on 2023/11/24.
//

import Combine
import HamsterKit
import HamsterUIKit
import UIKit

var identifier: String = {
  var systemInfo = utsname()
  uname(&systemInfo)
  let mirror = Mirror(reflecting: systemInfo.machine)
  
  let identifier = mirror.children.reduce("") { identifier, element in
    guard let value = element.value as? Int8, value != 0 else { return identifier }
    return identifier + String(UnicodeScalar(UInt8(value)))
  }
  return identifier
}()

func canEnableOnehandMode() -> Bool {
  let model = identifier
  let cantSupportDevice = ["iPhone10,1","iPhone10,4","iPhone12,8","iPhone14,6"]
  return UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.width >= 375 && !cantSupportDevice.contains(model)
}

/**
 键盘单手模式
 */
class KeyboardOnehandActionView: NibLessView {
  
  private let appearance: KeyboardAppearance
//  private let actionHandler: KeyboardActionHandler
  private let keyboardContext: KeyboardContext
  private var rimeContext: RimeContext
//  private var subscriptions = Set<AnyCancellable>()
//  private var style: CandidateBarStyle
//  private var userInterfaceStyle: UIUserInterfaceStyle
  
  /// 常用功能项: 仓输入法App
  lazy var switchModeButton: UIButton = {
    let button = UIButton(type: .custom)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "keyboard.onehanded.right"), for: .normal)
    button.setPreferredSymbolConfiguration(.init(font: .systemFont(ofSize: 24), scale: .default), forImageIn: .normal)
    button.tintColor = appearance.candidateBarStyle.toolbarButtonFrontColor
    button.backgroundColor = appearance.backgroundStyle.backgroundColor
//    button.backgroundColor = style.toolbarButtonBackgroundColor
//    button.addTarget(self, action: #selector(openHamsterAppTouchDownAction), for: .touchDown)
    button.addTarget(self, action: #selector(switchModeAction), for: .touchUpInside)
//    button.addTarget(self, action: #selector(touchCancel), for: .touchCancel)
//    button.addTarget(self, action: #selector(touchCancel), for: .touchUpOutside)
    
    return button
  }()
  
  /// 解散键盘 Button
  lazy var closeModeButton: UIButton = {
    let button = UIButton(type: .custom)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "arrow.down.left.and.arrow.up.right.square"), for: .normal)
    button.setPreferredSymbolConfiguration(.init(font: .systemFont(ofSize: 24), scale: .default), forImageIn: .normal)
    button.tintColor = appearance.candidateBarStyle.toolbarButtonFrontColor
    button.backgroundColor = appearance.backgroundStyle.backgroundColor
    button.addTarget(self, action: #selector(closeModeAction), for: .touchUpInside)
    return button
  }()
  
  init(appearance: KeyboardAppearance, keyboardContext: KeyboardContext, rimeContext: RimeContext) {
    self.appearance = appearance
//    self.actionHandler = actionHandler
    self.keyboardContext = keyboardContext
    self.rimeContext = rimeContext
    // KeyboardToolbarView 为 candidateBarStyle 样式根节点, 这里生成一次，减少计算次数
//    self.style = appearance.candidateBarStyle
//    self.userInterfaceStyle = keyboardContext.colorScheme
    
    super.init(frame: .zero)
    
    setupSubview()
    
    combine()
  }
  
  func setupSubview() {
    constructViewHierarchy()
    activateViewConstraints()
    setupAppearance()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
//    if userInterfaceStyle != keyboardContext.colorScheme {
//      userInterfaceStyle = keyboardContext.colorScheme
      setupAppearance()
//      candidateBarView.setStyle(self.style)
//    }
  }
  
  override func constructViewHierarchy() {
//    addSubview(commonFunctionBar)
    addSubview(switchModeButton)
    addSubview(closeModeButton)
  }
  
  override func activateViewConstraints() {
//    commonFunctionBar.fillSuperview()
    var constraints = [NSLayoutConstraint]()
    constraints.append(contentsOf: [
      switchModeButton.widthAnchor.constraint(equalToConstant: 60),
      switchModeButton.heightAnchor.constraint(equalTo: switchModeButton.widthAnchor),
      switchModeButton.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -40),
      switchModeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    ])
    
    constraints.append(contentsOf: [
      closeModeButton.widthAnchor.constraint(equalToConstant: 60),
      closeModeButton.heightAnchor.constraint(equalTo: closeModeButton.widthAnchor),
      closeModeButton.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 50),
      closeModeButton.centerXAnchor.constraint(equalTo: switchModeButton.centerXAnchor),
    ])
    if !constraints.isEmpty {
      NSLayoutConstraint.activate(constraints)
    }
  }
  func updateStyle() {
    if keyboardContext.isOnehandModeOnLeft {
      switchModeButton.setImage(UIImage(systemName: "keyboard.onehanded.right"), for: .normal)
      closeModeButton.setImage(UIImage(systemName: "arrow.up.backward.and.arrow.down.forward"), for: .normal)
    } else {
      switchModeButton.setImage(UIImage(systemName: "keyboard.onehanded.left"), for: .normal)
      closeModeButton.setImage(UIImage(systemName: "arrow.down.backward.and.arrow.up.forward"), for: .normal)
    }
  }
  
  override func setupAppearance() {
    updateStyle()
  }
  
  func combine() {  }
  
  @objc func switchModeAction() {
    keyboardContext.onehandOnLeft = !keyboardContext.onehandOnLeft
  }
  
  @objc func closeModeAction() {
    keyboardContext.onehandMode = false
  }
}
