//
//  AppDetailHeaderViewController.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 02.05.2021.
//

import UIKit

class AppDetailHeaderViewController: UIViewController {
    
    private let app: ITunesApp
    
    private var appDetailHeaderView: AppDetailHeaderView {
        return self.view as! AppDetailHeaderView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congureUI()
    }
    
    func setIcon(image: UIImage){
        appDetailHeaderView.imageView.image = image
    }
    
    private func congureUI() {

        appDetailHeaderView.titleLabel.text = app.appName
        appDetailHeaderView.subtitleLabel.text = app.company
        
        let ratingString = app.averageRating != nil ?
            "Rating: \((app.averageRating! * 10).rounded()/10)" :
            "Is no rating"
        
        appDetailHeaderView.ratingLabel.text = "\(ratingString)"
        
        fillRatingStars(app.averageRating)
    }
    
    private func fillRatingStars(_ rating: Double?) {
        
        guard let view = self.view as? AppDetailHeaderView,
              let rating = rating,
              let stars = view.starsView.subviews as? [UIImageView]
        else { return }
        
        var i = ((rating * 10).rounded())/10
        
        for star in stars {
            switch i {
            case 1...5:
                star.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
                i -= 1
            case 0.1..<1:
                star.image = UIImage(systemName: "star.leadinghalf.fill")?.withRenderingMode(.alwaysTemplate)
                i -= 1
            default:
                break
            }
        }
    }
}
