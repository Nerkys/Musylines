//
//  RegexPatterns.swift
//  Musylines
//
//  Created by Mikhail Chukhvantsev on 25.10.2021.
//

enum RegexPatterns {
    static let name = "^[a-zA-Z]{1,}$"
    static let phoneNumber = "^[\\+\\s-\\(\\)]{11,11}$"
}
