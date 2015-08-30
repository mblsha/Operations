//
//  FileExistsConditionTests.swift
//  Operations
//
//  Created by Michail Pishchagin on 30.08.15.
//  Copyright © 2015 Daniel Thorpe. All rights reserved.
//

import XCTest
import Operations

class TempFile {
    let path: String
    var url: NSURL { return NSURL(fileURLWithPath: path) }

    init() {
        path = NSTemporaryDirectory() + NSUUID().UUIDString

        let fm = NSFileManager.defaultManager()
        fm.createFileAtPath(path, contents: nil, attributes: nil)
        assert(fm.fileExistsAtPath(path))
    }

    deinit {
        let fm = NSFileManager.defaultManager()
        try! fm.removeItemAtPath(path)
    }
}

class FileExistsConditionTests: OperationTests {

    func test__succeeds_when_file_exists() {
        let temp = TempFile()

        let operation = TestOperation(delay: 0)
        operation.addCondition(FileExistsCondition(fileUrl: temp.url))

        addCompletionBlockToTestOperation(operation, withExpectation: expectationWithDescription("Test: \(__FUNCTION__)"))
        runOperation(operation)

        waitForExpectationsWithTimeout(1, handler: nil)
        XCTAssertTrue(operation.finished)
    }

    func test__succeeds_when_file_exists_with_multiple_preconditions() {
        let temp = TempFile()

        let operation = TestOperation(delay: 0)
        operation.addCondition(FileExistsCondition(fileUrl: temp.url))
        operation.addCondition(FileExistsCondition(fileUrl: temp.url))

        addCompletionBlockToTestOperation(operation, withExpectation: expectationWithDescription("Test: \(__FUNCTION__)"))
        runOperation(operation)

        waitForExpectationsWithTimeout(1, handler: nil)
        XCTAssertTrue(operation.finished)
    }

    func test__fails_when_file_doesnt_exist() {
        let operation = TestOperation(delay: 0)
        operation.addCondition(FileExistsCondition(fileUrl: NSURL(fileURLWithPath: "/tmp/doesnt-exist")))

        addCompletionBlockToTestOperation(operation, withExpectation: expectationWithDescription("Test: \(__FUNCTION__)"))
        runOperation(operation)

        waitForExpectationsWithTimeout(1, handler: nil)
        XCTAssertFalse(operation.didExecute)
    }
}
