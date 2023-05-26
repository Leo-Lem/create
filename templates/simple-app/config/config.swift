// Created by <#NAME#> on <#DATE#>.

import Foundation

let ID = (
  BUNDLE: "<#TEAM#>.<#TITLE#>",
  GROUP: "group.<#TEAM#>.<#TITLE#>"
)

var CONTAINER_URL: URL { FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: ID.GROUP)! }

var LANGUAGE_CODE: Locale.LanguageCode { Locale.current.language.languageCode ?? .english }

let INFO = (
  APPNAME: (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String)!,
  CREDITS: (
    DEVELOPERS: ["<#NAME#>"],
    DESIGNERS: ["<#NAME#>"]
  )
)
