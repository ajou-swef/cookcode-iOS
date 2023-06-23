//
//  SelectIngredientViewModelTests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/05/04.
//

import XCTest
@testable import Cookcode

final class SelectIngredientViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_RecipeFormViewModel_ingredientCellTapped_appendID() {
        //  Given
        let viewModel = RecipeFormViewModel(contentService: ContentSuccessStub(),
                                            recipeService: RecipeServiceSuccessStub(), recipeId: nil)
        viewModel.useMainIngredient = true
        let counts = Int.random(in: 1..<30)
        
        //  When
        for i in 1...counts {
            viewModel.ingredientCellTapped(i)
        }
        
        //  Then
        let expected = counts
        let actual = viewModel.recipeForm.ingredients.count
        XCTAssertEqual(expected, actual)
    }
    
    func test_RecipeFormViewModel_ingredientCellTapped_removeID() {
        //  Given
        let viewModel = RecipeFormViewModel(contentService: ContentSuccessStub(),
                                            recipeService: RecipeServiceSuccessStub(), recipeId: nil)
        viewModel.useMainIngredient = true
        let id = Int.random(in: 1..<30)
        
        
        //  When
        viewModel.ingredientCellTapped(id)
        viewModel.ingredientCellTapped(id)
        
        //  Then
        let actual = viewModel.recipeForm.ingredients.contains { id in
            id == id
        }
        XCTAssertFalse(actual)
    }
    
}
