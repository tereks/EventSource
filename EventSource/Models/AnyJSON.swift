//
//  AnyJSONType.swift
//  EventSource
//
//  Created by Sergey Kim on 20.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import Foundation

public protocol JSONType: Decodable {
    var value: Any { get }
}

extension Int: JSONType {
    public var value: Any { return self }
}
extension String: JSONType {
    public var value: Any { return self }
}
extension Double: JSONType {
    public var value: Any { return self }
}
extension Bool: JSONType {
    public var value: Any { return self }
}

public struct AnyJSON: JSONType {
    public let value: Any
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let intValue = try? container.decode(Int.self) {
            value = intValue
        } else if let stringValue = try? container.decode(String.self) {
            value = stringValue
        } else if let boolValue = try? container.decode(Bool.self) {
            value = boolValue
        } else if let doubleValue = try? container.decode(Double.self) {
            value = doubleValue
        } else if let arrayValue = try? container.decode(Array<AnyJSON>.self) {
            value = arrayValue
        } else if let dictValue = try? container.decode(Dictionary<String, AnyJSON>.self) {
            value = dictValue
        } else {
            throw DecodingError.typeMismatch(JSONType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unsupported JSON type"))
        }
    }
}
