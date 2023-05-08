//
//  ServiceDateFormatter.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/08.
//

import Foundation

struct ServiceDateFormatter {
    static func tranlsateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
        
    }
    
     static func translateToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.date(from: string)
        return newDate ?? .now
    }
}
