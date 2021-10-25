//
//  String+matches.swift
//  Musylines
//
//  Created by Mikhail Chukhvantsev on 25.10.2021.
//

import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
