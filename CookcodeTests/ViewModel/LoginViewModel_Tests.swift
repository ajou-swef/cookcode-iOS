//
//  LoginViewModel_Tests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/03/05.
//

import XCTest
@testable import Cookcode

final class LoginViewModel_Tests: XCTestCase {
    
    var viewModel: LoginViewModel?
    
    override func setUpWithError() throws {
        viewModel = LoginViewModel(accountService: AccountSuccessService()) 
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
//    func test_LoginViewModel_passwordText_shouldBeEmpty() {
//        //  Given
//        guard let vm = viewModel else {
//            XCTFail()
//            return
//        }
//
//        //  When
//
//        //  Then
//        XCTAssertEqual(vm.passwordText, "")
//    }
//
//    func test_LoginViewModel_loginButtonTapped_shouldDisplayInefficientInputMessage() {
//        //  Given
//        guard let vm = viewModel else {
//            XCTFail()
//            return
//        }
//
//        let ids = ["", "id", ""]
//        let passwords = ["", "", "password"]
//
//
//        for i in 0..<3 {
//            //  When
//            vm.idText = ids[i]
//            vm.passwordText = passwords[i]
//            vm.loginButtonTapped()
//
//            //  Then
//            XCTAssertTrue(vm.isShowingInefficientInputMessage)
//        }
//    }
//
//    func test_LoginViewModel_loginButtonTapped_shouldNotDisplayInefficientInputMessage() {
//        //  Given
//        guard let vm = viewModel else {
//            XCTFail()
//            return
//        }
//
//        vm.loginButtonTapped()
//        XCTAssertTrue(vm.isShowingInefficientInputMessage)
//
//        //  When
//        vm.idText = "id"
//        vm.passwordText = "password"
//        vm.loginButtonTapped()
//
//        //  Then
//        XCTAssertFalse(vm.isShowingInefficientInputMessage)
//    }
//
//    func test_LoginViewModel_isShowingInefficientInputMessage_shouldBeFalse() {
//        //  Given
//        guard let vm = viewModel else {
//            XCTFail()
//            return
//        }
//
//        //  When
//        vm.loginButtonTapped()
//
//        //  Then
//        XCTAssertTrue(vm.isShowingInefficientInputMessage)
//    }
//
//    func test_LoginViewModel_login_shouldBeTrue() {
//        //  Given
//        guard let vm = viewModel else {
//            XCTFail()
//            return
//        }
//
//        //  When
//        vm.login()
//
//        //  Then
//    }
}
