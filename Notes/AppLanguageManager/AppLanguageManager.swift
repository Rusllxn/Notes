//
//  AppLanguageManager.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 22.03.2024.
//

import Foundation

enum LanguageType: String {
    case kg = "ky-KG"
    case ru = "ru"
    case en = "en"
}

class AppLanguageManager {
    static let shared = AppLanguageManager()
    
    private var currentLanguage: LanguageType?
    
    private var currentBundle: Bundle = Bundle.main
    
    var bundle: Bundle {
        return currentBundle
    }
    
    func setAppLanguage(language: LanguageType) {
        setCurrentLanguage(language: language)
        setCurrentBundlePath(languageCode: language.rawValue)
    }
    
    private func setCurrentLanguage(language: LanguageType) {
        currentLanguage = language
        // TODO: добавить сохранение в userDefaults
    }
    
    private func setCurrentBundlePath(languageCode: String) {
        guard let bundle = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let languageBundle = Bundle(path: bundle) else {
            currentBundle = Bundle.main
            return
        }
        currentBundle = languageBundle
    }
}

extension String {
    func localized() -> String {
        let bundle = AppLanguageManager.shared.bundle
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: "", comment: "")
    }
}
