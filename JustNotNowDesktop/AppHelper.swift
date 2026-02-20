//  AppHelper.swift
//  JustNotNowDesktop
//  Created by Holger Hinzberg on 20.02.26.

import Foundation

public struct AppHelper {
    
    public static func getWindowTitleWithVersion() -> String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return "Just Not Now - Version \(appVersion!)"
    }
    
}
