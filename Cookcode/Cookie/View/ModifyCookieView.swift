//
//  ModifyCookieView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/09.
//

import SwiftUI

struct ModifyCookieView: View {
    
    @StateObject private var viewModel: ModifyCookieViewModel
    
    init(cookieSerivce: CookieServiceProtocol = CookieService(), cookieDetail: CookieDetail) {
        self._viewModel = StateObject(wrappedValue: ModifyCookieViewModel(cookieService: cookieSerivce,
                                                                          cookieDetail: cookieDetail))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("쿠키 제목")
                .font(.custom(CustomFont.interSemiBold.rawValue, size: 18))
            
            TextField("제목을 입력하세요.", text: $viewModel.cookieForm.title)
                .font(.custom(CustomFont.interRegular.rawValue, size: 15))
                .padding(.bottom, 40)
            
            Text("쿠키 설명")
                .font(.custom(CustomFont.interRegular.rawValue, size: 15))
                .font(.custom(CustomFont.interSemiBold.rawValue, size: 18))
            
            TextEditor(text: $viewModel.cookieForm.description)
            
            Spacer()
            
            PatchComponent(viewModel: viewModel)
        }
        .padding(.top, 40)
        .padding(.horizontal)
    }
}

struct ModifyCookieView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyCookieView(cookieDetail: .mock())
    }
}
