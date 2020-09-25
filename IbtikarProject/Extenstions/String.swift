//
//  String.swift
//  zVendo
//
//  Created by Ahmad Ismail on 12/26/18.
//  Copyright © 2018 Business Boomers. All rights reserved.
//

import Foundation
import UIKit


extension String {
    
    
    var formattedDateString: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = inputFormatter.date(from: self) else { return self }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd - MMM - yyyy \n HH:mm a"
        return outputFormatter.string(from: date)
    } // formattedDateString
    
    //===============
    //MARK: Time Date
    //===============
    var timeDate: Date? {
        let inputTimeFormatter = DateFormatter()
        inputTimeFormatter.dateFormat = "HH:mm:ss"
        return inputTimeFormatter.date(from: self)
    } // timeDate
    
    //===================
    //MARK: Delete Spaces
    //===================
    var withoutSpaces: String {
        return self.replacingOccurrences(of: " ", with: "")
    }// withoutSpaces
    
    //===========================
    //MARK: Is Valid Phone Number
    //===========================
    func isValidPhoneNumber() -> Bool {
        let phoneRegEx = "^((\\+)|(0))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    } // isValidPhoneNumber
    
    //===========================
    //MARK: Hex String to UIColor
    //===========================
    func hexStringToUIColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        guard (cString.count) == 6 else {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    } // hexStringToUIColor
    
}// String

//************************
//MARK:- String Validation
//************************

let maxTextField = 50
let maxAge = 2
let maxPhoneNumber = 15
let minPassword = 8
let maxPassword = 25
let minUsername = 2
let minName = 2
let maxUsername = 40

extension String {
    //=======================================
    // MARK: Specific Entry types validation
    //=======================================
    
    var isValidName: Bool {
        let trimmedString = self.withoutWhitespaces
        if trimmedString.count > 2 { // to have an name with min 3 characters
            let stringSet = CharacterSet(charactersIn: trimmedString)
            var letters = CharacterSet.letters
            letters.insert(charactersIn: "-'@^%$()!#.")
            return letters.isSuperset(of: stringSet)
        }
        return false
    } // isValidName
    
    var isValidUsername: Bool {
        let usernameRegex = "^[A-Za-z0-9]+(?:[._-][A-Za-z0-9]+)*$"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernameTest.evaluate(with: self) && self.count >= minUsername
    }// isValidUsername
    
    var isValidPassword: Bool {
        //        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*[#?!@$%^&*-])[A-Za-z0-9#?!@$%^&*-_.]{\(MinPassword),}$"
        let passwordRegex = "^[A-Za-z0-9#?!@$%^&*-_.]{\(6),}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    } // isValidPassword
    
    var isValidEmailAddress: Bool {
        let regex = "([\\w-+]+(?:\\.[\\w-+]+)*@(?:[\\w-]+\\.)+[a-zA-Z]{2,7})"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regex)
        if emailTest.evaluate(with: self) {
            let name = self.components(separatedBy: "@").first!
            let domain = self.components(separatedBy: "@").last!.components(separatedBy: ".").first!
            return name.isValidUsername && domain.containsAtLeastOneLetter
        }
        return false
    } // isValidEmailAddress
    
    var isValidMobileNumber: Bool {
//        let mobileNumberRegex = "^[0][1-9]\\d{9}$|^[1-9]\\d{9}"
        if self.isEmpty { return false }
        
        let mobileNumberRegex = "^|[0-9]{7}|[0-9]{8}[0-9]{9}|[0-9]{10}|[0-9]{11}|[0-9]{12}|[0-9]{13}|[0-9]{14}|[0-9]{15}"

        let mobileNumberTest = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        return mobileNumberTest.evaluate(with: self.withWesternNumbers)
    } // isValidMobileNumber
    
    var isValidAge: Bool {
        return self.isNumeric && (Int(self) != nil) && (Int(self)! > 0)
    } // isValidAge
    
    //=======================================
    //MARK: Specific Restrictions validation
    //=======================================
    
    var startsWithArabicCharacter: Bool {
        if let lang = CFStringTokenizerCopyBestStringLanguage(self as CFString, CFRange(location: 0, length: self.count)) {
            let direction = Locale.characterDirection(forLanguage: lang as String)
            return direction == .rightToLeft
        }
        return false
    } // startsWithArabicCharacter
    
    var hasLeadingWhiteSpaces: Bool {
        return self.replacingOccurrences(of: "^\\s+", with: "", options: .regularExpression).count < self.count
    } // hasLeadingWhiteSpaces
    
    var containsAtLeastOneLetter: Bool {
        let alphaNumericRegex = ".*[a-zA-Z]+.*"
        let alphaNumericTest = NSPredicate(format: "SELF MATCHES %@", alphaNumericRegex)
        return alphaNumericTest.evaluate(with: self)
    } // containsAtLeastOneLetter
    
    var isNumeric: Bool {
        let trimmedString = self.withoutWhitespaces
        if trimmedString.count > 1 {
            let stringSet = CharacterSet(charactersIn: self.withWesternNumbers)
            return CharacterSet.decimalDigits.isSuperset(of: stringSet)
        }
        return false
    } // isNumeric
    
    var isAlphaNumeric: Bool {
        let alphaNumericRegex = "^[a-zA-Z0-9]*$"
        let alphaNumericTest = NSPredicate(format: "SELF MATCHES %@", alphaNumericRegex)
        return alphaNumericTest.evaluate(with: self)
    } // isAlphaNumeric
    
    var withWesternNumbers: String {
        var string = self
        let arabic = "٠١٢٣٤٥٦٧٨٩"
        let western = "0123456789"
        for index in 0..<arabic.count {
            let arabicCharacter = arabic[arabic.index(arabic.startIndex, offsetBy: index)]
            let westernCharacter = western[western.index(western.startIndex, offsetBy: index)]
            string = string.replacingOccurrences(of: "\(arabicCharacter)", with: "\(westernCharacter)")
        }
        return string
    } // withWesternNumbers
    
    var withArabicNumbers: String {
        var string = self
        let arabic = "٠١٢٣٤٥٦٧٨٩"
        let western = "0123456789"
        for index in 0..<arabic.count {
            let arabicCharacter = arabic[arabic.index(arabic.startIndex, offsetBy: index)]
            let westernCharacter = western[western.index(western.startIndex, offsetBy: index)]
            string = string.replacingOccurrences(of: "\(westernCharacter)", with: "\(arabicCharacter)")
        }
        return string
    } // withArabicNumbers
    
    var hasArabicCharacters: Bool {
        let alphaNumericRegex = "[\\u0600-\\u06ff]|[\\u0750-\\u077f]|[\\ufb50-\\ufc3f]|[\\ufe70-\\ufefc]"
        let alphaNumericTest = NSPredicate(format: "SELF MATCHES %@", alphaNumericRegex)
        return alphaNumericTest.evaluate(with: self)
    } // hasArabicCharacters
    
    var withoutNumbers: String {
        let words = self.components(separatedBy: CharacterSet.decimalDigits)
        let trimmedString = words.joined()
        return trimmedString
    } // withoutNumbers
    
    var withoutWhitespaces: String {
        let words = self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        let trimmedString = words.joined()
        return trimmedString
    } // withoutWhitespaces
    
    var withoutSpecialCharacters: String {
        var alphaNumericCharacters = CharacterSet.alphanumerics
        alphaNumericCharacters.formUnion(CharacterSet.whitespacesAndNewlines)
        let symbolCharacters = alphaNumericCharacters.inverted
        let words = self.components(separatedBy: symbolCharacters)
        let trimmedString = words.joined()
        return trimmedString
    } // withoutSpecialCharacters
    
    var hasAtLeastOneLetter: Bool {
        return !self.components(separatedBy: CharacterSet.letters.inverted).joined().isEmpty
    } // hasAtLeastOneLetter
    
    func hasNumberOfLetters(_ count: Int) -> Bool {
        return self.components(separatedBy: CharacterSet.letters.inverted).count == count
    } // hasNumberOfLetters
    
    func removingOccurrences(of stringToRemove: String) -> String {
        return self.replacingOccurrences(of: stringToRemove, with: "")
    } // removingOccurrences
    
    var detectDate: Date? {
        return (try? NSDataDetector(types: NSTextCheckingAllTypes))?.firstMatch(in: self, range: NSRange(0..<count))?.date
    } // detectDate
    
    var detectURL: URL? {
        return (try? NSDataDetector(types: NSTextCheckingAllTypes))?.firstMatch(in: self, range: NSRange(0..<count))?.url
    } // detectURL
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont?) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font ?? .systemFont(ofSize: 14)], context: nil)
        return ceil(boundingBox.width)
    }// width
    
    func height(withConstraintedWidth width: CGFloat, font: UIFont?) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font ?? .systemFont(ofSize: 14)], context: nil)
        return ceil(boundingBox.height)
    } // height
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    } // trimmed
} // extension String

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> SubSequence {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start...end]
    }
    
    subscript (bounds: CountableRange<Int>) -> SubSequence {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start..<end]
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    
    func replacedArabicDaysWithEnglish() -> String {
        var str = self
        let map = [
            "السبت" : "Saturday",
            "الاحد" : "Sunday",
            "الاتنين" : "Monday",
            "الثلاثاء" : "Tuesday",
            "الاربعاء": "Wednesday",
            "الخميس": "Thursday",
            "الجمعه": "Friday"
        ]
        
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    func oldPriceStrikeThrough() -> NSAttributedString {
          let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
          return attributeString
      }
    
   
    
    
} // extension String

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
       var html2AttributedString: NSAttributedString? {
           Data(utf8).html2AttributedString
       }
       var html2String: String {
           html2AttributedString?.string ?? ""
       }
   }
