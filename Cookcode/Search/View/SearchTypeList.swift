//
//  SearchTypeList.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI

struct SearchTypeList<ViewModel: SearchTypeSelectable>: View {
    
    let searchTypes: [SearchType]
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            ForEach(searchTypes, id: \.rawValue) { type in
                SearchTypeComponent(searchType: type, viewModel: viewModel)
                    .font(.custom(CustomFont.interSemiBold.rawValue, size: 16))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(viewModel.seachType == type ? .mainColor : .primary)
                    .padding(.bottom, 5)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.mainColor)
                            .presentIf(viewModel.seachType == type)
                    }
            }
        }
    }
}

//struct SearchTypeList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchTypeList(searchTypes: <#[SearchType]#>, viewModel: <#_#>)
//    }
//}
