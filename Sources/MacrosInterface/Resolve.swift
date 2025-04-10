//
//  Resolve.swift
//  MacrosSwift
//
//  Created by Евгений Васильев on 13.04.2025.
//

@attached(peer)
public macro Resolve(name: String, type: Any.Type) = #externalMacro(module: "MacrosSwift", type: "ResolveMacro")
