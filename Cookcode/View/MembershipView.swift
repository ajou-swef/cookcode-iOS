//
//  MembershipView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/03/05.
//

import SwiftUI

struct MembershipView: View {
    
    enum Field: Hashable {
        case email
        case nickname
        case password
        case passwordCheck
    }
    
    @StateObject private var viewModel = MembershipViewModel()
    @FocusState private var focus: Field?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField("이메일", text: $viewModel.membershipForm.email)
                    .font(CustomFontFactory.INTER_SECTION_TITLE)
                    .focused($focus, equals: .email)
                    .padding(.leading, 10)
                    .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                                      focused: focus == .email)
                    .tint(.mainColor)
                    .onSubmit {
                        if viewModel.membershipForm.nickname.isEmpty {
                            focus = .nickname
                        }
                    }
                    .padding(.top, 60)

                TextField("닉네임", text: $viewModel.membershipForm.nickname)
                    .font(CustomFontFactory.INTER_SECTION_TITLE)
                    .padding(.leading, 10)
                    .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                                      focused: focus == .nickname)
                    .focused($focus, equals: .nickname)
                    .tint(.mainColor)
                    .onSubmit {
                        if viewModel.membershipForm.password.isEmpty {
                            focus = .password
                        }
                    }
                    .overlay(alignment: .trailing) {
                        Button {

                        } label: {
                            Text("중복확인")
                                .font(CustomFontFactory.INTER_SEMIBOLD_14)
                                .foregroundColor(.gray808080)
                                .padding(.trailing, 10)
                        }

                    }

                HStack {
                    Text("닉네임 중복을 확인해주세요.")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .padding(.top, -10)
                        .padding(.leading, 10)
                    Spacer()
                }
                .frame(maxWidth: 320)
                .hidden(viewModel.membershipForm.nickname.isEmpty)

                SecureField("비밀번호", text: $viewModel.membershipForm.password)
                    .font(CustomFontFactory.INTER_SECTION_TITLE)
                    .padding(.leading, 10)
                    .focused($focus, equals: .password)
                    .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                                      focused: focus == .password)
                    .tint(.mainColor)
                    .onSubmit {
                        if viewModel.membershipForm.passwordCheck.isEmpty {
                            focus = .passwordCheck
                        }
                    }
                
                HStack {
                    Text("영문, 특수문자, 숫자를 포함한 8자리 이상을 입력해주세요.")
                        .foregroundColor(.gray808080)
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .padding(.top, -10)
                        .padding(.leading, 10)
                    Spacer()
                }
                .frame(maxWidth: 320)


                SecureField("비밀번호 확인", text: $viewModel.membershipForm.passwordCheck)
                    .font(CustomFontFactory.INTER_SECTION_TITLE)
                    .padding(.leading, 10)
                    .focused($focus, equals: .passwordCheck)
                    .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                                      focused: focus == .passwordCheck)
                    .tint(.mainColor)

                HStack {
                    
                    Text("비밀번호가 유효하지 않습니다.")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .padding(.top, -10)
                        .padding(.leading, 10)
                        .hidden(viewModel.hidePasswordValidText)
                    
                    Text("비밀번호가 일치하지 않습니다.")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .padding(.top, -10)
                        .padding(.leading, 10)
                        .hidden(viewModel.hidePasswordMismatchText)
                    
                    Spacer()
                }
                .frame(maxWidth: 320)
                

                Button {
                    print("\(viewModel.completeButtonIsAvailable)")
                } label: {
                    Text("완료")
                        .foregroundColor(.white)
                        .roundedRectangle(viewModel.completeButtonIsAvailable ?  .ORANGE_320_FILLED : .GRAY_320_FILLED)
                }
                .disabled(!viewModel.completeButtonIsAvailable)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle(
            Text("회원가입")
        )
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            focus = .email
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView()
    }
}
