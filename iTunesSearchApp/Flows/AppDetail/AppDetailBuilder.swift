//
//  AppDetailBuilder.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 13.05.2021.
//

import UIKit

class AppDetailBuilder {
    
    static func build(with app: ITunesApp) -> (UIViewController & AppDetailViewInput) {
        let presenter = AppDetailPresenter()
        let viewController = AppDetailViewController(presenter: presenter, app: app)
        presenter.viewInput = viewController
        
        return viewController
    }
}
