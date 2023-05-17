//
//  StepCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import SwiftUI
import Kingfisher
import AVKit

struct StepCellView: View {
    
    let cell: StepDTO
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Image(systemName: "photo.fill")
                .resizable()
                .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fit)
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray_bcbcbc)
                .background {
                    Rectangle()
                        .foregroundColor(.gray_bcbcbc)
                        .overlay {
                            Rectangle()
                                .padding(.vertical, 30)
                                .foregroundColor(.white)
                        }
                }
                .hidden(!cell.photosIsEmpty)
            
            TabView {
                ForEach(cell.photos, id: \.self) { data in
                    KFImage(URL(string: data.photoURL))
                        .resizable()
                        .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fill)
                        .frame(maxWidth: .infinity)
                }
                
        
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            .tabViewStyle(.page(indexDisplayMode: .always))
            .hidden(cell.photosIsEmpty)
            
            Group {
                lackOfInformation()
                    .hidden(cell.containsAllRequiredInformation)
                
                stepInformation()
                    .hidden(!cell.containsAllRequiredInformation)
            }
            .padding(.horizontal, 10)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func lackOfInformation() -> some View {
        VStack(alignment: .leading) {
            Text("정보가 부족합니다.")
                .font(CustomFontFactory.INTER_SEMIBOLD_20)
                .foregroundColor(.mainColor)
            
            Text("제목, 내용, 컨텐츠를 모두 입력해주세요.")
                .font(CustomFontFactory.INTER_REGULAR_14)
                .foregroundColor(.mainColor)
        }
    }
    
    @ViewBuilder
    private func stepInformation() -> some View {
        VStack {
            Text("\(cell.title)")
                .font(CustomFontFactory.INTER_SEMIBOLD_20)
            
            Text("\(cell.description)")
                .font(CustomFontFactory.INTER_REGULAR_14)
        }
    }
}
//
//struct StepCell_Previews: PreviewProvider {
//    static var previews: some View {
//        StepCell()
//    }
//}
