//
//  RecipeEntranceView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/24.
//

import SwiftUI
import Kingfisher

struct RecipeEntranceView: View {
    
    let title: String
    let description: String
    let imageURL: String
    let cgSize: CGSize
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: imageURL))
                .resizable()
                .frame(maxWidth:. infinity, maxHeight: 300)
            
            Group {
                Text(title)
                    .font(CustomFontFactory.INTER_BOLD_30)
                
                Text(description)
                    .font(CustomFontFactory.INTER_REGULAR_14)
            }
            .padding(.leading, 10)
            
        }
    }
}

//struct RecipeEntranceView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeEntranceView(recipeForm: <#RecipeForm#>, imageData: <#Data#>)
//    }
//}
