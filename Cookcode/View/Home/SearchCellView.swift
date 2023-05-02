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
    @StateObject private var viewModel: SearchCellViewModel = SearchCellViewModel(fetchCellService: RecipeSuccessService())
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    CellTypePicker(selection: $viewModel.searchType, activeTint: .mainColor, inActiveTint: .gray_bcbcbc, dynamic: false)
                        .frame(width: 100)
                    
                    Spacer()
                }
                .zIndex(1)
                
                LazyVGrid(columns: viewModel.columns, spacing: 15) {
                    ForEach(viewModel.cells.indices, id: \.self) { i in
                        let cell = viewModel.cells[i]
                        Button {
//                            navigateViewModel.navigateWithHome(cell)
                        } label: {
                            CellView(cell: cell)
                                .frame(height: viewModel.recipeCellHeight)
                        }
                    }
                }
                .zIndex(0)
            }
            .padding(.horizontal, 10)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                TextField("레시피 검색", text: $viewModel.text)
                    .frame(maxWidth: .infinity)
                    .onSubmit {
                        Task { await viewModel.fetchCell() }
                    }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCellView()
    }
}
