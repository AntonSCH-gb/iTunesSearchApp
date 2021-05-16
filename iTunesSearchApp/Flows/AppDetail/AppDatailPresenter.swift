//
//  AppDatailPresenter.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 13.05.2021.
//

import Foundation

import UIKit
import Alamofire

protocol AppDetailViewInput: AnyObject {
    
    var app: ITunesApp { get set }
    func showError(error: Error)
    func setIcon(image: UIImage)
    func setScreenshots(screenShots: [UIImage])
}

protocol AppDetailViewOutput {
    func getAppIcon()
    func getScreenshots()
    func viewDidSelectScreenshot(number: Int, in array: [UIImage])
}

class AppDetailPresenter {
    
    private let imageDownloader = ImageDownloader()
    
    weak var viewInput: (UIViewController & AppDetailViewInput)?
    
    private func loadIcon() {
        guard let viewInput = viewInput, let url = viewInput.app.iconUrl else { return }
        
        self.imageDownloader.getImage(fromUrl: url){[weak self] image, error in
            guard let self = self else { return }
            
            if let image = image {
                self.viewInput?.setIcon(image: image)
            } else if let error = error {
                self.viewInput?.showError(error: error)
            }
        }
        
    }
    
    private func loadScreenshots() {
        guard let viewInput = viewInput else { return }
        
        var images: [UIImage] = []
        
        let dispatchGroup = DispatchGroup()
        
        for url in viewInput.app.screenshotUrls {
            dispatchGroup.enter()
            self.imageDownloader.getImage(fromUrl: url){ image, error in
                
                if let image = image {
                    images.append(image)
                    dispatchGroup.leave()
                } else {
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main){
            viewInput.setScreenshots(screenShots: images)
        }
        
    }
    
    private func openScreenShot(with app: ITunesApp) {
        //TODO
    }
}

extension AppDetailPresenter: AppDetailViewOutput {
    
    func getAppIcon() {
        loadIcon()
    }
    
    func getScreenshots() {
        loadScreenshots()
    }
    
    func viewDidSelectScreenshot(number: Int, in array: [UIImage]) {
        //TODO
    }
}
