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
                    if viewModel.text.isEmpty {
                        field = .search
                    }
                }
            
            Group {
                
                SearchTypeList(searchTypes: SearchType.searchType(), viewModel: viewModel)
                    .padding(.horizontal)
                
                switch viewModel.seachType {
                case .recipe:
                    RecipeSearchView(query: viewModel.text)
                case .user:
                    UserSearchView(query: viewModel.text)
                case .cookie:
                    CookieSearchView(query: viewModel.text)
                        .padding(.horizontal)
                default:
                    EmptyView()
                }
            }	
            .presentIf(field == nil && !viewModel.text.isEmpty)

            
            Spacer()
        }
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button {
                    field = .search
                } label: {
                    Color.clear
                        .frame(width: 500)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCellView()
            .environmentObject(NavigateViewModel())
    }
}
