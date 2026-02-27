//
//  LiveActivityManager.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 10/09/1447 AH.
//

import ActivityKit
import Foundation

@MainActor
public final class LiveActivityManager {
    public static let shared = LiveActivityManager()
    
    private var currentActivity: Activity<ToastAttributes>?
    
    private init() {}
    
    /// Starts a Live Activity in the native Dynamic Island
    @discardableResult
    public func start(title: String, body: String, systemIcon: String? = nil) -> String? {
        // Ensure Live Activities are supported and enabled by the user
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Live Activities are not enabled.")
            return nil
        }
        
        let attributes = ToastAttributes()
        let state = ToastAttributes.ContentState(title: title, body: body, systemIcon: systemIcon)
        
        // iOS 16.2+ syntax for starting activities
        let content = ActivityContent(state: state, staleDate: nil)
        
        do {
            currentActivity = try Activity.request(
                attributes: attributes,
                content: content,
                pushType: nil
            )
            return currentActivity?.id
        } catch {
            print("Error starting Live Activity: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Updates the existing Live Activity
    public func update(title: String, body: String, systemIcon: String? = nil) {
        guard let activity = currentActivity else { return }
        
        let newState = ToastAttributes.ContentState(title: title, body: body, systemIcon: systemIcon)
        let updatedContent = ActivityContent(state: newState, staleDate: nil)
        
        Task {
            await activity.update(updatedContent)
        }
    }
    
    /// Ends the Live Activity
    public func end(dismissalPolicy: ActivityUIDismissalPolicy = .default) {
        guard let activity = currentActivity else { return }
        
        Task {
            await activity.end(nil, dismissalPolicy: dismissalPolicy)
            currentActivity = nil
        }
    }
}
