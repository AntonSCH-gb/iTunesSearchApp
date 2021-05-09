//
//  AppCellModel.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 02.05.2021.
//

import Foundation

struct AppCellModel {
    let title: String
    let subtitle: String?
    let rating: String?
}

final class AppCellModelFactory {
    
    static func cellModel(from model: ITunesApp) -> AppCellModel {
        let ratingText = model.averageRating != nil ?
            "Rating: \((model.averageRating! * 10).rounded()/10)" :
            "Is no rating"
        return AppCellModel(title: model.appName,
                            subtitle: model.company,
                            rating: ratingText)
    }
}
