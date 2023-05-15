//
//  RecipeFormTests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/05/01.
//

import XCTest
import Combine
@testable import Cookcode

final class RecipeFormTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_RecipeForm_update_hasDeletedThunbmails() {
        //  Given
        let newURL = ["https://picsum.photos/200", "https://picsum.photos/200"]
        var recipeForm = RecipeForm()
        var expected: Int = 0
        let random = Int.random(in: 1..<100)
        
        //  When
        for _ in 0..<random {
            recipeForm.updateThumbnail(url: newURL)
            expected += 1
        }
        
        //  Then
        expected -= 1
        let actual = recipeForm.deletedThumbnails.count
        XCTAssertEqual(expected, actual)
    }
    
    func test_When_AnyRequiredInformationIsEmpty_Expect_True() {
        
        //  Given
        let titleIsEmpty = RecipeForm(title: "", description: "description", _thumbnail: "thumbnail")
        let descirptionIsEmpty = RecipeForm(title: "title", description: "", _thumbnail: "thumbnail")
        let thumbnailIsEmpty = RecipeForm(title: "title", description: "description", _thumbnail: "")
        
        let forms: [RecipeForm] = [titleIsEmpty, descirptionIsEmpty, thumbnailIsEmpty]
        
        for form in forms {
            //  Then
            XCTAssertTrue(form.anyRequiredInformationIsEmpty)
        }
        
    }
    
    
    func test_When_FillAllRequiredInformation_Expect_False() {
        
        //  Given
        let form = RecipeForm(title: "title", description: "description", _thumbnail: "thumbnail")
        
        
        //  Then
        XCTAssertFalse(form.anyRequiredInformationIsEmpty)
    }
    
    func test_When_AnyStepLacksOfInformation_Expect_True() {
        
    }

}
