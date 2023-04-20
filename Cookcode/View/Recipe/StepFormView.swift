//
//  StepFormView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/20.
//

import SwiftUI

struct StepFormView: View {
    
    @ObservedObject var viewModel: RecipeFormViewModel
    let stepIndex: Int
    
    init(viewModel: RecipeFormViewModel, stepIndex: Int) {
        self.viewModel = viewModel
        self.stepIndex = stepIndex
    }
    
    var body: some View {
        VStack {
            Text("Step Form View")
        }
    }
}

struct StepFormView_Previews: PreviewProvider {
    static var previews: some View {
        StepFormView(viewModel: RecipeFormViewModel(), stepIndex: 0)
    }
}
