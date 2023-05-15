//
//  HomeView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import Introspect

struct HomeView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @StateObject private var viewModel = HomeViewModel(recipeService: RecipeService())
    
    let columns: [GridItem] = [
        GridItem(.flexible())
    ]
    
    let recipeCellHeight: CGFloat = 200
    let offsetY: CGFloat = 20
    
    var body: some View {
        VStack {
            header()
            
            HStack {
                RecipeFilterPicker(selection: $viewModel.filterType, activeTint: .mainColor, inActiveTint: .gray_bcbcbc, dynamic: false)
                    .frame(maxWidth: 130)
                
                Spacer()
            }
            .zIndex(100)
            .padding(.leading)
            
            homeRows()
        }
        .overlay(alignment: .bottomTrailing) {
           presentRecipeFormViewButton()
        }
        .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
            ServiceAlert.CANCEL_BUTTON
        }
    }
    
    @ViewBuilder
    private func presentRecipeFormViewButton() -> some View {
        Button {
            navigateViewModel.navigateToOuter(OuterIdPath(path: .recipe, id: nil))
        } label: {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .roundedRectangle(.ORANGE_80_FILLE)
                .padding(.bottom, 10)
                .padding(.trailing, 15)
        }
    }
    
    @ViewBuilder
    private func homeRows() -> some View {
        List {
            ForEach(viewModel.recipeCells) {  cell in
               Button {
                   navigateViewModel.navigateWithHome(cell)
               } label: {
                   CellView(cell: cell)
                       .frame(height: recipeCellHeight)
                       .foregroundColor(.black)
                       .zIndex(0)
               }
           }
            
            Color.white.opacity(1)
                .offsetY { viewModel.fetchTriggerOffset = $0 }
        }
        .listStyle(.plain)
        .onChange(of: viewModel.fetchTriggerOffset) { newValue in
            Task { await viewModel.fetchRecipeCell() }
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack(spacing: 15) {
            Text("cookcode logo")
                .font(CustomFontFactory.INTER_BOLD_16)
            
            Spacer()
            
            Button {
                navigateViewModel.navigateWithHome(HomePath.search)
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 20, height: 20)
            }
            
            Button {
                navigateViewModel.navigateToOuter(OuterIdPath(path: .profile, id: nil))
            } label: {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 20, height: 20)
            }
        }
        .padding(.horizontal, 10)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
