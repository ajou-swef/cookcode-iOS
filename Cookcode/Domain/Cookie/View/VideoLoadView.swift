//
//  VideoLoadView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import SwiftUI

struct VideoLoadView: View {
    
    let state: VideoLoadState
    
    var body: some View {
        switch state {
        case .loading:
            ProgressView()
        case .loaded(let uIImage):
            Image(uiImage: uIImage)
                .resizable()
        }
    }
}

//struct VideoLoadView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoLoadView()
//    }
//}
