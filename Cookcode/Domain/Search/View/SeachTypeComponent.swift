//
//  SeachTypeSelectView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI

struct SearchTypeComponent<ViewModel: SearchTypeSelectable>: View {
    
    let searchType: SearchType
    let viewModel: ViewModel
    
    var body: some View {
        Button {
            viewModel.searchTypeTapped(searchType)
        } label: {
            Text(searchType.rawValue)
        }

    }
}

struct SeachTypeSelectView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTypeComponent(searchType: .cookie,
                            viewModel: ProfileViewModel(accoutnService: AccountServiceSuccessStub(), userId: 1))
    }
}
