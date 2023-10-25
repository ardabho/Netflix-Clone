//
//  Extensions.swift
//  netflix
//
//  Created by ARDA BUYUKHATIPOGLU on 25.10.2023.
//

import Foundation

extension String {
    func capitalizedFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
