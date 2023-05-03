//
//  MembershipFormViewModelTests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/05/03.
//

import XCTest
@testable import Cookcode

final class MembershipFormViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MembershipFormViewModel_checkNickname_nicknameIsUniqueShouldBeTrue() async {
        //  Given
        let viewModel = MembershipViewModel(accountService: AccountSuccessService())
        viewModel.membershipForm.nickname = "123"
        //  When
        await viewModel.checkNickname()
        
        //  Then
        XCTAssertTrue(viewModel.nicknameIsUnique)
    }

}
