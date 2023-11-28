//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `cover-logo`.
    static let coverLogo = Rswift.ImageResource(bundle: R.hostingBundle, name: "cover-logo")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "cover-logo", bundle: ..., traitCollection: ...)`
    static func coverLogo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.coverLogo, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "Main"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 2 nibs.
  struct nib {
    /// Nib `EpisodeTableViewCell`.
    static let episodeTableViewCell = _R.nib._EpisodeTableViewCell()
    /// Nib `SeasonTableViewCell`.
    static let seasonTableViewCell = _R.nib._SeasonTableViewCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "EpisodeTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.episodeTableViewCell) instead")
    static func episodeTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.episodeTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SeasonTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.seasonTableViewCell) instead")
    static func seasonTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.seasonTableViewCell)
    }
    #endif

    static func episodeTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> EpisodeTableViewCell? {
      return R.nib.episodeTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? EpisodeTableViewCell
    }

    static func seasonTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SeasonTableViewCell? {
      return R.nib.seasonTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SeasonTableViewCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `EpisodeTableViewCell`.
    static let episodeTableViewCell: Rswift.ReuseIdentifier<EpisodeTableViewCell> = Rswift.ReuseIdentifier(identifier: "EpisodeTableViewCell")
    /// Reuse identifier `SeasonTableViewCell`.
    static let seasonTableViewCell: Rswift.ReuseIdentifier<SeasonTableViewCell> = Rswift.ReuseIdentifier(identifier: "SeasonTableViewCell")

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 6 localization keys.
    struct localizable {
      /// Value: Cancel
      static let cancel = Rswift.StringResource(key: "Cancel", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Driver Already LoggedIn
      static let api_ERROR_Already_LoggedIn = Rswift.StringResource(key: "API_ERROR_Already_LoggedIn", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Error
      static let error = Rswift.StringResource(key: "Error", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: No Internet Connection. Please check your connection and try again
      static let api_ERROR_No_Connection = Rswift.StringResource(key: "API_ERROR_No_Connection", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: OK
      static let oK = Rswift.StringResource(key: "OK", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Retry
      static let retry = Rswift.StringResource(key: "Retry", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: Cancel
      static func cancel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Cancel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Cancel"
        }

        return NSLocalizedString("Cancel", bundle: bundle, comment: "")
      }

      /// Value: Driver Already LoggedIn
      static func api_ERROR_Already_LoggedIn(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("API_ERROR_Already_LoggedIn", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "API_ERROR_Already_LoggedIn"
        }

        return NSLocalizedString("API_ERROR_Already_LoggedIn", bundle: bundle, comment: "")
      }

      /// Value: Error
      static func error(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error"
        }

        return NSLocalizedString("Error", bundle: bundle, comment: "")
      }

      /// Value: No Internet Connection. Please check your connection and try again
      static func api_ERROR_No_Connection(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("API_ERROR_No_Connection", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "API_ERROR_No_Connection"
        }

        return NSLocalizedString("API_ERROR_No_Connection", bundle: bundle, comment: "")
      }

      /// Value: OK
      static func oK(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("OK", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "OK"
        }

        return NSLocalizedString("OK", bundle: bundle, comment: "")
      }

      /// Value: Retry
      static func retry(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Retry", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Retry"
        }

        return NSLocalizedString("Retry", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _EpisodeTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = EpisodeTableViewCell

      let bundle = R.hostingBundle
      let identifier = "EpisodeTableViewCell"
      let name = "EpisodeTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> EpisodeTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? EpisodeTableViewCell
      }

      fileprivate init() {}
    }

    struct _SeasonTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = SeasonTableViewCell

      let bundle = R.hostingBundle
      let identifier = "SeasonTableViewCell"
      let name = "SeasonTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SeasonTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SeasonTableViewCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "cover-logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'cover-logo' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let episodeDetailsViewController = StoryboardViewControllerResource<EpisodeDetailsViewController>(identifier: "EpisodeDetailsViewController")
      let episodesViewController = StoryboardViewControllerResource<EpisodesViewController>(identifier: "EpisodesViewController")
      let name = "Main"
      let seasonsViewController = StoryboardViewControllerResource<SeasonsViewController>(identifier: "SeasonsViewController")
      let splashViewController = StoryboardViewControllerResource<SplashViewController>(identifier: "SplashViewController")

      func episodeDetailsViewController(_: Void = ()) -> EpisodeDetailsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: episodeDetailsViewController)
      }

      func episodesViewController(_: Void = ()) -> EpisodesViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: episodesViewController)
      }

      func seasonsViewController(_: Void = ()) -> SeasonsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: seasonsViewController)
      }

      func splashViewController(_: Void = ()) -> SplashViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: splashViewController)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.main().episodeDetailsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'episodeDetailsViewController' could not be loaded from storyboard 'Main' as 'EpisodeDetailsViewController'.") }
        if _R.storyboard.main().episodesViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'episodesViewController' could not be loaded from storyboard 'Main' as 'EpisodesViewController'.") }
        if _R.storyboard.main().seasonsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'seasonsViewController' could not be loaded from storyboard 'Main' as 'SeasonsViewController'.") }
        if _R.storyboard.main().splashViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'splashViewController' could not be loaded from storyboard 'Main' as 'SplashViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
