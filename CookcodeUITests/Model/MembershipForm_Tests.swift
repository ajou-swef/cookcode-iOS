//
//  MembershipForm_Tests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/04/17.
//

import XCTest
@testable import Cookcode

final class MembershipForm_Tests: XCTestCase {

    var membershipForm: MembershipForm?
    
    override func setUpWithError() throws {
        membershipForm = MembershipForm()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MembershipForm_passwordContainsAlphabet_shouldBeTrue() {
        
        //  Given
        guard var membershipForm = membershipForm else {
            XCTFail()
            return
        }
        let passwords: [String] = ["helloworld", "a12324123", "lower_case", "UPPER_CASE"]
        
        for password in passwords {
            //  When
            membershipForm.password = password
            
            //  Then
            XCTAssertTrue(membershipForm.passwordContainsAlphabet)
        }
    }
    
    func test_MembershipForm_passwordContainsAlphabet_shouldBeFalse() {
        //  Given
        guard var membershipForm = membershipForm else {
            XCTFail()
            return
        }
        let passwords: [String] = ["1234567789", "!@#$%^&*(", ""]
        
        for password in passwords {
            //  When
            membershipForm.password = password
            
            //  Then
            XCTAssertFalse(membershipForm.passwordContainsAlphabet)
        }
    }
    
    func test_MembershipForm_passwordContainsSpecialCharacter_shouldBeTrue() {
        //  Given
        guard var membershipForm = membershipForm else {
            XCTFail()
            return
        }
        let passwords: [String] = ["~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "{", "[", "]", "}", ":", ";",
        "\"", "'", ",", "<", ".", ">", "/", "?", "-", "_", "+", "=", "`", "₩"]
        
        for password in passwords {
            //  When
            membershipForm.password = password
            
            //  Then
            XCTAssertTrue(membershipForm.passwordContainsSpecialCharacter, "\(membershipForm.password)")
        }
    }
    
    func test_MembershipForm_passwordContainsSpecialCharacter_shouldBeFalse() {
        //  Given
        guard var membershipForm = membershipForm else {
            XCTFail()
            return
        }
        let passwords: [String] = ["lowercase", "UPPERCASE", "123456789"]
        
        for password in passwords {
            //  When
            membershipForm.password = password
            
            //  Then
            XCTAssertFalse(membershipForm.passwordContainsSpecialCharacter)
        }
    }
    
    func test_MembershipForm_passwordContainsNumber_shouldBeTrue() {
        //  Given
        guard var membershipForm = membershipForm else {
            XCTFail()
            return
        }
        let passwords: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        
        for password in passwords {
            //  When
            membershipForm.password = password
            
            //  Then
            XCTAssertTrue(membershipForm.passwordContainsNumber)
        }
    }
    
    func test_MembershipForm_passwordContainsNumber_shouldBeFalse() {
        //  Given
        guard var membershipForm = membershipForm else {
            XCTFail()
            return
        }
        let passwords: [String] = ["lowercase", "UPPERCASE", "`₩~!@#$%&&*()-_=+[{]};:'/?.>,<"]
        
        for password in passwords {
            //  When
            membershipForm.password = password
            
            //  Then
            XCTAssertFalse(membershipForm.passwordContainsNumber)
        }
    }
    
    func test_MembershipForm_isEnoughLongPassword_shouldBeTrue() {
        //  Given
        guard var membershipForm = membershipForm else {
            XCTFail()
            return
        }
        let passwords: [String] = ["lowercase", "UPPERCASE", "12345678"]
        
        for password in passwords {
            //  When
            membershipForm.password = password
            
            //  Then
            XCTAssertTrue(membershipForm.isEnoughLongPassword)
        }
    }
    
    func test_MembershipForm_isEnoughLongPassword_shouldBeFalse() {
        //  Given
        guard var membershipForm = membershipForm else {
            XCTFail()
            return
        }
        let passwords: [String] = ["", "1234567"]
        
        for password in passwords {
            //  When
            membershipForm.password = password
            
            //  Then
            XCTAssertFalse(membershipForm.isEnoughLongPassword)
        }
    }
    
    func test_MembershipForm_isValidPassword_shouldBeTrue() {
        //  Given
        guard var membershipForm = membershipForm else {
            XCTFail()
            return
        }
        let passwords: [String] = ["!abc1234", "password@2"]
        
        for password in passwords {
            //  When
            membershipForm.password = password
            
            //  Then
            XCTAssertTrue(membershipForm.isValidPassword)
        }
    }
}
