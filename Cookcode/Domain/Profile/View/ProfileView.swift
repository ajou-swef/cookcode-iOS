//
//  ProfileView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @StateObject private var viewModel: ProfileViewModel
    @EnvironmentObject var accountVM: AccountViewModel
    
    init(accountService: AccountServiceProtocol = AccountService(), userId: Int) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(accoutnService: accountService,
                                                                     userId: userId))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                userProfile()
                
                HStack(spacing: 0) {
                    subscribeButton()
                    unsubscribeButton()
                    presentMembshipGradeButton()
                }
                contentSelectButton()
                contentView()
            }
        }
        .navigationTitle(viewModel.userDetail.nickname)
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        switch viewModel.seachType {
        case .recipe:
            RecipeUserView(userId: viewModel.userId)
                .padding(.horizontal)
        case .user:
            EmptyView()
        case .cookie:
            CookieUserView(userId: viewModel.userId)
                .padding(.horizontal)
        case .publisher:
            MyPublishersView()
        }
    }
    
    @ViewBuilder
    private func contentSelectButton() -> some View {
        HStack {
            ForEach(SearchType.profileSearchType(), id: \.rawValue) { type in
                SearchTypeComponent(searchType: type, viewModel: viewModel)
                    .font(.custom(CustomFont.interSemiBold.rawValue, size: 16))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(viewModel.seachType == type ? .mainColor : .primary)
                    .padding(.bottom, 5)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.mainColor)
                            .presentIf(viewModel.seachType == type)
                    }
            }
        }
    }
    
    @ViewBuilder
    private func userProfile() -> some View {
        Group {
            if let imageURL = viewModel.userDetail.thumbnail {
                if let url = URL(string: imageURL) {
                    KFImage(url)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            
            Text(viewModel.userDetail.nickname)
                .font(.custom(CustomFont.interBold.rawValue, size: 20))
                .padding(.bottom, -5)
                .offset(y: -10)
        }
    }
    
    @ViewBuilder
    private func presentMembshipGradeButton() -> some View {
        Button {
            viewModel.viewItem = ProfileViewModel.ViewItem(viewCase: .membership, itemId: viewModel.userId)
        } label: {
            Text("멤버십 가입")
                .font(.custom(CustomFont.interBold.rawValue, size: 15))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                        .padding(.horizontal, 20)
                        .foregroundColor(.gray_bcbcbc)
                )
        }
        .presentIf(viewModel.doesNotJoinMembership)
        .padding(.bottom, 5)
        .sheet(item: $viewModel.viewItem) { item in
            if let id = item.itemId {
                JoinMembershipView(id: id)
            }
        }
    }
    
    @ViewBuilder
    private func subscribeButton() -> some View {
        Button {
            Task { await viewModel.subscribeButtonTapped() }
        } label: {
            HStack {
                Image(systemName: "bell")
                    .resizable()
                    .fontWeight(.bold)
                    .frame(width: 20, height: 20)
                
                Text("구독하기")
                    .font(.custom(CustomFont.interBold.rawValue, size: 15))
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                    .padding(.horizontal, 20)
                    .foregroundColor(.gray_bcbcbc)
            )
        }
        .presentIf(viewModel.subscribeButtonIsPresented)
        .padding(.bottom, 5)
    }
    
    @ViewBuilder
    private func unsubscribeButton() -> some View {
        Button {
            Task { await viewModel.unsubscribeButtonTapped() }
        } label: {
            HStack {
                Image(systemName: "bell.slash")
                    .resizable()
                    .fontWeight(.bold)
                    .frame(width: 20, height: 20)
                
                Text("구독 취소")
                    .font(.custom(CustomFont.interBold.rawValue, size: 15))
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                    .padding(.horizontal, 20)
                    .foregroundColor(.gray_bcbcbc)
            )
        }
        .presentIf(viewModel.unsubscribeButtonIsPresented)
        .padding(.bottom, 5)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(accountService: AccountServiceSuccessStub(), userId: 1)
    }
}
