//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `green`.
    static let green = Rswift.ColorResource(bundle: R.hostingBundle, name: "green")
    
    /// `UIColor(named: "green", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func green(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.green, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `man`.
    static let man = Rswift.ImageResource(bundle: R.hostingBundle, name: "man")
    
    /// `UIImage(named: "man", bundle: ..., traitCollection: ...)`
    static func man(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.man, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 3 nibs.
  struct nib {
    /// Nib `BreweryMapViewController`.
    static let breweryMapViewController = _R.nib._BreweryMapViewController()
    /// Nib `BreweryTVC`.
    static let breweryTVC = _R.nib._BreweryTVC()
    /// Nib `BreweryViewController`.
    static let breweryViewController = _R.nib._BreweryViewController()
    
    /// `UINib(name: "BreweryMapViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.breweryMapViewController) instead")
    static func breweryMapViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.breweryMapViewController)
    }
    
    /// `UINib(name: "BreweryTVC", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.breweryTVC) instead")
    static func breweryTVC(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.breweryTVC)
    }
    
    /// `UINib(name: "BreweryViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.breweryViewController) instead")
    static func breweryViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.breweryViewController)
    }
    
    static func breweryMapViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.breweryMapViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    static func breweryTVC(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> BreweryTVC? {
      return R.nib.breweryTVC.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? BreweryTVC
    }
    
    static func breweryViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.breweryViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `BreweryTVC`.
    static let breweryTVC: Rswift.ReuseIdentifier<BreweryTVC> = Rswift.ReuseIdentifier(identifier: "BreweryTVC")
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 3 localization tables.
  struct string {
    /// This `R.string.alert` struct is generated, and contains static references to 6 localization keys.
    struct alert {
      /// Value: Error internet connection
      static let internetConnectionError = Rswift.StringResource(key: "internet.connectionError", tableName: "Alert", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Internet connection error
      static let internetConnectionMessage = Rswift.StringResource(key: "internetConnection.message", tableName: "Alert", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Internet error
      static let internetConnectionTitle = Rswift.StringResource(key: "internetConnection.title", tableName: "Alert", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: OK
      static let ok = Rswift.StringResource(key: "ok", tableName: "Alert", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Oops!
      static let oops = Rswift.StringResource(key: "oops", tableName: "Alert", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Response data nil
      static let dataResponseNil = Rswift.StringResource(key: "data.response.nil", tableName: "Alert", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: Error internet connection
      static func internetConnectionError(_: Void = ()) -> String {
        return NSLocalizedString("internet.connectionError", tableName: "Alert", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Internet connection error
      static func internetConnectionMessage(_: Void = ()) -> String {
        return NSLocalizedString("internetConnection.message", tableName: "Alert", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Internet error
      static func internetConnectionTitle(_: Void = ()) -> String {
        return NSLocalizedString("internetConnection.title", tableName: "Alert", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: OK
      static func ok(_: Void = ()) -> String {
        return NSLocalizedString("ok", tableName: "Alert", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Oops!
      static func oops(_: Void = ()) -> String {
        return NSLocalizedString("oops", tableName: "Alert", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Response data nil
      static func dataResponseNil(_: Void = ()) -> String {
        return NSLocalizedString("data.response.nil", tableName: "Alert", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    /// This `R.string.localizable` struct is generated, and contains static references to 10 localization keys.
    struct localizable {
      /// Value: Breweries
      static let breweryTitle = Rswift.StringResource(key: "brewery.title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: City: %@
      static let city = Rswift.StringResource(key: "city", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Close
      static let breweryMapVCClose = Rswift.StringResource(key: "breweryMapVC.close", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Country: %@
      static let country = Rswift.StringResource(key: "country", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Country: %@
      static let website = Rswift.StringResource(key: "website", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Phone: %@
      static let phone = Rswift.StringResource(key: "phone", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Show on map
      static let breweryVCShowOnMap = Rswift.StringResource(key: "breweryVC.showOnMap", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: State: %@
      static let state = Rswift.StringResource(key: "state", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Street: %@
      static let street = Rswift.StringResource(key: "street", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Website:
      static let web = Rswift.StringResource(key: "web", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: Breweries
      static func breweryTitle(_: Void = ()) -> String {
        return NSLocalizedString("brewery.title", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: City: %@
      static func city(_ value1: String) -> String {
        return String(format: NSLocalizedString("city", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Value: Close
      static func breweryMapVCClose(_: Void = ()) -> String {
        return NSLocalizedString("breweryMapVC.close", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Country: %@
      static func country(_ value1: String) -> String {
        return String(format: NSLocalizedString("country", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Value: Country: %@
      static func website(_ value1: String) -> String {
        return String(format: NSLocalizedString("website", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Value: Phone: %@
      static func phone(_ value1: String) -> String {
        return String(format: NSLocalizedString("phone", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Value: Show on map
      static func breweryVCShowOnMap(_: Void = ()) -> String {
        return NSLocalizedString("breweryVC.showOnMap", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: State: %@
      static func state(_ value1: String) -> String {
        return String(format: NSLocalizedString("state", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Value: Street: %@
      static func street(_ value1: String) -> String {
        return String(format: NSLocalizedString("street", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Value: Website:
      static func web(_: Void = ()) -> String {
        return NSLocalizedString("web", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    /// This `R.string.validation` struct is generated, and contains static references to 0 localization keys.
    struct validation {
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
    try storyboard.validate()
    try nib.validate()
  }
  
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _BreweryViewController.validate()
    }
    
    struct _BreweryMapViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "BreweryMapViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _BreweryTVC: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = BreweryTVC
      
      let bundle = R.hostingBundle
      let identifier = "BreweryTVC"
      let name = "BreweryTVC"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> BreweryTVC? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? BreweryTVC
      }
      
      fileprivate init() {}
    }
    
    struct _BreweryViewController: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "BreweryViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "man", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'man' is used in nib 'BreweryViewController', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "Main"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
