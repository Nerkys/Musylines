//
//  LabelExt.swift
//  Musylines
//
//  Created by Mikhail Chukhvantsev on 24.10.2021.
//

import UIKit

extension UILabel {
    func configureMusylinesLabelShadows() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
