//
//  Models.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 24.02.2024.
//

import UIKit

protocol HomeModelProtocol {
    func getNotes()
}

class HomeModel: HomeModelProtocol {
   
    private let controller: HomeControllerProtocol?
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    private let notes: [String] = ["Do homework", "Buy chocolate", "Meet somebody", "Go to the gym!"]
    
    func getNotes() {
        controller?.onSuccessNotes(notes: notes)
    }
}

protocol SettingsModelProtocol {
    func getTitles()
    func getImages()
}

class SettingsModel: SettingsModelProtocol {
    
    private let controller: SettingsControllerProtocol?
    
    init(controller: SettingsControllerProtocol?) {
        self.controller = controller
    }
    
    private let images : [UIImage] = [UIImage(named: "language")!, UIImage(named: "moon")!, UIImage(named: "trash")!
    ]
    private let titles: [String] = ["Язык", "Темная тема", "Очистить данные"]
    
    func getTitles() {
        controller?.onSuccessTitles(titles: titles)
    }
    
    func getImages() {
        controller?.onSuccessImages(images: images)
    }
}
