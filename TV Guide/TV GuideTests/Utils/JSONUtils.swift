//
//  JSONUtils.swift
//  TV GuideTests
//
//  Created by Thalisson da Rosa on 29/05/22.
//

import Foundation

final class JSONUtils {
    static func jsonDataFromFile(name: String) -> Data? {
        guard let path = Bundle(for: JSONUtils.self).url(forResource: name, withExtension: "json") else {
            assertionFailure("JSON file not found")
            return nil
        }
        do {
            return try Data(contentsOf: path)
        } catch {
            assertionFailure("Invalid JSON")
            return nil
        }
    }
}
