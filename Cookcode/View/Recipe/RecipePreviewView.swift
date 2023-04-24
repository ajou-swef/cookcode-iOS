//
//  RecipePreviewView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/24.
//

import SwiftUI

struct RecipePreviewView: View {
    
    @ObservedObject var viewModel: RecipeFormViewModel
    
    var body: some View {
        Text("Recipe Preview")
    }
}

struct RecipePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        RecipePreviewView(viewModel: RecipeFormViewModel(true))
    }
}
