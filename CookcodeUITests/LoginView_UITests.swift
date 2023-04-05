//
//  LoginView_UITests.swift
//  CookcodeUITests
//
//  Created by 노우영 on 2023/03/05.
//

import XCTest
@testable import Cookcode

final class LoginView_UITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_LoginView_MembershipViewNavigationLink_shouldNavigateToMembershipView() {
        //  Given
        let navigation = app.otherElements.buttons["MembershipViewNavigationLink"]
        let membershipView = app.collectionViews["MembershipView"]
        
        app.launch()
        
        //  When
        navigation.tap()
        let membershipViewExists = membershipView.waitForExistence(timeout: 1)
        
        //  Then
        XCTAssertTrue(membershipViewExists)
    }
    
    func test_LoginView_LoginAssistanceViewNavigatonLink_shouldNavigateToLoginAssistanceView() {
        //  Given
        let navigation = app.buttons["LoginAssistanceViewNavigationLink"]
        let loginAssistanceView = app.collectionViews["LoginAssistanceView"]
        
        //  When
        navigation.tap()
        let loginAssistanceViewExists = loginAssistanceView.waitForExistence(timeout: 1)
        
        //  Then
        XCTAssertTrue(loginAssistanceViewExists)
    }
}
