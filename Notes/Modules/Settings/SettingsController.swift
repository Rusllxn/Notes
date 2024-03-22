//
//  SettingsController.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 24.02.2024.
//

import UIKit

protocol SettingsControllerProtocol {
    func onGetTitles()
    func onGetImages()
    func onGetCellTexts()
    
    func onSuccessTitles(titles: [String])
    func onSuccessImages(images: [UIImage])
    func onSuccessCellTexts(cellTexts: [String])
}

class SettingsController: SettingsControllerProtocol {
    
    private var view: SettingsViewProtocol?
    private var model: SettingsModelProtocol?
    
    init(view: SettingsViewProtocol) {
        self.view = view
        self.model = SettingsModel(controller: self)
    }
    
    func onGetTitles() {
        model?.getTitles()
    }
    
    func onSuccessTitles(titles: [String]) {
        view?.successTitles(titles: titles)
    }
    
    func onGetImages() {
        model?.getImages()
    }
    
    func onSuccessImages(images: [UIImage]) {
        view?.successImages(images: images)
    }
    
    func onGetCellTexts() {
        model?.getCellTexts()
    }
    
    func onSuccessCellTexts(cellTexts: [String]) {
        view?.successCellTexts(cellTexts: cellTexts)
    }
}

