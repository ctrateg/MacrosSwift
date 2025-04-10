//
//  ResolveStruct.swift
//  MacrosSwift
//
//  Created by Евгений Васильев on 11.04.2025.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

public struct ResolveMacro: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {

        guard case let .argumentList(arguments)? = node.argument,
              arguments.count == 2,
              let nameExpr = arguments.first?.expression.as(IdentifierExprSyntax.self),
              let typeExpr = arguments.last?.expression.as(IdentifierExprSyntax.self)
        else {
            let errorDiagnose = Diagnostic(
                node: Syntax(node),
                message: MistakeDiagnostic.wrongInterface
            )

            context.diagnose(errorDiagnose)

            return []
        }

        let variableName = nameExpr.identifier.text
        let variableType = typeExpr.identifier.text

        let resolvedLine = """
        private let \(variableName): \(variableType) = container.resolve()
        """

        return [DeclSyntax(stringLiteral: resolvedLine)]
    }
}

// MARK: - ResolveMacro

private extension ResolveMacro {

    enum MistakeDiagnostic: String {
        case wrongInterface
    }
}

// MARK: - Diagnostic.DiagnosticMessage

extension ResolveMacro.MistakeDiagnostic: DiagnosticMessage {

    var message: String {
        switch self {
        case .wrongInterface:
            return "Expected @Resolve(name: ..., type: ...)"
        }
    }

    var diagnosticID: MessageID {
        .init(domain: "ResolveMacro", id: rawValue)
    }

    var severity: DiagnosticSeverity {
        switch self {
        case .wrongInterface:
            return .error
        }
      }
}
