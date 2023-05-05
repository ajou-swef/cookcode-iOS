//
//  RefrigeratorView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import PopupView

struct RefrigeratorView: View {
    
    @StateObject private var viewModel = RefrigeratorViewModel(fridgeService: RefrigeratorSuccessService())
    
    let height = UIScreen.main.bounds.height
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
    ]
    
    
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
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.ingredientCell.indices, id: \.self) { i in
                        let cell = viewModel.ingredientCell[i]
                        
                        NavigationLink {
                            IngredientPatchView()
                        } label: {
                            IngredientCellView(cell: cell)
                        }
                    }
                }
            }
        }
        .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
            ServiceAlert.CANCEL_BUTTON
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
                    ingredientForm()
                } customize: {
                    $0
                        .type(.floater(verticalPadding: (height - 200) / 2,
                                       useSafeAreaInset: true))
                        .animation(.linear(duration: 0))
                        .position(.top)
                        .closeOnTapOutside(false)
                        .closeOnTap(false)
                        .backgroundColor(Color.black.opacity(0.5))
                }

        }
    }
    
    @ViewBuilder
    private func ingredientForm() -> some View {
        VStack {
            TextField("용량", text: $viewModel.ingredientQuantity)
                .keyboardType(.numberPad)
            DatePicker("소비기한", selection: $viewModel.date, displayedComponents: .date)
            
            Spacer()
            formButtomButton()
        }
        .padding(.top, 20)
        .padding(.horizontal, 15)
        .frame(width: 300, height: 200)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    private func formButtomButton() -> some View {
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
}

struct RefrigeratorView_Previews: PreviewProvider {
    static var previews: some View {
        RefrigeratorView()
    }
}
