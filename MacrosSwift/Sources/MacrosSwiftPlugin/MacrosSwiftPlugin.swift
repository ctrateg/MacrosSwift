import SwiftCompilerPlugin
import Macros
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct MacrosSwiftPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        Resolve.self,
    ]
}
