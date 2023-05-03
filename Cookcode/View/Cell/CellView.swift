//
//  RecipeCellView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/28.
//

import SwiftUI
import Kingfisher

struct CellView: View {
    
    let cell: any SearchedCell
    
    var body: some View {
        HStack {
            VStack {
                HStack(spacing: 5) {
                    Image(systemName: "pencil")
                        .foregroundColor(.primary)
                    
                    Text("\(cell.userName)")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .foregroundColor(.primary)
                }
            }
            .padding(.trailing, 40)
            
            Rectangle()
                .frame(width: 2)
                .padding(.trailing, 10)
                .foregroundColor(.primary)
            
            VStack(alignment: .center) {
                KFImage(URL(string: cell.thumbnail))
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(alignment: .bottomTrailing) {
                        Text(cell.title)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.trailing, 10)
                            .font(CustomFontFactory.INTER_SEMIBOLD_20)
                    }
            }
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(.primary)
        }
    }
}

struct RecipeCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
