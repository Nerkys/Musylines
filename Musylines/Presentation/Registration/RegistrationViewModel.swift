//
//  RegistrationViewModel.swift
//  Musylines
//
//  Created by Mikhail Chukhvantsev on 25.10.2021.
//

import Foundation
import Combine
import UIKit

class RegistrationViewModel {
    @Published var name: String = ""
    @Published var nameHint: String = ""
    @Published var surname: String = ""
    @Published var surnameHint: String = ""
    @Published var phoneNumber: String = ""
    @Published var phoneNumberHint: String = ""
    @Published var phoneNumberFormatted: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $name
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .flatMap { [unowned self] (name: String) -> AnyPublisher<String, Never> in
                self.validate(nameOrSurname: name)
            }
            .assign(to: \.nameHint, on: self)
            .store(in: &self.cancellableSet)
        
        $surname
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .flatMap { [unowned self] (surname: String) -> AnyPublisher<String, Never> in
                self.validate(nameOrSurname: surname)
            }
            .assign(to: \.surnameHint, on: self)
            .store(in: &self.cancellableSet)
        
        $phoneNumberFormatted
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .flatMap { [unowned self] (phoneNumber: String) -> AnyPublisher<String, Never> in
                self.validate(phoneNumber: phoneNumber)
            }
            .assign(to: \.phoneNumberHint, on: self)
            .store(in: &self.cancellableSet)
        
        $phoneNumber
            .flatMap { [unowned self] (phoneNumber: String) -> AnyPublisher<String, Never> in
                self.format(phoneNumber: phoneNumber)
            }
            .assign(to: \.phoneNumberFormatted, on: self)
            .store(in: &self.cancellableSet)
    }
    
    func validate(nameOrSurname: String) -> AnyPublisher<String, Never> {
        guard nameOrSurname.count >= 1 else {
            return Just(Strings.registrationScreen_nameAndSurnameRequirementsMinCharacters_label).eraseToAnyPublisher()
            
        }
        
        if nameOrSurname.matches(RegexPatterns.name) {
            return Just("").eraseToAnyPublisher()
        }

        return Just(Strings.registrationScreen_nameAndSurnameRequirementsLatinCharacters_label).eraseToAnyPublisher()
    }
    
    func validate(phoneNumber: String) -> AnyPublisher<String, Never> {
        let number = phoneNumber.filter(\.isWholeNumber)
        guard number.count == 11 && number.first == "7" else {
            return Just(Strings.registrationScreen_phoneNumberRequirements_label).eraseToAnyPublisher()
        }
        
        return Just("").eraseToAnyPublisher()
    }
    
    func format(phoneNumber: String) -> AnyPublisher<String, Never> {
        guard phoneNumber.count != 0 else {
            return Just("").eraseToAnyPublisher()
        }
        
        let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
        
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
        
        if number.count > 11 {
            let maxIndex = number.index(number.startIndex, offsetBy: 11)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count < 7 {
            let pattern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
        } else if number.count < 10 {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4", options: .regularExpression, range: regRange)
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
        }
        print(number)
        return Just("+\(number)").eraseToAnyPublisher()
    }
}
