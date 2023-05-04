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

    func test_SelectIngredientViewModel_ingredientCellTapped_appendCell() {
        //  Given
        let viewModel = SelectIngredientViewModel()
        let ingredientCell = INGREDIENTS[1]
        
        if let ingredientCell = ingredientCell {
            
            //  When
            viewModel.ingredientCellTapped(ingredientCell)
            
            //  Then
            let actual = viewModel.selectedIngredientIDs.contains { cell in
                cell == ingredientCell
            }
            
            XCTAssertTrue(actual)
        }
    }
    
    func test_SelectIngredientViewModel_ingredientCellTapped_removeCell() {
        //  Given
        let viewModel = SelectIngredientViewModel()
        let ingredientCell = INGREDIENTS[1]
        if let ingredientCell = ingredientCell {
            viewModel.ingredientCellTapped(ingredientCell)
            
            // When
            viewModel.ingredientCellTapped(ingredientCell)
            let actual = viewModel.selectedIngredientIDs.contains { cell in
                cell == ingredientCell
            }
            
            XCTAssertFalse(actual)
        }
    }

}
