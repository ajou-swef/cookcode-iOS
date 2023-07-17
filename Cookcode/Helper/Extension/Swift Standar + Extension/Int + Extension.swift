//
//  Int + Extension.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/10.
//

import Foundation
import cookcode_service

extension Int: Mock {
    public static func mock() -> Int {
        1
    }
}
