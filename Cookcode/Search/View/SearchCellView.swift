//
//  SearchView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import SwiftUI
import Kingfisher

struct SearchCellView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @StateObject private var viewModel: SearchCellViewModel = SearchCellViewModel()
    @FocusState private var field: Field?
    
    enum Field: Hashable {
        case search
    }
    
    var body: some View {
        VStack {
            
            TextField("검색해 주세요.", text: $viewModel.text)
                .frame(maxWidth: .infinity)
                .focused($field, equals: .search)
                .onTapGesture {
                    field = .search
                }
                .offset(y: -33)
                .padding(.bottom, -33)
                .padding(.leading, 50)
                .onAppear {
                    field = .search
                }
            
            Group {
                
                SearchTypeList(searchTypes: SearchType.searchType(), viewModel: viewModel)
                
                switch viewModel.seachType {
                case .recipe:
                    TempRecipeView(query: viewModel.text)
                default:
                    EmptyView()
                }
            }
            .padding(.horizontal)
            .presentIf(field == nil && !viewModel.text.isEmpty)

            
            Spacer()
            
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCellView()
            .environmentObject(NavigateViewModel())
    }
}
