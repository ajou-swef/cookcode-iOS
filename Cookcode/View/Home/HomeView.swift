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
    
    var body: some View {
        VStack {
            header()
                .zIndex(200)
            
            HStack {
                RecipeFilterPicker(selection: $viewModel.filterType, filterOffset: $viewModel.filterOffset, activeTint: .mainColor,
                                   inActiveTint: .gray_bcbcbc, dynamic: false)
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
                    Color.white.opacity(1)
                        .offsetY(coordinateSpace: .named("homeScroll")) {
                            viewModel.resetTriggerOffset = $0
                        }
                        .padding(.vertical, -20)
                    
                    ForEach(viewModel.recipeCells) {  cell in
                       Button {
                           navigateViewModel.navigateWithHome(cell)
                       } label: {
                           CellView(cell: cell)
                               .foregroundColor(.black)
                               .zIndex(0)
                       }
                       .id(cell.id)
                   }
                    
                    
                    ProgressView()
                        .hidden(!viewModel.isLoadingState)
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
            .coordinateSpace(name: "homeScroll")
            .onChange(of: viewModel.fetchTriggerOffset) { newValue in
                Task { await viewModel.fetchRecipeCell() }
            }
            .onChange(of: viewModel.filterType) { newValue in
                withAnimation {
                    if !viewModel.recipeCells.isEmpty {                        proxy.scrollTo(viewModel.recipeCells[0].id)
                    }
                }
            }
            .overlay(alignment: .top) {
                Image(systemName: "arrow.clockwise")
                    .rotationEffect(.degrees(viewModel.resetArrowDegree))
                    .opacity(viewModel.resetArrowOpacity)
            }
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack(spacing: 15) {
            Image("cookcode.logo")
                .resizable()
                .frame(width: 40, height: 40)
            
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
