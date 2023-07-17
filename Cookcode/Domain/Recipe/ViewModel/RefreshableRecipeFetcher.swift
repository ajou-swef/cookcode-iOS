//
//  ResettableItemFetcher.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/07.
//

import Foundation
import cookcode_service

protocol RefreshableRecipeFetcher: Refreshable, RecipeFetcher where Dto == RecipeCellDTO, T == RecipeCell {
    var sort: SortType { get set } 
    var presentOnlyCookable: Bool { get set }
    var topOffset: CGFloat { get set }
    var topOpacity: CGFloat { get }
    var searchType: SearchMembershipType { get set } 
}
