//
//  RealizationPlugin.swift
//  MacrosSwift
//
//  Created by Евгений Васильев on 13.04.2025.
//
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct RealizationPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ResolveMacro.self
    ]
}
