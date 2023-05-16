//
//  HomeView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import Introspect
import LegacyScrollView

struct HomeView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @StateObject private var viewModel = HomeViewModel(recipeService: RecipeService())
    @State private var hidden: Bool = true
    
    let columns: [GridItem] = [
        GridItem(.flexible())
    ]
    
    let recipeCellHeight: CGFloat = 200
    let offsetY: CGFloat = 20
    
    var body: some View {
        VStack {
            header()
                .zIndex(200)
            
            HStack {
                RecipeFilterPicker(selection: $viewModel.filterType, activeTint: .mainColor, inActiveTint: .gray_bcbcbc, dynamic: false)
                    .frame(maxWidth: 130)
                
                Spacer()
            }
            .zIndex(100)
            .padding(.leading)
            .offset(y: viewModel.filterOffset)
            .padding(.bottom, viewModel.filterOffset)
            .opacity((20 + viewModel.filterOffset) * 0.2)
            
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
        .offset(y: -viewModel.filterOffset)
        .opacity((20 + viewModel.filterOffset) * 0.2)
    }
    
    @ViewBuilder
    private func homeRows() -> some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.recipeCells) {  cell in
                       Button {
                           navigateViewModel.navigateWithHome(cell)
                       } label: {
                           CellView(cell: cell)
                               .frame(height: recipeCellHeight)
                               .foregroundColor(.black)
                               .zIndex(0)
                       }
                       .id(cell.id)
                   }
                }
                .padding(.horizontal)
                .background {
                    ScrollDetector { offset, velocity in
                        withAnimation {
                            viewModel.filterOffset = velocity
                        }
                    }
                }
                
                Color.white.opacity(1)
                    .offsetY { viewModel.fetchTriggerOffset = $0 }
            }
            .onChange(of: viewModel.fetchTriggerOffset) { newValue in
                Task { await viewModel.fetchRecipeCell() }
            }
            .onChange(of: viewModel.filterType) { newValue in
                withAnimation {
                    proxy.scrollTo(viewModel.recipeCells[0].id)
                }
            }
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
