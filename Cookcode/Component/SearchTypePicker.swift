//
//  DropDownPicker.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import SwiftUI

struct SearchTypePicker: View {
    
    @State private var expandView: Bool = false
    @Binding var selection: SearchType
    
    var content: [SearchType] = SearchType.allCases
    var activeTint: Color
    var inActiveTint: Color
    var dynamic: Bool = true
    
    let height: CGFloat = 40
    
    var contentHeight: CGFloat {
        expandView ? CGFloat(content.count) * height : height
    }
    
    var dropDownOffsetY: CGFloat {
        dynamic ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -height) : 0
    }
    
    var maskOffsetY: CGFloat {
        dynamic && expandView ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -height) : 0
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                if !dynamic {
                    RowView(selection, size)
                }
                ForEach(content.filter {
                    dynamic ? true : $0 != selection
                }, id: \.self) { title in
                    RowView(title, size)
                }
            }
            .background {
                Rectangle()
                    .fill(inActiveTint)
            }
            .offset(y: dropDownOffsetY)
        }
        .frame(height: height)
        .overlay(alignment: .trailing) {
            Image(systemName: "chevron.up.chevron.down")
                .foregroundColor(.white)
                .padding(.trailing, 10)
        }
        .mask(alignment: .top) {
            Rectangle()
                .frame(height: contentHeight)
                .offset(y: maskOffsetY)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    @ViewBuilder
    func RowView(_ searchType: SearchType, _ size: CGSize) -> some View {
        Text(searchType.rawValue)
            .foregroundColor(.white)
            .font(CustomFontFactory.INTER_SEMIBOLD_14)
            .padding(.horizontal)
            .frame(width: size.width, height: size.height, alignment: .leading)
            .background(content: {
                if selection == searchType {
                    Rectangle()
                        .fill(activeTint)
                        .transition(.identity)
                }
            })
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(
                    .interactiveSpring(response: 0.6,
                                       dampingFraction: 0.7,
                                       blendDuration: 0.7)) {
                   if expandView {
                       expandView = false
                       if dynamic {
                           selection = searchType
                       } else {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                               selection = searchType
                           }
                       }
                   } else {
                       if selection == searchType {
                           expandView = true
                       }
                   }
                }
            }
    }
}
