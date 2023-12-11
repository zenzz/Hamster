//
//  AutocompleteToolbarStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This style can be applied to ``AutocompleteToolbar`` views.

 此样式可应用于 ``AutocompleteToolbar`` 视图。

 You can modify the ``standard`` style to change the default,
 global style of all ``AutocompleteToolbar``s.

 您可以修改 ``standard`` 样式，以更改所有 ``AutocompleteToolbar`` 的默认全局样式。
 */
public struct AutocompleteToolbarStyle: Equatable {
  /**
   The background style to apply behind autocomplete items.

   在自动完成 item 应用的背景样式。
   */
  public var autocompleteBackground: AutocompleteToolbarItemBackgroundStyle

  /**
   An optional, fixed toolbar height.

   可选项， 固定工具栏高度。
   */
  public var height: CGFloat?

  /**
   The item style to apply to the toolbar items.

   应用于工具栏 item 的样式。
   */
  public var item: AutocompleteToolbarItemStyle

  /**
   The separator style to apply to the toolbar separators.

   应用于工具栏分隔线的分隔线样式。
   */
  public var separator: AutocompleteToolbarSeparatorStyle

  /**
   Create an autocomplete toolbar style.

   - Parameters:
     - height: An optional toolbar height, by default `50`.
     - item: The item style, by default ``AutocompleteToolbarItemStyle/standard``.
     - separator: The separator style, by default ``AutocompleteToolbarSeparatorStyle/standard``.
     - autocompleteBackground: The background style to apply behind autocomplete items, by default ``AutocompleteToolbarItemBackgroundStyle/standard``.
   */
  public init(
    height: CGFloat? = 50,
    item: AutocompleteToolbarItemStyle = .standard,
    separator: AutocompleteToolbarSeparatorStyle = .standard,
    autocompleteBackground: AutocompleteToolbarItemBackgroundStyle = .standard
  ) {
    self.height = height
    self.item = item
    self.separator = separator
    self.autocompleteBackground = autocompleteBackground
  }
}

public extension AutocompleteToolbarStyle {
  /**
   This standard style mimics the native iOS style.

   This can be set to change the standard value everywhere.
   */
  static var standard = AutocompleteToolbarStyle()
}

extension AutocompleteToolbarStyle {
  /**
   This internal style is only used in previews.
   */
  static var preview1 = AutocompleteToolbarStyle(
    item: .preview1,
    separator: .preview1,
    autocompleteBackground: .preview1
  )

  /**
   This internal style is only used in previews.
   */
  static var preview2 = AutocompleteToolbarStyle(
    item: .preview2,
    separator: .preview2,
    autocompleteBackground: .preview2
  )
}
