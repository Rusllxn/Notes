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
}

class SettingsModel: SettingsModelProtocol {
    
    private let controller: SettingsControllerProtocol?
    
    init(controller: SettingsControllerProtocol?) {
        self.controller = controller
    }
    
    private let images : [UIImage] = [UIImage(systemName: "globe")!, UIImage(systemName: "moon")!, UIImage(systemName: "trash")!
    ]
    private let titles: [String] = ["Язык", "Темная тема", "Очистить данные"]
    
    func getTitles() {
        controller?.onSuccessTitles(titles: titles)
    }
    
    func getImages() {
        controller?.onSuccessImages(images: images)
    }
}
