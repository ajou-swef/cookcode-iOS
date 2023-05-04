//
//  RefrigeratorView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import PopupView

struct RefrigeratorView: View {
    
    @StateObject private var viewModel = RefrigeratorViewModel()
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 2)
                .foregroundColor(.mainColor)
            
            HStack {
                Spacer()
                

                Button {
                    viewModel.selectIngredientViewIsPresented = true
                } label: {
                    Text("+ 추가")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .foregroundColor(.primary)
                }
            }

            
            ScrollView {
                VStack {
                    
                }
            }
        }
        .padding(.horizontal, 10)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("냉장고")
                    .font(CustomFontFactory.INTER_BOLD_30)
            }
        }
        .popover(isPresented: $viewModel.selectIngredientViewIsPresented) {
            SelectIngredientView(viewModel: viewModel)
                .popup(isPresented: $viewModel.ingredientFormIsPresented) {
                    VStack {
                        TextField("용량", text: $viewModel.ingredientQuantity)
                            .keyboardType(.numberPad)
                        
                        DatePicker("소비기한", selection: $viewModel.date, displayedComponents: .date)
                        
                        Spacer()
                        
                        HStack(spacing: 0) {
                            Button {
                                viewModel.ingredientFormIsPresented = false
                            } label: {
                                Text("취소")
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                                    .background(
                                        Rectangle()
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(.gray_bcbcbc)
                                    )
                            }
                            
                            Button {
                                
                            } label: {
                                Text("추가")
                                    .padding(.vertical, 10)
                                    .foregroundColor(.blue)
                                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        Rectangle()
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(.gray_bcbcbc)
                                    )
                            }
                        }
                        .padding(.horizontal, -15)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 15)
                    .frame(width: 300, height: 200)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 10)
                } customize: {
                    $0
                        .type(.floater(verticalPadding: (height - 200) / 2,
                                       useSafeAreaInset: true))
                        .animation(.linear(duration: 0))
                        .position(.top)
                        .closeOnTapOutside(true)
                        .closeOnTap(false)
                        .backgroundColor(Color.black.opacity(0.5))
                }

        }
    }
}

struct RefrigeratorView_Previews: PreviewProvider {
    static var previews: some View {
        RefrigeratorView()
    }
}
