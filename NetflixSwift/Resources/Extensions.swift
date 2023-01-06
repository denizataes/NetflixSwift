//
//  Extensions.swift
//  NetflixSwift
//
//  Created by Deniz Ata Eş on 24.12.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
