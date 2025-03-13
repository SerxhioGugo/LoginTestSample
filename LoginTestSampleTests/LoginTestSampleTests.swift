//
//  LoginTestSampleTests.swift
//  LoginTestSampleTests
//
//  Created by Serxhio Gugo on 3/12/25.
//

import XCTest
@testable import LoginTestSample

final class LoginTestSampleTests: XCTestCase {

    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_LoginViewModel_email_shouldBeValid() {
        let validEmails = [
            "test@example.com",
            "user.name@domain.co",
            "user-name@sub.domain.com",
            "a@b.co"
        ]
        
        for email in validEmails {
            XCTAssertTrue(viewModel.isValidEmail(email), "\(email) should be valid")
        }
    }
    
    func test_LoginViewModel_email_shouldBeInvalid() {
        let invalidEmails = [
            "test@.com",
            "@domain.com",
            "test@domain",
            "test.domain.com",
            "",
            "test@domain.c"
        ]
        
        for email in invalidEmails {
            XCTAssertFalse(viewModel.isValidEmail(email), "\(email) should be invalid")
        }
    }
    
    func test_LoginViewModel_password_shouldBeValid() {
        let validPasswords = [
            "Password123",
            "Test123456",
            "Abcdefg8",
            "A1bcdefgh"
        ]
        
        for password in validPasswords {
            XCTAssertTrue(viewModel.isValidPassword(password), "Password should be valid")
        }
    }
    
    func test_LoginViewModel_password_shouldBeInvalid() {
        let invalidPasswords = [
            "password",      // No uppercase, no number
            "Pass",          // Too short
            "password123",   // No uppercase
            "Pass123",       // Too short
        ]
        
        for password in invalidPasswords {
            XCTAssertFalse(viewModel.isValidPassword(password), "\(password) should be invalid")
        }
    }
    
    func test_LoginViewModel_Successful() {
        
        //Given
        viewModel.emailText = "test@example.com"
        viewModel.passwordText = "Emolala123"
        
        //When
        let expectation = XCTestExpectation(description: "Login should be successfull")
        viewModel.login()
        XCTAssertTrue(viewModel.isLoading)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertTrue(self.viewModel.isLoggedIn)
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_LoginViewModel_FailedLogin() {
        
        //Given
        viewModel.emailText = "wrongEmail@example.com"
        viewModel.passwordText = "Emolala123"
                
        //When
        let expectation = XCTestExpectation(description: "Login failure")
        viewModel.login()
        XCTAssertTrue(viewModel.isLoading)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertFalse(self.viewModel.isLoggedIn)
            XCTAssertEqual(self.viewModel.errorMessage, "Invalid credentials")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_LoginViewModel_EmptyFields() {
        
        //When
        viewModel.emailText = ""
        viewModel.passwordText = ""
        viewModel.login()
        
        //Then
        XCTAssertEqual(viewModel.errorMessage, "Please fill in all fields")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isLoggedIn)
    }
    
}
