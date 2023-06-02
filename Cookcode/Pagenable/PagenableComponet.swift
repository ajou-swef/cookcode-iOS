//
//  PagenableComponent.swift
//  RefreshComponent
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI

struct PagenableComponent<ViewModel: Pagenable, Content: View>: View {
    
    @ObservedObject var viewModel: ViewModel
    @ViewBuilder let view: Content
    
    var body: some View {
        Group {
            view
            
            ProgressView()
                .presentIf(viewModel.isLoadingState)
            
            
            Color.clear
                .frame(height: 1)
                .offsetY {
                    viewModel.fetchTriggerOffset = $0
                }
                .onChange(of: viewModel.fetchTriggerOffset) { newValue in
                    Task { await viewModel.fetchNextPage() }
                }
        }
    }
}

//struct PagenableComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        PagenableComponent()
//    }
//}
