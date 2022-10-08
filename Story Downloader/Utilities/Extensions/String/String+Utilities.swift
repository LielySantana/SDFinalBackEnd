//
//  String+Utilities.swift
//  HealthTotal
//
//  Created by Office on 23/05/16.
//  Copyright © 2016 Collabroo. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
extension String {
    
    func localized() -> String {

//            let selectedLangCode = kSharedUserDefaults.getLanguage()
//            if let path = Bundle.main.path(forResource: selectedLangCode, ofType: "lproj"),
//                let bundle = Bundle.init(path: path) {
//                return bundle.localizedString(forKey: self, value: nil, table: nil)
//            } else {
//                return self
//            }
        return "" // remove this line
        }

    
    // To Check Whether Email is valid
    func isEmail() -> Bool {
        let emailRegex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,4})$" as String
        let emailText = NSPredicate(format: "SELF MATCHES %@",emailRegex)
        let isValid  = emailText.evaluate(with: self) as Bool
        return isValid
    }
    

    
    func isValidUserName() -> Bool{
        let RegEx = "^[a-z A-Z]$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: self)
    }
    
    func isBackSpace()->Bool {
        if let char = self.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            return isBackSpace == -92
        }
        return true
    }
    
    // To Check Whether Email is valid
    func isValidString() -> Bool {
        if self == "<null>" || self == "(null)" {
            return false
        }
        return true
    }
    
    func isValidPassword(text: String) -> Bool {
        
        let letters = CharacterSet.letters
        
        let phrase = text
        let range = phrase.rangeOfCharacter(from: letters)
        
        // range will be nil if no letters is found
        if range != nil {
            return false
        }
        else {
            return true
        }
    }
    
    // To Check Whether Phone Number is valid
    
    func isPhoneNumber() -> Bool {
        if self.isStringEmpty() {
            return false
        }
        let phoneRegex = "^\\d{6,15}$"
        let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValid = phoneText.evaluate(with: self) as Bool
        return isValid
    }
    
    var isNumeric: Bool {
            guard self.count > 0 else { return false }
            let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            return Set(self).isSubset(of: nums)
        }
    
    func isNumber() -> Bool {
        if self.isStringEmpty() {
            return false
        }
        let phoneRegex = "^\\d$"
        let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValid = phoneText.evaluate(with: self) as Bool
        return isValid
    }
    // Password_Validation
    
    func isValidPassword() -> Bool {
                let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,15}")
                return passwordTest.evaluate(with: self)
            }
    
    
    func isPasswordValidate() -> Bool {
        let passwordRegix = "[A-Za-z0-9.@#$%*?:!+-/]{8,25}"
        let passwordText  = NSPredicate(format:"SELF MATCHES %@",passwordRegix)
        
        return passwordText.evaluate(with:self)
    }
    
    
    // To Check Whether URL is valid
    
    func isURL() -> Bool {
        let urlRegex = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+" as String
        let urlText = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        let isValid = urlText.evaluate(with: self) as Bool
        return isValid
    }
    
    // To Check Whether Image URL is valid
    
    func isImageURL() -> Bool {
        if self.isURL() {
            if self.range(of: ".png") != nil || self.range(of: ".jpg") != nil || self.range(of: ".jpeg") != nil {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func toInt() -> Int
    {
        return Int(self) ?? 0
    }
    
    func trimAll()->String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    static func getString(_ message: Any?) -> String {
        guard let strMessage = message as? String else {
            guard let doubleValue = message as? Double else {
                guard let intValue = message as? Int else {
                    guard let int64Value = message as? Int64 else{
                        return ""
                    }
                    return String(int64Value)
                }
                return String(intValue)
            }
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 20
            formatter.minimumIntegerDigits = 1
            guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else {
                return ""
            }
            return formattedNumber
        }
        return strMessage.stringByTrimmingWhiteSpaceAndNewLine()
    }
    
    static func getLength(_ message: Any?) -> Int {
        return String.getString(message).stringByTrimmingWhiteSpaceAndNewLine().count
    }
    
    static func checkForValidNumericString(_ message: AnyObject?) -> Bool {
        guard let strMessage = message as? String else {
            return true
        }
        
        if strMessage == "" || strMessage == "0" {
            return true
        }
        return false
    }
    
    
    // To Check Whether String is empty
    
    func isStringEmpty() -> Bool {
        return self.stringByTrimmingWhiteSpace().count == 0 ? true : false
    }
    
    mutating func removeSubString(subString: String) -> String {
        if self.contains(subString) {
            guard let stringRange = self.range(of: subString) else { return self }
            return self.replacingCharacters(in: stringRange, with: "")
        }
        return self
    }
    
    // Get string by removing White Space & New Line
    
    func stringByTrimmingWhiteSpaceAndNewLine() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    // Get string by removing White Space
    
    func stringByTrimmingWhiteSpace() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func getSubStringFrom(begin: NSInteger, to end: NSInteger) -> String {
        // var strRange = begin..<end
        // let str = self.substringWithRange(strRange)
        return ""
    }
}


protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}
//protocol Localizable {
//    var localized: String { get }
//}
//extension String: Localizable {
//    var localized: String {
//        return NSLocalizedString(self, comment: "")
//    }
//}
extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized()
        }
    }
}
extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized(), for: .normal)
        }
   }
}

public protocol UITextFieldXIBLocalizable {
    var xibPlaceholderLocKey: String? { get set }
}

extension UITextField: UITextFieldXIBLocalizable {
    @IBInspectable public var xibPlaceholderLocKey: String? {
        get { return nil }
        set(key) {
            self.placeholder = key?.localized()
            let lang = kSharedUserDefaults.getLanguage()
            if lang  == "ar"{
                self.textAlignment = .right
            }else{
                self.textAlignment = .left
            }
        }
    }
}


public protocol UITextViewXIBLocalizable {
    var xibPlaceholderLocKey: String? { get set }
}

extension IQTextView: UITextViewXIBLocalizable {
    @IBInspectable public var xibPlaceholderLocKey: String? {
        get { return nil }
        set(key) {
            self.placeholder = key?.localized()
            let lang = kSharedUserDefaults.getLanguage()
            if lang  == "ar"{
                self.textAlignment = .right
            }else{
                self.textAlignment = .left
            }
        }
    }
}




extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
