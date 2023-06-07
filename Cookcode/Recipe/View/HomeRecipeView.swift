//
//  HomeRecipeView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/07.
//

import SwiftUI

struct HomeRecipeView: View {
    
    @StateObject private var viewModel: HomeReicpeViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @EnvironmentObject var updateCellVM: UpdateCellViewModel
    
    init(recipeService: RecipeServiceProtocol = RecipeService()) {
        self._viewModel = StateObject(wrappedValue: HomeReicpeViewModel(recipeService: recipeService))
    }
    var body: some View {
        VStack {
            header()
                .padding(.horizontal)
                .offset(y: viewModel.topOffset)
                .padding(.bottom, viewModel.topOffset)
                .opacity(viewModel.topOpacity)
                .animation(.spring(), value: viewModel.topOpacity)
                .animation(.spring(), value: viewModel.topOffset)
            
            RefreshableRecipeFetchView(viewModel: viewModel)
        }
        .disabled(viewModel.contentTypeButtonIsShowing)
        .overlay {
            Color.gray_bcbcbc.opacity(0.5)
                .ignoresSafeArea(.all)
                .presentIf(viewModel.contentTypeButtonIsShowing)
        }
        .overlay(alignment: .bottomTrailing) {
           bottomButton()
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
    private func bottomButton() -> some View {
        VStack(alignment: .trailing, spacing: 0) {
            Group {
                presentRecipeFormViewButton()
                presentCookieViewButton()
            }
            .presentIf(viewModel.contentTypeButtonIsShowing)
            
            createContentButton()
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
    private func header() -> some View {
        HStack(spacing: 15) {
            Image("cookcode.logo")
                .resizable()
                .frame(width: 40, height: 40)
            
            Text("cookcode")
                .font(.custom(CustomFont.interBold.rawValue, size: 16))
                .foregroundColor(.mainColor)
            
            Spacer()
            
            Button {
                let homeIdPath = HomeIdPath(path: .search, id: nil)
                navigateViewModel.navigateWithHome(homeIdPath)
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 22, height: 22)
            }
            
            Button {
                viewModel.myAccountViewIsPresented = true
            } label: {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 22, height: 22)
            }
            .fullScreenCover(isPresented: $viewModel.myAccountViewIsPresented) {
                MyAccountView()
            }
        }
        .padding(.horizontal, 10)
    }
}

struct HomeRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRecipeView(recipeService: RecipeSuccessService())
            .environmentObject(NavigateViewModel())
            .environmentObject(UpdateCellViewModel())
    }
}
