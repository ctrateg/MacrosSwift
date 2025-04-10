// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "MacrosSwift",
    platforms: [
        .iOS(.v15),
        .macOS(.v15),
    ],
    products: [
        .library(
            name: "MacrosSwift",
            targets: ["Macros"]
        ),
        .executable(
            name: "MacrosSwiftPlugin",
            targets: ["MacrosSwiftPlugin"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", branch: "release/5.9"),
    ],
    targets: [
        // Таргет с набором макросов
        .macro(
            name: "Macros",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ],
            path: "Sources/Macros"
        ),

        // Таргет для плагина компилятора
        .executableTarget(
            name: "MacrosSwiftPlugin",
            dependencies: [
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax")
            ],
            path: "Sources/MacrosSwiftPlugin"
        ),
    ]
)
