//
//  HomeRecipeView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/07.
//

import SwiftUI
import Kingfisher
import HidableTabView

struct HomeRecipeView: View {
    
    @StateObject private var viewModel: HomeRecipeViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @EnvironmentObject var updateCellVM: UpdateCellViewModel
    @EnvironmentObject var cookieProgress: CookieProgress
    @EnvironmentObject var accountViewModel: AccountViewModel
    
    init(recipeService: RecipeServiceProtocol = RecipeService()) {
        self._viewModel = StateObject(wrappedValue: HomeRecipeViewModel(recipeService: recipeService))
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

            Group {
                HStack {
                    Text("쿠키 업로드")
                        .font(.custom(CustomFont.interRegular.rawValue, size: 11))
                    
                    Rectangle()
                        .foregroundColor(.gray_bcbcbc)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .overlay {
                            GeometryReader { proxy in
                                Rectangle()
                                    .foregroundColor(.mainColor)
                                    .frame(width: proxy.size.width * cookieProgress.progress.fractionCompleted,
                                           alignment: .trailing)
                            }
                        }
                }
                .presentIf(cookieProgress.isUploading)
                
                reuploadButton()

            }
            .padding(.horizontal)
       
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
            ViewAlert.cancelButton
        }
        .onAppear {
            viewModel.updateCell(updateCellVM.updateCellDict)
            updateCellVM.updateCellDict[.recipe] = nil
        }
    }
    
    @ViewBuilder
    private func reuploadButton() -> some View {
        Button {
            cookieProgress.reuploadAlertIsPresented = true
        } label: {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .resizable()
                    .frame(width: 13, height: 13)
                Text("업로드 실패")
                    .font(.custom(CustomFont.interRegular.rawValue, size: 13))
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .presentIf(cookieProgress.uploadingState == .fail)
        .alert("재업로드 하시겠습니까?", isPresented: $cookieProgress.reuploadAlertIsPresented) {
            Button("취소", role: .cancel) { }
            Button("확인") {
                cookieProgress.repostCookie()
            }
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
                .frame(width: 25, height: 25)
            
            Text("cookcode")
                .font(.custom(CustomFont.interBold.rawValue, size: 18))
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
                navigateViewModel.myAccountViewIsPresented = true
            } label: {
                if let url =  accountViewModel.user.thumbnail {
                    KFImage(URL(string: url))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                        .frame(width: 30)
                }
            }
            .fullScreenCover(isPresented: $navigateViewModel.myAccountViewIsPresented) {
                MyAccountView()
            }
        }
        .padding(.horizontal, 10)
    }
}

struct HomeRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRecipeView(recipeService: RecipeServiceSuccessStub())
            .environmentObject(NavigateViewModel())
            .environmentObject(UpdateCellViewModel())
            .environmentObject(CookieProgress(cookieService: CookieService()))
    }
}
