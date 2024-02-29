//
//  HomeModel.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 29.02.2024.
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
