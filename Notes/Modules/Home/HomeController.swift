//
//  HomeController.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 29.02.2024.
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
