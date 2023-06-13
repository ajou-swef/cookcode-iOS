//
//  RefrigeratorView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import PopupView

struct RefrigeratorView: View {
    
    @StateObject private var viewModel = RefrigeratorViewModel(fridgeService: RefridgeratorService())
    @StateObject private var appendIngredientVM = AppendIngredientViewModel(refridgeratorService: RefridgeratorService())
    
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
            divider()
            appendIngredientButton()
            refridgerator()
        }
        .sheet(item: $viewModel.selectedIngredientDetail) { detail in
            IngredientPatchComponent(viewModel: ModifyIngredientViewModel(ingredientDetail: detail, refridgeratorService: RefridgeratorService()))
                .onDisappear {
                    Task { await viewModel.fetchIngredients() }
                }
        }
        .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
            ViewAlert.cancelButton
        }
        .padding(.horizontal, 10)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("냉장고")
                    .font(CustomFontFactory.INTER_BOLD_30)
            }
        }
    }
    
    
    @ViewBuilder
    fileprivate func refridgerator() -> some View {
        ScrollView(showsIndicators: false ){
            ForEach(IngredientType.allCases) { type in
                Section {
                    if let details = viewModel.refrigerator[type] {
                        let cells = details.map { IngredientCell(detail: $0) }
                        ingredientGrid(cells: cells)
                            .hidden(viewModel.ingredientTypeisHidden(type))
                    }
                } header: {
                    HStack {
                        Text("\(type.korean)")
                            .font(CustomFontFactory.INTER_BOLD_16)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Button {
                            viewModel.ingredientTypeButtonTapped(type)
                        } label: {
                            presentTypeButton(type: type)
                                .foregroundColor(.primary)
                        }

                    }
                }
            }
            .animation(.spring(), value: viewModel.presentedIngredientTypes)
        }
    }
    
    @ViewBuilder
    private func presentTypeButton(type: IngredientType) -> some View {
        Image(systemName: "chevron.right")
            .rotationEffect(viewModel.ingredientTypeisHidden(type) ? .zero : .degrees(90))
        
    }
    
    
    fileprivate func appendIngredientButton() -> some View {
        return HStack {
            Spacer()
            
            Button {
                appendIngredientVM.selectIngredientFormIsPresneted = true
            } label: {
                Text("+ 추가")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                    .foregroundColor(.primary)
            }
            .sheet(isPresented: $appendIngredientVM.selectIngredientFormIsPresneted) {
                selectIngredientView()
                    .onDisappear {
                        appendIngredientVM.searchText = ""
                    }
            }
        }
    }
    
    fileprivate func ingredientGrid(cells: [IngredientCell]?) -> some View {
        return LazyVGrid(columns: columns) {
            if let cells = cells {
                ForEach(cells) { cell in
                    Button {
                        viewModel.ingredientCellTapped(cell)
                    } label: {
                        IngredientCellView(cell: cell)
                    }
                }
            }
        }
    }
    
    fileprivate func selectIngredientView() -> some View {
        return SelectIngredientView(viewModel: appendIngredientVM)
            .sheet(item: $appendIngredientVM.selectedIngredientCell) { cell in
                IngredientPatchComponent(viewModel: PostIngredientViewModel(ingredientCell: cell, refridgeratorService: RefridgeratorService()))
            }
            .onDisappear {
                Task {
                    await viewModel.fetchIngredients()
                }
            }
    }
    
    @ViewBuilder
    private func divider() -> some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 2)
            .foregroundColor(.mainColor)
    }

    @ViewBuilder
    private func formButtomButton() -> some View {
        HStack(spacing: 0) {
            Button {
                appendIngredientVM.cancelButtonTapped()
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
                appendIngredientVM.cancelButtonTapped()
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
