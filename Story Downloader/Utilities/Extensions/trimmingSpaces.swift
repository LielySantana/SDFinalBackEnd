//
//  trimmingSpaces.swift
//  Story Downloader
//
//  Created by Christina Santana on 30/12/22.
//

import Foundation

extension String {
    func trimmingAllSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return components(separatedBy: characterSet).joined()
    }
}
