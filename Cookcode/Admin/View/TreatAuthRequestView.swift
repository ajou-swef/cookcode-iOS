//
//  TreatAuthRequestViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/12.
//

import SwiftUI

struct TreatAuthRequestView: View {
    
    @StateObject private var viewModel = TreatAuthRequestViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.userAuth) { userAuth in
                UserAuthCellView(viewModel: viewModel, userAuth: userAuth)
            }
        }
    }
}

struct TreatAuthRequestViewModel_Previews: PreviewProvider {
    static var previews: some View {
        TreatAuthRequestView()
    }
}
