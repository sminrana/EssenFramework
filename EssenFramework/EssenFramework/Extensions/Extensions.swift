//
//  Extensions.swift
//  SOSFramework
//
//  Created by Smin on 12/23/23.
//

import Foundation
import UIKit
import OSLog

extension NSObject {

    /// Open URL, deprecated please use ``open(url:)``
    /// - Parameter url: string
    @objc
    @available(*, deprecated, message: "Use func open(url: String)")
    public func openURL(url: String) {
        if let u = URL(string: url) {
            UIApplication.shared.open(u)
        }
    }
    
    @objc
    public func open(url: String) {
      if let u = URL(string: url) {
        if #available(iOS 10, *) {
          UIApplication.shared.open(u, options: [:],
            completionHandler: {
              (success) in
               print("Open \(url): \(success)")
           })
        } else {
          let success = UIApplication.shared.openURL(u)
          print("Open \(url): \(success)")
        }
      }
    }
}

extension UIViewController {
    @objc
    public func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.cancel,
                                          handler: { handler in
                alert.dismiss(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc
    public func showCalendar() {
        let date = Date();
        open(url: "calshow:\(date.timeIntervalSinceReferenceDate)")
    }
}

extension Logger {
    private static var subsystem =  Bundle.main.bundleIdentifier!
    
    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")

    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
}


extension Int {
    public func stringValue() -> String {
        return String(self)
    }
}

extension Double {
    public func rounded(toPlaces places:Int) -> Double {
        let divisor = 100.00
        return (self * divisor).rounded() / divisor
    }
    
    public func format(f: String) -> String {
        return String(format: "%.\(f)f", self)
    }
    
    public func formatCurrency(f: String) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        return currencyFormatter.string(from: NSNumber(value: self))!
    }
}

extension String {
    public func double() -> Double {
        return Double(self)!
    }
    
    public func format(f: String) -> String {
        return String(format: "%.\(f)f", self.double())
    }
    
    public func formatX100(f: String) -> String {
        return String(format: "%.\(f)f", self.double() * 100)
    }
    
    public func million() -> String {
        let v = self.double()
        let b: Double = v / 1000000
        return String(format: "%.2f", b) + "M"
    }
    
    public func billion() -> String {
        let v = self.double()
        
        if v >= 1000 {
            let b: Double = v / 1000
            return String(format: "%.0f", b) + "B"
        } else {
            let b = v
            return String(format: "%.0f", b) + "M"
        }
    }
    
    public func formatCurrency(f: String) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        return currencyFormatter.string(from: NSNumber(value: self.double()))!
    }
    
    /// Remove unwanted char and word from screener expression
    public func cleaned_s_e() -> String {
        let cleanDollar = self.replacingOccurrences(of: "[$]", with: "", options: .regularExpression, range: nil)
        
        let array = [" ", "k", "mil", "bil"]
        let string = cleanDollar

        var components = string.components(separatedBy: " ")
        components.removeAll{array.contains($0)}
        
        let result = components.joined(separator: " ")
        
        return result
    }
    
    public func intValue() -> Int {
        return Int(self) ?? 0
    }
}


extension UIDevice {
  public static var idiom: UIUserInterfaceIdiom {
    UIDevice.current.userInterfaceIdiom
  }
}

extension UIDevice {
  public static var isIpad: Bool {
    idiom == .pad
  }
  
  public static var isiPhone: Bool {
    idiom == .phone
  }
}
