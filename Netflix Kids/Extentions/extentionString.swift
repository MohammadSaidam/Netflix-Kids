//
//  extentionString.swift
//  Netflix Kids
//
//  Created by Mohammed Saidam on 14/09/2024.
//

import Foundation
import UIKit
/*
 This purpose of the this extention
 put the first letter capital in section Title to read easily
 */
extension String {
    func capitalizedFirstLetters()->String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
        
    }
}
