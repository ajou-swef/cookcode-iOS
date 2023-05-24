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
    
    @StateObject private var viewModel = HomeViewModel(recipeService: RecipeService())
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @EnvironmentObject var updateCellVM: UpdateCellViewModel
    
    var body: some View {
        VStack {
            header()
                .zIndex(200)
            
            HStack {
                RecipeFilterPicker(selection: $viewModel.filterType, filterOffset: $viewModel.dragVelocity,
                                   activeTint: .mainColor, inActiveTint: .gray_bcbcbc, dynamic: false)
                    .frame(maxWidth: 130)
                
                
                Spacer()
            }
            .zIndex(100)
            .padding(.leading)
            .offset(y: viewModel.filterOffset)
            .padding(.bottom, viewModel.filterOffset)
            .opacity(viewModel.filterOpacity)
            
            homeRows()
        }
        .disabled(viewModel.contentTypeButtonIsShowing)
        .overlay {
            Color.gray_bcbcbc.opacity(0.5)
                .ignoresSafeArea(.all)
                .hidden(!viewModel.contentTypeButtonIsShowing)
        }
        .overlay(alignment: .bottomTrailing) {
            VStack(alignment: .trailing, spacing: 0) {
                Group {
                    presentRecipeFormViewButton()
                    presentCookieViewButton()
                }
                .hidden(!viewModel.contentTypeButtonIsShowing)
                
                createContentButton()
            }
        }
        .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
            ServiceAlert.CANCEL_BUTTON
        }
        .onAppear {
            viewModel.updateCell(updateCellVM.updateCellDict)
            updateCellVM.updateCellDict[.recipe] = nil 
        }
    }
    
    @ViewBuilder
    private func createContentButton() -> some View {
        Button {
            viewModel.createContentButtonTapped()
        } label: {
            Group {
                if viewModel.contentTypeButtonIsShowing {
                    Image(systemName: "xmark")
                        .frame(width: 40, height: 40)
                        .background {
                            Circle().foregroundColor(.mainColor)
                        }
                } else {
                    Image(systemName: "plus")
                        .roundedRectangle(.ORANGE_80_FILLE)
                }
            }
            .foregroundColor(.white)
            .animation(.spring(), value: viewModel.contentTypeButtonIsShowing)
            .padding(.bottom, 10)
            .padding(.trailing, 15)
        }

    }
    
    @ViewBuilder
    private func presentCookieViewButton() -> some View {
        Button {
            navigateViewModel.navigateToOuter(OuterIdPath(path: .cookie, id: nil))
        } label: {
            Text("쿠키")
                .foregroundColor(.white)
                .roundedRectangle(.ORANGE_80_FILLE)
                .padding(.bottom, 10)
                .padding(.trailing, 15)
        }
        .offset(y: -viewModel.dragVelocity)
        .opacity((20 + viewModel.dragVelocity) * 0.2)
    }
    
    @ViewBuilder
    private func presentRecipeFormViewButton() -> some View {
        Button {
            navigateViewModel.navigateToOuter(OuterIdPath(path: .recipe, id: nil))
        } label: {
            Text("레시피")
                .foregroundColor(.white)
                .roundedRectangle(.ORANGE_80_FILLE)
                .padding(.bottom, 10)
                .padding(.trailing, 15)
        }
        .offset(y: -viewModel.dragVelocity)
        .opacity((20 + viewModel.dragVelocity) * 0.2)
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
                            viewModel.dragVelocity = velocity
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
