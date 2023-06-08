//
//  RefreshableRecipeFetchView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/07.
//

import SwiftUI

struct RefreshableRecipeFetchView<ViewModel: RefreshableRecipeFetcher>: View {
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    var body: some View {
        VStack {
            presentOnlyCookableButton()
            
            RefreshComponent(viewModel: viewModel) {
                PagenableComponent(viewModel: viewModel) {
                    ForEach(viewModel.contents) { recipeCell in
                       Button {
                           let homeIdPath = HomeIdPath(path: .recipe, id: recipeCell.recipeId)
                           navigateViewModel.navigateWithHome(homeIdPath)
                       } label: {
                           CellView(cell: recipeCell)
                               .foregroundColor(.black)
                       }
                       .id(recipeCell.id)
                       .padding(.bottom, 15)
                        
                   }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("")
    }
    
    @ViewBuilder
    private func presentOnlyCookableButton() -> some View {
        HStack {
            Spacer()
            
            Button {
                viewModel.presentOnlyCookable.toggle()
            } label: {
                Image(systemName: viewModel.presentOnlyCookable ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .onChange(of: viewModel.dragVelocity, perform: { newValue in
                if newValue >= 0 {
                    viewModel.topOffset = -100
                } else {
                    viewModel.topOffset = 0
                }
            })
            .onChange(of: viewModel.presentOnlyCookable) { newValue in
                Task {
//                        proxy.scrollTo(viewModel.firstCellID)
                    await viewModel.onRefresh()
                }
            }
            
            Text("요리하자")
                .font(.custom(CustomFont.interRegular.rawValue, size: 16))
        }
        .foregroundColor(.mainColor)
        .zIndex(100)
        .offset(y: viewModel.topOffset)
        .padding(.bottom, viewModel.topOffset)
        .opacity(viewModel.topOpacity)
        .padding(.horizontal)
        .animation(.spring(), value: viewModel.topOpacity)
        .animation(.spring(), value: viewModel.topOffset)
    }
}

//struct RefreshableRecipeFetchView_Previews: PreviewProvider {
//    static var previews: some View {
//        RefreshableRecipeFetchView()
//    }
//}
