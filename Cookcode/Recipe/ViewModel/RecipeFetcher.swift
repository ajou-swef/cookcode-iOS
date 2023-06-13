//
//  PagenableRecipe.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI

protocol RecipeFetcher: Pagenable {
    var recipeService: RecipeServiceProtocol { get }
    var serviceAlert: ViewAlert { get set }
}

extension RecipeFetcher {
    func controllPageState(_ response: ServiceResponse<PageResponse<RecipeCellDto>>, _ curPage: Int) {
        if response.data.hasNext {
            waitInPage(curPage + 1)
        } else {
            pageState = .noRemain
        }
    }
    
    func waitInPage(_ page: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.pageState = .wait(page)
        }
    }
}
