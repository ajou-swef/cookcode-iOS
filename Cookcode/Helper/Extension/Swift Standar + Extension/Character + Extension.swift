//
//  Character + Extension.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import Foundation

extension Character {
    func toASCII() -> Int {
        Int(self.unicodeScalars.first!.value)
    }
    
    var isAlphabet: Bool {
        let ascii = self.toASCII()
        
        if (ascii >= 65 && ascii <= 90) || (ascii >= 97 && ascii <= 122) {
            return true
        }
        
        return false
    }
    
    var isSpecialCharacter: Bool {
        let ascii = self.toASCII()
        
        if (ascii >= 33 && ascii <= 47) || (ascii >= 58 && ascii <= 64) ||
            (ascii >= 91 && ascii <= 96) || (ascii >= 123 && ascii <= 127) || ascii == 8361 {
            return true
        }
        
        return false
    }
    
    var isNumber: Bool {
        let ascii = self.toASCII()
        
        if ascii >= 48 && ascii <= 57 {
            return true
        }
        
        return false 
    }
}
