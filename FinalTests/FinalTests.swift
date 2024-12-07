//
//  FinalTests.swift
//  FinalTests
//
//  Created by 李方一 on 12/7/24.
//

import Testing
import XCTest
@testable import Final

struct FinalTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}

class TestViewControllerTests: XCTestCase {

    func testViewControllerLoadsSuccessfully() {
        // 初始化你要测试的页面
        let testViewController = AddNewSymptomsViewController()
        
        // 确保页面加载时视图不为 nil
        XCTAssertNotNil(testViewController.view, "View did not load successfully.")
    }
}
