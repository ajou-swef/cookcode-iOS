//
//  SearchView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import SwiftUI

struct SearchView: View {
    
    @State private var text: String = ""
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
    ]
    
    let recipeCellHeight: CGFloat = 200
    let offsetY: CGFloat = 20
    
    var body: some View {
        ScrollView {
            Text("검색된 내용 없을 시 빈화면")
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                TextField("레시피 검색", text: $text)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
