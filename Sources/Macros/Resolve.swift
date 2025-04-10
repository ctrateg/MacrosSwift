//
//  ResolveStruct.swift
//  MacrosSwift
//
//  Created by Евгений Васильев on 11.04.2025.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct Resolve: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let varDecl = declaration.as(VariableDeclSyntax.self),
              let binding = varDecl.bindings.first,
              let pattern = binding.pattern.as(IdentifierPatternSyntax.self),
              let type = binding.typeAnnotation?.type else {
            throw CustomError("Invalid @Resolve usage")
        }

        let variableName = pattern.identifier

        let patternBinding = PatternBindingSyntax(
            pattern: PatternSyntax(stringLiteral: variableName.text),
            typeAnnotation: TypeAnnotationSyntax(
                colon: .colonToken(),
                type: type
            ),
            initializer: .init(equal: .equalToken(), value: ExprSyntax(literal: "container.resolve()"))
        )

        let bindingsList = PatternBindingListSyntax([patternBinding])
        let variableDecl = VariableDeclSyntax(bindingKeyword: .keyword(.let), bindings: bindingsList)

        return [DeclSyntax(variableDecl)]
    }
}
