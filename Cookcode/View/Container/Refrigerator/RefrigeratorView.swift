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
    
    
    fileprivate func refridgerator() -> ScrollView<ForEach<[IngredientType], String, Section<EmptyView, (some View)?, EmptyView>>> {
        return ScrollView {
            ForEach(IngredientType.allCases) { type in
                Section {
                    let details = viewModel.refrigerator[type]
                    if let details = details {
                        let cells = details.map { IngredientCell(detail: $0) }
                        ingredientGrid(cells: cells)
                    }
                } header: {
                    //                        Text("\(type.korean)")
                    //                            .font(CustomFontFactory.INTER_SEMIBOLD_14)
                    //                            .foregroundColor(.primary)
                }
                
            }
        }
    }
    
    var body: some View {
        VStack {
            divider()
            appendIngredientButton()
            refridgerator()
        }
        .sheet(item: $viewModel.selectedIngredientDetail) { detail in
            IngredientPatchView(viewModel: ModifyIngredientViewModel(ingredientDetail: detail))
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
            .popover(isPresented: $appendIngredientVM.selectIngredientFormIsPresneted) {
                selectIngredientView()
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
                IngredientPatchView(viewModel: PostIngredientViewModel(ingredientCell: cell))
            }
    }
    
    @ViewBuilder
    private func divider() -> some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 2)
            .foregroundColor(.mainColor)
    }
    
//    @ViewBuilder
//    private func ingredientForm() -> some View {
//        VStack {
//            TextField("용량", text: $appendIngredientVM.ingredientForm.quantity)
//                .buttonBorderShape(.roundedRectangle)
//                .keyboardType(.numberPad)
//            
//            DatePicker("소비기한", selection: $appendIngredientVM.ingredientForm.expiredAt, displayedComponents: .date)
//            
//            Spacer()
//            
//            formButtomButton()
//        }
//        .padding(.top, 20)
//        .padding(.horizontal, 15)
//        .frame(width: 300, height: 200)
//        .background(Color.white)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//        .padding(.horizontal, 10)
//    }
//    
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
