//
//  SettingsModel.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 24.02.2024.
//

import UIKit

protocol SettingsModelProtocol {
    func getTitles()
    func getImages()
    func getCellTexts()
}

class SettingsModel: SettingsModelProtocol {
    
    private let controller: SettingsControllerProtocol?
    
    init(controller: SettingsControllerProtocol?) {
        self.controller = controller
    }
    
    private let images : [UIImage] = [UIImage(systemName: "globe")!, UIImage(systemName: "moon")!, UIImage(systemName: "trash")!
    ]
    private let titles: [String] = ["Choose Language".localized(), "Dark Theme".localized(), "Clear Data".localized()]
    
    func getTitles() {
        controller?.onSuccessTitles(titles: titles)
    }
    
    func getImages() {
        controller?.onSuccessImages(images: images)
    }
    
    func getCellTexts() {
        let cellTexts: [String] = ["Choose Language".localized(), "Dark Theme".localized(), "Clear Data".localized()]
        controller?.onSuccessCellTexts(cellTexts: cellTexts)
    }
}

