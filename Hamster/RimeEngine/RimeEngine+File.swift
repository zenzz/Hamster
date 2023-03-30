//
//  RimeEngine+File.swift
//  Hamster
//
//  Created by morse on 7/3/2023.
//

import Foundation

extension RimeEngine {
  // AppGroup共享目录
  public static var shareURL: URL {
    FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: AppConstants.appGroupName)!
  }

  // AppGroup共享下: SharedSupport目录
  static var appGroupSharedSupportDirectoryURL: URL {
    shareURL.appendingPathComponent(
      AppConstants.rimeSharedSupportPathName, isDirectory: true)
  }

  // AppGroup共享下: userData目录
  static var appGroupUserDataDirectoryURL: URL {
    shareURL.appendingPathComponent(
      AppConstants.rimeUserPathName, isDirectory: true)
  }

  // 沙盒Document目录下ShareSupport目录
  static var sharedSupportDirectory: URL {
    try! FileManager.default
      .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
      .appendingPathComponent(AppConstants.rimeSharedSupportPathName, isDirectory: true)
  }

  // 沙盒Document目录下userData目录
  static var userDataDirectory: URL {
    try! FileManager.default
      .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
      .appendingPathComponent(AppConstants.rimeUserPathName, isDirectory: true)
  }

  // 安装包ShareSupport资源目录
  private static var appSharedSupportDirectory: URL {
    Bundle.main.bundleURL
      .appendingPathComponent(AppConstants.rimeSharedSupportPathName, isDirectory: true)
  }

  // 初始化AppGroup共享目录下SharedSupport目录资源
  static func initAppGroupSharedSupportDirectory(override: Bool = false) throws {
    let fm = FileManager.default
    let dst = appGroupSharedSupportDirectoryURL
    let src = appSharedSupportDirectory
    if fm.fileExists(atPath: dst.path) {
      if override {
        try fm.removeItem(atPath: dst.path)
      } else {
        return
      }
    }
    try fm.copyItem(at: src, to: dst)
  }

  // 初始化AppGroup共享目录下UserData目录资源
  static func initAppGroupUserDataDirectory(override: Bool = false) throws {
    let fm = FileManager.default
    let dst = appGroupUserDataDirectoryURL
    if fm.fileExists(atPath: dst.path) {
      if override {
        try fm.removeItem(atPath: dst.path)
      } else {
        return
      }
    }
    try fm.createDirectory(at: dst, withIntermediateDirectories: true)
  }

  // 初始化应用沙盒目录下UserData目录
  static func initUserDataDirectory() throws {
    let fm = FileManager.default
    let dst = userDataDirectory
    if fm.fileExists(atPath: dst.path) {
      return
    }
    try fm.createDirectory(at: dst, withIntermediateDirectories: true)
  }

  // 同步AppGroup共享目录下SharedSupport目录至沙盒目录
  static func syncAppGroupSharedSupportDirectory(override: Bool = false) throws {
    let fm = FileManager.default
    let dst = sharedSupportDirectory

    if fm.fileExists(atPath: dst.path) {
      if override {
        try fm.removeItem(atPath: dst.path)
      } else {
        return
      }
    }

    let src = appGroupSharedSupportDirectoryURL
    try fm.copyItem(at: src, to: dst)
  }

  // 同步AppGroup共享目录下UserData目录至沙盒目录
  static func syncAppGroupUserDataDirectory(override: Bool = false) throws {
    let fm = FileManager.default
    let dst = userDataDirectory

    if fm.fileExists(atPath: dst.path) {
      if override {
        try fm.removeItem(atPath: dst.path)
      } else {
        return
      }
    }

    let src = appGroupUserDataDirectoryURL
    try fm.copyItem(at: src, to: dst)
  }
}