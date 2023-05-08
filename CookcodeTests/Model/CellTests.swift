//
//  IngredientCellTests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/05/05.
//

import XCTest
@testable import Cookcode

final class CellTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_IngredientCell_presentBadge_shouldBeTrue() {
        //  Given
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.string(from: .now)
        
        var dto = IngredientDetailDTO.Mock()
        dto.expiredAt(newDate)
        
        //  When
        let ingredientCell = IngredientCell(dto: dto)
        
        //  Then
        XCTAssertTrue(ingredientCell.presentBadge)
    }
}
