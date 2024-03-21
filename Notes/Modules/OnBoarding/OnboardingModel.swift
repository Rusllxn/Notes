//
//  OnboardingModel.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 21.03.2024.
//

import UIKit

protocol OnboardingModelProtocol {
    func getTitles()
    func getSubtitles()
    func getImages()
}

class OnboardingModel: OnboardingModelProtocol {
    
    private let controller: OnboardingControllerProtocol?
    
    init(controller: OnboardingControllerProtocol?) {
        self.controller = controller
    }
    
    private let images: [UIImage] = [UIImage(named: "logo1")!, UIImage(named: "logo2")!, UIImage(named: "logo3")!]
    private let titles: [String] = ["Welcome to The Note", "Set Up Your Profile", "Dive into The Note"]
    private let subtitles: [String] = ["Welcome to The Note – your new companion for tasks, goals, health – all in one place. Let's get started!",
                                       
                                       "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals.",
                                       
                                       "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go!"]
    
    func getTitles() {
        controller?.onSuccessTitles(titles: titles)
    }
    
    func getSubtitles() {
        controller?.onSuccessSubtitles(subtitles: subtitles)
    }
    
    func getImages() {
        controller?.onSuccessImages(images: images)
    }
}

