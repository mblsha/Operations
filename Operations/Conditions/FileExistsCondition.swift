//
//  FileExistsCondition.swift
//  Mergist
//
//  Created by Michail Pishchagin on 30.08.15.
//  Copyright © 2015 mblsha. All rights reserved.
//

import Foundation

public struct FileExistsCondition: OperationCondition {
    public enum Error: ErrorType, Equatable {
        case FileDoesntExist(path: String)
    }

    public let name = "File Exists Condition"
    public let isMutuallyExclusive = false
    private let fileUrl: NSURL

    public init(fileUrl: NSURL) {
        self.fileUrl = fileUrl
    }

    public func dependencyForOperation(operation: Operation) -> NSOperation? {
        return .None
    }

    public func evaluateForOperation(operation: Operation, completion: OperationConditionResult -> Void) {
        let fm = NSFileManager.defaultManager()
        guard let filePath = fileUrl.path
              where fm.fileExistsAtPath(filePath) else {
            completion(.Failed(Error.FileDoesntExist(path: fileUrl.absoluteString)))
            return
        }

        completion(.Satisfied)
    }
}

public func ==(lhs: FileExistsCondition.Error, rhs: FileExistsCondition.Error) -> Bool {
    switch (lhs, rhs) {
    case (.FileDoesntExist(let p1), .FileDoesntExist(let p2)): return p1 == p2
    }
}
