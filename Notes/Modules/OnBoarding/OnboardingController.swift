//
//  OnboardingController.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 21.03.2024.
//

import UIKit

protocol OnboardingControllerProtocol {
    func onGetTitles()
    func onGetSubtitles()
    func onGetImages()
    
    func onSuccessTitles(titles: [String])
    func onSuccessSubtitles(subtitles: [String])
    func onSuccessImages(images: [UIImage])
    
}

class OnboardingController: OnboardingControllerProtocol {
    
    private var view: OnboardingViewProtocol?
    private var model: OnboardingModelProtocol?
    
    init(view: OnboardingViewProtocol) {
        self.view = view
        self.model = OnboardingModel(controller: self)
    }
    
    func onGetTitles() {
        model?.getTitles()
    }
    
    func onSuccessTitles(titles: [String]) {
        view?.successTitles(titles: titles)
    }
    
    func onGetSubtitles() {
        model?.getSubtitles()
    }
    
    func onSuccessSubtitles(subtitles: [String]) {
        view?.successSubtitles(subtitles: subtitles)
    }
    
    func onGetImages() {
        model?.getImages()
    }
    
    func onSuccessImages(images: [UIImage]) {
        view?.successImages(images: images)
    }
}

