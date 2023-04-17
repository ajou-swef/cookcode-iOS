//
//  CustomFontFactory.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import SwiftUI

struct CustomFontFactory {
    static let INTER_REGULAR_12: Font = .custom(CustomFont.interRegular.rawValue, size: 12)
    static let INTER_SEMIBOLD_12: Font = .custom(CustomFont.interSemiBold.rawValue, size: 12)
    static let INTER_SEMIBOLD_20: Font = .custom(CustomFont.interSemiBold.rawValue, size: 20)
    static let INTER_TITLE: Font = .custom(CustomFont.interBold.rawValue, size: 30)
    static let INTER_SECTION_TITLE: Font = .custom(CustomFont.interBold.rawValue, size: 15)
}

enum CustomFont: String {
    case interRegular = "Inter-Regular"
    case interSemiBold = "Inter-SemiBold"
    case interBold = "Inter-Bold"
}
