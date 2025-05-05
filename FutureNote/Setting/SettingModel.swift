//
//  SettingModel.swift
//  FutureNote
//
//  Created by Other on 29/4/25.
//

import Foundation

enum SettingModel: CaseIterable {
    case language
    case rate
    case contact
    case checkUpdate
    case restore
    
    var name: String {
        switch self {
        case .language:
            R.string(bundle: LocalizationManager.shared.bundle).localizable.language_setting_other()
        case .rate:
            R.string(bundle: LocalizationManager.shared.bundle).localizable.rate_setting()
        case .contact:
            R.string(bundle: LocalizationManager.shared.bundle).localizable.contace_setting()
        case .checkUpdate:
            R.string(bundle: LocalizationManager.shared.bundle).localizable.check_update()
        case .restore:
            R.string(bundle: LocalizationManager.shared.bundle).localizable.restore()
        }
    }
}
