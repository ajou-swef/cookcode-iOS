//
//  CustomFontFactory.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import SwiftUI

struct CustomFontFactory {
    static let INTER_REGULAR_14: Font = .custom(CustomFont.interRegular.rawValue, size: 14)
    static let INTER_SEMIBOLD_14: Font = .custom(CustomFont.interSemiBold.rawValue, size: 14)
    static let INTER_SEMIBOLD_20: Font = .custom(CustomFont.interSemiBold.rawValue, size: 20)
    static let INTER_BOLD_30: Font = .custom(CustomFont.interBold.rawValue, size: 30)
    static let INTER_BOLD_16: Font = .custom(CustomFont.interBold.rawValue, size: 16)
}

extension Font {
    static let TEST_FONT: Font = .custom(CustomFont.interRegular.rawValue, size: 14)
}

enum CustomFont: String {
    case interRegular = "Inter-Regular"
    case interSemiBold = "Inter-SemiBold"
    case interBold = "Inter-Bold"
}
