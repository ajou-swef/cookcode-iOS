//
//  String + Extension.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/24.
//

import Foundation

extension String {
    static func createRandomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String(
            (0..<length)
                .map { _ in letters.randomElement()! }
        )
    }
}

extension String: Mock {
    static func mock() -> String {
        "mock string"
    }
}
