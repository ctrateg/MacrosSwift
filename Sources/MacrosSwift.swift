import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct MacrosSwift: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        Resolve.self,
    ]
}
