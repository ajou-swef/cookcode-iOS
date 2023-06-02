//
//  SearchTypeSelectable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import Foundation

protocol SearchTypeSelectable: ObservableObject {
    var seachType: SearchType { get set }
    func searchTypeTapped(_ searchType: SearchType) 
}
