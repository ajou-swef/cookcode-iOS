//
//  RefreshComponent.swift
//  RefreshComponent
//
//  Created by 노우영 on 2023/05/21.
//

import SwiftUI

struct RefreshComponent<ViewModel: Refreshable, Content: View>: View {
    
    @ObservedObject var viewModel: ViewModel
    @ViewBuilder let view: Content
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                view
            }
            .frame(maxWidth: .infinity)
            .background {
                ScrollDetector { _, velocity in
                    viewModel.dragVelocity = velocity
                }
            }
            .overlay {
                Color.clear.offsetY(coordinateSpace: .named(viewModel.spaceName)) {
                    viewModel.scrollOffset = $0
                }
            }
        }
        .coordinateSpace(name: viewModel.spaceName)
        .overlay(alignment: .top) {
            Image(systemName: "arrow.clockwise")
                .rotationEffect(.degrees(viewModel.rotatingDegree))
                .opacity(viewModel.componentOpacity)
                .onChange(of: viewModel.dragVelocity) { _ in
                    Task { await viewModel.refreshIfPossible() }
                }
        }
    }
}

//struct RefreshComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        RefreshComponent(viewModel: ColorBoxRefreshViewModel())
//    }
//}
