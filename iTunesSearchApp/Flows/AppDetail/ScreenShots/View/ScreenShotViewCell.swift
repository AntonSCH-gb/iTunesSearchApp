//
//  ScreenShotViewCell.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 11.05.2021.
//

import UIKit

class ScreenShotViewCell: UICollectionViewCell {
    
    // MARK: - Subviews
    
    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // MARK: - Init

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
//        clipsToBounds = true
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    
    func configure (with image: UIImage){
        self.imageView.image = image
    }
    
    // MARK: - UI
    
    func configureUI() {
        self.contentView.backgroundColor = .lightGray
        self.contentView.addSubview(imageView)
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }


    override func prepareForReuse() {
        self.imageView.image = nil
    }
    
}

