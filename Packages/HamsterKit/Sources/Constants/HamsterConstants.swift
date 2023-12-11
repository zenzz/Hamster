//
//  HamsterConstants.swift
//
//
//  Created by morse on 2023/7/3.
//

import Foundation

/// Hamster 应用常量
public enum HamsterConstants {
  /// AppGroup ID
  public static let appGroupName = "group.matt.rime"

  /// iCloud ID
  public static let iCloudID = "iCloud.com.matt.iRime"

  /// keyboard Bundle ID
  public static let keyboardBundleID = "com.matt.iRime.HamsterKeyboard"

  /// 跳转至系统添加键盘URL
  public static let addKeyboardPath = "app-settings:root=General&path=Keyboard/KEYBOARDS"

  // MARK: 与Squirrel.app保持一致

  /// RIME 预先构建的数据目录中
  public static let rimeSharedSupportPathName = "SharedSupport"

  /// RIME UserData目录
  public static let rimeUserPathName = "Rime"

  /// RIME 内置输入方案及配置zip包
  public static let inputSchemaZipFile = "SharedSupport.zip"

  /// APP URL
  /// 注意: 此值需要与info.plist中的参数保持一致
  public static let appURL = "hamster://com.matt.iRime"
}
