//
//  CookieCommentViewModelTests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/06/01.
//

import XCTest
@testable import Cookcode

final class CookieCommentViewModelTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_commentButtonTapped_() async {
        
        //  Given
        let viewModel = CookieCommentViewModel(conentsId: 1, commentService: RecipeServiceSuccessStub())
        
        //  When
        await viewModel.onFetch()
        
        //  Then
        XCTAssertFalse(viewModel.comments.isEmpty, "댓글이 할당되지 않음")
    }
}
