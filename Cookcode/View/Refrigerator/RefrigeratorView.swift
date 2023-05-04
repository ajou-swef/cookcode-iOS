//
//  RefrigeratorView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import Pop

struct RefrigeratorView: View {
    
    @StateObject private var viewModel = RefrigeratorViewModel()
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 2)
                .foregroundColor(.mainColor)
            
            HStack {
                Spacer()
                
                NavigationLink {
                    SelectIngredientView(viewModel: viewModel)
                } label: {
                    Text("+ 추가")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .foregroundColor(.primary)
                }

//                Button {
//                    viewModel.selectIngredientViewIsPresented = true
//                } label: {
//                    Text("+ 추가")
//                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
//                        .foregroundColor(.primary)
//                }
                .alert("재료 추가", isPresented: $viewModel.ingredientFormIsPresented) {
                    Button("확인", role: .cancel) {
                        
                    }
                }
                .sheet(isPresented: $viewModel.selectIngredientViewIsPresented) {
                    SelectIngredientView(viewModel: viewModel)
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
    }
}

struct RefrigeratorView_Previews: PreviewProvider {
    static var previews: some View {
        RefrigeratorView()
    }
}
