//
//  ToastAttributes.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 10/09/1447 AH.
//

import Foundation
import ActivityKit
import SwiftUI

public struct ToastAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic data that can be updated while the toast is active
        public var title: String
        public var body: String
        public var systemIcon: String? // SF Symbol Icon
        
        public init(title: String, body: String, systemIcon: String? = nil) {
            self.title = title
            self.body = body
            self.systemIcon = systemIcon
        }
    }

    public var id: String
    
    public init(id: String = UUID().uuidString) {
        self.id = id
    }
}
