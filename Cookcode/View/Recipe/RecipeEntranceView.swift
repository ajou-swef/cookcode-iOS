//
//  RecipeEntranceView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/24.
//

import SwiftUI

struct RecipeEntranceView: View {
    
    let recipeForm: RecipeForm
    let imageData: Data?
    let cgSize: CGSize
    
    var body: some View {
        VStack {
            if let data = imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(maxWidth:. infinity, maxHeight: 300)
            }
        }
    }
}

//struct RecipeEntranceView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeEntranceView(recipeForm: <#RecipeForm#>, imageData: <#Data#>)
//    }
//}
