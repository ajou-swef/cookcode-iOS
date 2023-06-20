//
//  LoginViewModelTests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/06/20.
//

import XCTest
@testable import Cookcode

final class LoginViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_clear() async {
        //  Given
        let vm = LoginViewModel(accountService: AccountServiceSuccessStub())
        vm.signInForm.email = UUID().uuidString
        vm.signInForm.password = UUID().uuidString
        
        //  When
        await vm.clear()
        
        //  Then
        let expected = SignInForm()
        let actual = vm.signInForm
        XCTAssertEqual(expected, actual, "SignInForm 초기화 되지 않음.")
    }
    
    func test_signIn() async {
        //  Given
        let vm = LoginViewModel(accountService: AccountServiceSuccessStub())
        XCTAssertNil(UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY))
        XCTAssertNil(UserDefaults.standard.string(forKey: REFRESH_TOKEN_KEY))
        XCTAssertNil(UserDefaults.standard.string(forKey: USER_ID))
        
        //  When
        let _ = await vm.signIn()
        
        //  Then
        XCTAssertNotNil(UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY))
        XCTAssertNotNil(UserDefaults.standard.string(forKey: REFRESH_TOKEN_KEY))
        XCTAssertNotNil(UserDefaults.standard.string(forKey: USER_ID))
    }

}
