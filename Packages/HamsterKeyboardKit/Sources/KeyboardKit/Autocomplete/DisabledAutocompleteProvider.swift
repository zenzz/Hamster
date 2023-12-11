//
//  DisabledAutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class is by default used as a placeholder autocomplete
 provider, until a real provider is injected.

 该类默认用作自动完成提供程序的占位符，直到注入真正的提供程序。
 */
public class DisabledAutocompleteProvider: AutocompleteProvider {
  public init() {}

  public var locale: Locale = .current

  public func autocompleteSuggestions(for text: String, completion: (AutocompleteResult) -> Void) {
    completion(.success([]))
  }

  public var canIgnoreWords: Bool { false }
  public var canLearnWords: Bool { false }
  public var ignoredWords: [String] = []
  public var learnedWords: [String] = []

  public func hasIgnoredWord(_ word: String) -> Bool { false }
  public func hasLearnedWord(_ word: String) -> Bool { false }
  public func ignoreWord(_ word: String) {}
  public func learnWord(_ word: String) {}
  public func removeIgnoredWord(_ word: String) {}
  public func unlearnWord(_ word: String) {}
}
