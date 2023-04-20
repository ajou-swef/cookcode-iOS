//
//  RoundedRectangleModifier.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func roundedRectangle(_ selection: RoundedRectangleModifier, alignment: Alignment = .center, focused: Bool = false ) -> some View {
        switch selection {
        case .ORANGE_280_FILLED:
            self
                .frame(minWidth: 280, maxWidth: 280, minHeight: 50, alignment: alignment)
                .foregroundColor(.mainColor)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.mainColor)
                }
        case .ORANGE_320_FILLED:
            self
                .frame(minWidth: 320, minHeight: 50, alignment: alignment)
                .foregroundColor(.mainColor)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.mainColor)
                }
        case .GRAY_320_STROKE:
            self
                .frame(minWidth: 320, maxWidth: 320, minHeight: 50, alignment: alignment)
                .foregroundColor(focused ? .mainColor : .gray808080)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .fill(focused ? Color.mainColor : Color.gray808080)
                }
            
        case .GRAY_280_STROKE:
            self
                .frame(minWidth: 280, minHeight: 50, alignment: alignment)
                .foregroundColor(.gray808080)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .fill(Color.gray808080)
                }
        case .ORANGE_320_STROKE:
            self
                .frame(minWidth: 320, minHeight: 50, alignment: alignment)
                .foregroundColor(.mainColor)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .fill(Color.mainColor)
                }
        case .GRAY_320_FILLED:
            self
                .frame(minWidth: 320, minHeight: 50, alignment: alignment)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray808080)
                }
                
        case .ORANGE_80_FILLE:
            self
                .frame(minWidth: 80, maxWidth: 80, minHeight: 40, alignment: alignment)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.mainColor)
                }
        }
    }
}

enum RoundedRectangleModifier {
    case ORANGE_280_FILLED
    case ORANGE_320_FILLED
    case GRAY_320_STROKE
    case GRAY_280_STROKE
    case ORANGE_320_STROKE
    case GRAY_320_FILLED
    case ORANGE_80_FILLE
}
