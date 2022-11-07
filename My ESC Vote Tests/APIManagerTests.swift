//
//  My_ESC_Vote_Tests.swift
//  My ESC Vote Tests
//
//  Created by Maciej Piechota on 06/11/2022.
//

import XCTest

@testable import My_ESC_Vote


final class My_ESC_Vote_Tests: XCTestCase {

	
	
    override func setUp() {
		
    }

    override func tearDownWithError() throws {
        
    }

    func testDBServiceShouldFetchDataForContests() throws {
		var contests: [Contest] = []
		
		APIManager.shared().dbService.fetchAllData(from: Constants.API.Firestore.Collections.Contests.collectionName,
												   as: Contest.self) { records in
			contests.append(contentsOf: records)
			
			XCTAssert(!contests.isEmpty)
		}
		
    }

}
