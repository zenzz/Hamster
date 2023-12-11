//
//  CandidateBarStyle.swift
//
//
//  Created by morse on 2023/10/20.
//

import UIKit

/// 候选栏样式
public struct CandidateBarStyle: Equatable {
  /// 组字区文字颜色
  public var phoneticTextColor: UIColor?

  /// 组字区文字字体
  public var phoneticTextFont: UIFont

  /// 候选栏：首选候选文字颜色
  public var preferredCandidateTextColor: UIColor?

  /// 候选栏：首选候选文字 Comment 颜色
  public var preferredCandidateCommentTextColor: UIColor?

  /// 候选栏：首选区域背景色
  public var preferredCandidateBackgroundColor: UIColor?

  /// 候选栏：次选候选文字颜色
  public var candidateTextColor: UIColor?

  /// 候选栏：次选候选文字 Comment 颜色
  public var candidateCommentTextColor: UIColor?

  /// 候选文字字体
  public var candidateTextFont: UIFont

  /// 候选文字 Comment 字体
  public var candidateCommentFont: UIFont

  /// 候选栏工具按钮文字颜色
  public var toolbarButtonFrontColor: UIColor?

  /// 候选工具栏按钮背景色
  public var toolbarButtonBackgroundColor: UIColor?

  /// 候选工具栏按钮按下时背景色
  public var toolbarButtonPressedBackgroundColor: UIColor?

  init(
    phoneticTextColor: UIColor? = nil,
    phoneticTextFont: UIFont,
    preferredCandidateTextColor: UIColor? = nil,
    preferredCandidateCommentTextColor: UIColor? = nil,
    preferredCandidateBackgroundColor: UIColor? = nil,
    candidateTextColor: UIColor? = nil,
    candidateCommentTextColor: UIColor? = nil,
    candidateTextFont: UIFont,
    candidateCommentFont: UIFont,
    toolbarButtonFrontColor: UIColor? = nil,
    toolbarButtonBackgroundColor: UIColor? = nil,
    toolbarButtonPressedBackgroundColor: UIColor? = nil

  ) {
    self.phoneticTextColor = phoneticTextColor
    self.phoneticTextFont = phoneticTextFont
    self.preferredCandidateTextColor = preferredCandidateTextColor
    self.preferredCandidateCommentTextColor = preferredCandidateCommentTextColor
    self.preferredCandidateBackgroundColor = preferredCandidateBackgroundColor
    self.candidateTextColor = candidateTextColor
    self.candidateCommentTextColor = candidateCommentTextColor
    self.candidateTextFont = candidateTextFont
    self.candidateCommentFont = candidateCommentFont
    self.toolbarButtonFrontColor = toolbarButtonFrontColor
    self.toolbarButtonBackgroundColor = toolbarButtonBackgroundColor
    self.toolbarButtonPressedBackgroundColor = toolbarButtonPressedBackgroundColor
  }
}
