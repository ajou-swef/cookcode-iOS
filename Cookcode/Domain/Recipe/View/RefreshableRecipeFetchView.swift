//
//  RefreshableRecipeFetchView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/07.
//

import SwiftUI

struct RefreshableRecipeFetchView<ViewModel: RefreshableRecipeFetcher>: View {
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel

    
    var body: some View {
        VStack {
            header()
            
            RefreshComponent(viewModel: viewModel) {
                PagenableComponent(viewModel: viewModel) {
                    ForEach(viewModel.contents) { recipeCell in
                       Button {
                           let homeIdPath = HomeIdPath(path: .recipe, id: recipeCell.recipeId)
                           navigateViewModel.navigateWithHome(homeIdPath)
                       } label: {
                           RecipeCellView(cell: recipeCell)
                               .foregroundColor(.black)
                       }
                       .id(recipeCell.id)
                       .padding(.bottom, 15)
                        
                   }
                    .padding(.horizontal)
                }
            }
            .zIndex(0)
            .onChange(of: viewModel.sort) { newValue in
                Task { await viewModel.onRefresh() }
            }
        }
        .navigationTitle("")
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack {
            
            SortTypePicker(selection: $viewModel.sort, activeTint: .mainColor,
                           inActiveTint: .gray_bcbcbc, dynamic: false)
            .frame(width: 120)
            .onChange(of: viewModel.searchType) { newValue in
                Task { await viewModel.onRefresh() }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    SearcgMembershipPicker(searchMembership: $viewModel.searchType)
                }
                .zIndex(200)
            }
            .coordinateSpace(name: "hscroll")
            .zIndex(200)
            
            Button {
                viewModel.presentOnlyCookable.toggle()
            } label: {
                Image(systemName: viewModel.presentOnlyCookable ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .onChange(of: viewModel.dragVelocity, perform: { newValue in
                if newValue >= 0 {
                    viewModel.topOffset = -100
                } else {
                    viewModel.topOffset = 0
                }
            })
            .onChange(of: viewModel.presentOnlyCookable) { newValue in
                Task {
//                        proxy.scrollTo(viewModel.firstCellID)
                    await viewModel.onRefresh()
                }
            }
            
            Text("요리하자")
                .font(.custom(CustomFont.interRegular.rawValue, size: 16))
        }
        .zIndex(100)
        .foregroundColor(.mainColor)
        .offset(y: viewModel.topOffset)
        .padding(.bottom, viewModel.topOffset)
        .opacity(viewModel.topOpacity)
        .padding(.horizontal)
        .animation(.spring(), value: viewModel.topOpacity)
        .animation(.spring(), value: viewModel.topOffset)
    }
}

struct RefreshableRecipeFetchView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableRecipeFetchView(viewModel: HomeRecipeViewModel(recipeService: RecipeServiceSuccessStub()))
            .environmentObject(NavigateViewModel())
    }
}
