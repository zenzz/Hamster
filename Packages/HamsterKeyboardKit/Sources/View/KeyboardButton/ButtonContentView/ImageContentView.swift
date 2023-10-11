//
//  ImageContentView.swift
//
//
//  Created by morse on 2023/8/10.
//

import HamsterUIKit
import UIKit

class ImageContentView: NibLessView {
//  private let scaleFactor: CGFloat
  public let imageView: UIImageView
  public var style: KeyboardButtonStyle {
    didSet {
      setNeedsLayout()
    }
  }

  init(style: KeyboardButtonStyle, image: UIImage?, scaleFactor: CGFloat = .zero) {
    self.style = style
    self.imageView = UIImageView(image: image)
    imageView.contentMode = .center

    super.init(frame: .zero)
  }

  override func didMoveToWindow() {
    super.didMoveToWindow()

    setupImage()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    if let color = style.foregroundColor {
      imageView.tintColor = color
    } else {
      imageView.tintColor = UIColor.label
    }
  }

  func setupImage() {
    addSubview(imageView)

    imageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1.0),
      bottomAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1.0),
      imageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1.0),
      trailingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 1.0),
    ])
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ImageContentView_Previews: PreviewProvider {
  static func imageContent(action: KeyboardAction, scaleFactor: CGFloat = 1) -> some View {
    let appearance: KeyboardAppearance = .preview
    return UIViewPreview {
      let view = ImageContentView(
        style: .preview1,
        image: appearance.buttonImage(for: action),
        scaleFactor: scaleFactor
      )
//      view.frame = .init(origin: .zero, size: .init(width: 40, height: 40))
      return view
    }
  }

  static var previews: some View {
    HStack {
      imageContent(action: .backspace, scaleFactor: 2)
      imageContent(action: .nextKeyboard)
      imageContent(action: .keyboardType(.emojis))
    }
  }
}

#endif
