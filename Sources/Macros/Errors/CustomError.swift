//
//  CustomError.swift
//  MacrosSwift
//
//  Created by Евгений Васильев on 11.04.2025.
//

public struct CustomError: Error {
    let message: String

    public init(_ message: String) {
        self.message = message
    }
}
