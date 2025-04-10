import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct ResolveClass: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let classDecl = declaration.as(ClassDeclSyntax.self) else {
            throw CustomError("This macro can only be used with classes")
        }

        var newMembers: [DeclSyntax] = []

        for member in classDecl.members.members {
            if let propertyDecl = member.decl.as(VariableDeclSyntax.self),
               let binding = propertyDecl.bindings.first,
               let pattern = binding.pattern.as(IdentifierPatternSyntax.self),
               let type = binding.typeAnnotation?.type {
                let variableName = pattern.identifier.text
                let resolvedCode = """
                private let \(variableName): \(type) = container.resolve()
                """
                
                let resolvedDecl = DeclSyntax(stringLiteral: resolvedCode)
                newMembers.append(resolvedDecl)
            }
        }

        // Вернуть новый класс с добавленными инициализированными свойствами
        return [classDecl.withMembers(ClassMemberDeclListSyntax(members: newMembers))]
    }
}
