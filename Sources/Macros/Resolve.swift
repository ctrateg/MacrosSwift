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
              let type = binding.typeAnnotation?.type.description.trimmingCharacters(in: .whitespacesAndNewlines)
        else {
            throw CustomError("Invalid @Resolve usage")
        }

        let variableName = pattern.identifier.text
        let resolved = "private let \(variableName): \(type) = container.resolve()"

        return [DeclSyntax(stringLiteral: resolved)]
    }
}
