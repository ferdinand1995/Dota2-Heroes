//
//  Dota_HeroesTests.swift
//  Dota HeroesTests
//
//  Created by Ferdinand on 31/07/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import XCTest
@testable import Dota_Heroes

class Dota_HeroesTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONMapping() throws {
        super.setUp()
        
        guard let url = Bundle.main.path(forResource: "example_contract", ofType: "json") else {
            XCTFail("Missing file: User.json")
            return
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
        let heroStats: HeroStats = try JSONDecoder().decode(HeroStats.self, from: data)
        
        XCTAssertEqual(12, heroStats.list_heroes?.count)

        let viewModel = ViewModel(withModel: &Ref(HeroStats()).val)
        viewModel.loadFromLocal()
        
        XCTAssertEqual(12, viewModel.itemsInSection())
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
