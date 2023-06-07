//
//  HomeViewModelTests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/05/22.
//

import XCTest
import Combine
@testable import Cookcode

final class HomeViewModelTests: XCTestCase {

    var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_When_UpdateTypeIsDelete_Then_RemoveCell() async {
        //  Given
        let viewModel = HomeViewModel(recipeService: RecipeSuccessService())
        let recipeCell = RecipeCell.mock()
        viewModel.recipeCells.append(recipeCell)
        let updateInfo = CellUpdateInfo(updateType: .delete, cellId: recipeCell.recipeId)
        let dict: [CellType: CellUpdateInfo] = [.recipe: updateInfo]

        //  When
        await viewModel.updateCell(dict)
        
        //  Then
    
        let actual = viewModel.recipeCells.contains { $0.recipeId == recipeCell.recipeId }
        XCTAssertFalse(actual)
    }
    
    
    func test_When_createContentButtonFirstTapped_Then_showContentType() async {
        //  Given
        let viewModel = HomeViewModel(recipeService: RecipeSuccessService())
        
        //  When
        await viewModel.createContentButtonTapped()
        
        //  Then
        XCTAssertTrue(viewModel.contentTypeButtonIsShowing)
    }
    
    func test_When_createContentButtonAlreadyTapped_Then_hideContentType() async {
        //  Given
        let viewModel = HomeViewModel(recipeService: RecipeSuccessService())
        await viewModel.createContentButtonTapped()
        
        //  When
        await viewModel.createContentButtonTapped()
        
        //  Then
        XCTAssertFalse(viewModel.contentTypeButtonIsShowing)
    }
}
