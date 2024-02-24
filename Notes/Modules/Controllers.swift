//
//  Controllers.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 24.02.2024.
//

import UIKit

protocol HomeControllerProtocol {
    func onGetNotes()
    
    func onSuccessNotes(notes: [String])
}

class HomeController: HomeControllerProtocol {
   
    private var view: HomeViewProtocol?
    private var model: HomeModelProtocol?
    
    init(view: HomeViewProtocol) {
        self.view = view
        self.model = HomeModel(controller: self)
    }
    
    func onGetNotes() {
        model?.getNotes()
    }
    
    func onSuccessNotes(notes: [String]) {
        view?.successNotes(notes: notes)
    }
}

protocol SettingsControllerProtocol {
    func onGetTitles()
    func onGetImages()
    
    func onSuccessTitles(titles: [String])
    func onSuccessImages(images: [UIImage])
        
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
}
