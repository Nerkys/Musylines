//
//  Localizable.swift
//  Musylines
//
//  Created by Mikhail Chukhvantsev on 23.10.2021.
//

import UIKit

@propertyWrapper
struct Localizable {
   var wrappedValue: String {
       didSet { wrappedValue = NSLocalizedString(wrappedValue, comment: "") }
   }

   init(wrappedValue: String) {
       self.wrappedValue = NSLocalizedString(wrappedValue, comment: "")
   }
}

enum Strings {
    @Localizable static var musylines = "musylines"
    @Localizable static var registrationScreen_passwordRequirements_label = "registrationScreen_passwordRequirements_label"
    @Localizable static var registrationScreen_nameAndSurnameRequirementsMinCharacters_label = "registrationScreen_nameAndSurnameRequirementsMinCharacters_label"
    @Localizable static var registrationScreen_nameAndSurnameRequirementsLatinCharacters_label = "registrationScreen_nameAndSurnameRequirementsLatinCharacters_label"
    @Localizable static var registrationScreen_phoneNumberRequirements_label = "registrationScreen_phoneNumberRequirements_label"
}

final class UILocalizedLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        @Localizable var value = text!
        text = value
    }
}

final class UILocalizedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        @Localizable var value = self.title(for: .normal)!
        setTitle(value, for: .normal)
    }
}

final class UILocalizedTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        @Localizable var value = placeholder!
        placeholder = value
    }
}
