//
//  LocalizationManager.swift
//  FutureNote
//
//  Created by Other on 19/4/25.
//

import Foundation
class LocalizationManager {
    static let shared = LocalizationManager()

    private init() {}

    var bundle: Bundle = .main

    var currentLanguage: String {
        get {
            UserDefaults.standard.string(forKey: "appLanguage") ?? Locale.preferredLanguages.first ?? "en"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "appLanguage")
            setLanguage(newValue)
        }
    }

    func setLanguage(_ lang: String) {
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj") else {
            bundle = Bundle.main
            return
        }
        bundle = Bundle(path: path) ?? .main
    }

    func localizedString(forKey key: String) -> String {
        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }
}
