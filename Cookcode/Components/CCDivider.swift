//
//  CCDivider.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI

struct CCDivider: View {
    var body: some View {
        Rectangle()
            .frame(maxHeight: 1)
            .foregroundColor(.grayBCBCBC)
    }
}

struct CCDivider_Previews: PreviewProvider {
    static var previews: some View {
        CCDivider()
    }
}
