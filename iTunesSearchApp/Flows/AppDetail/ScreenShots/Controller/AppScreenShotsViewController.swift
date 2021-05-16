//
//  AppScreenShotsViewController.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 07.05.2021.
//

import UIKit

class AppScreenShotsViewController: UIViewController {
    
    private struct Constants {
        static let reuseIdentifier = "reuseItemId"
        static let layoutInsets = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
    }
            
    private var images: [UIImage] = [] {
        didSet {
            if images.isEmpty {
                appScreenShotsView.throbberView(set: .error)
            } else {
                appScreenShotsView.throbberView(set: .success)
                appScreenShotsView.collectionView.reloadData()
            }
        }
    }
        
    private var appScreenShotsView: ScreenShotsView {
        return self.view as! ScreenShotsView
    }
    
    override func loadView() {
        self.view = ScreenShotsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appScreenShotsView.collectionView.register(ScreenShotViewCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        appScreenShotsView.collectionView.delegate = self
        appScreenShotsView.collectionView.dataSource = self
    }
    
    func startLoadingImages() {
        appScreenShotsView.throbberView(set: .loading)
    }
    
    func setScreenshots(images: [UIImage]) {
        self.images = images
    }
}

extension AppScreenShotsViewController: UICollectionViewDelegate {
    //TODO
}

extension AppScreenShotsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? ScreenShotViewCell else {
            return dequeuedCell
        }
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    
    
}

extension AppScreenShotsViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let maxSizeOfHorisontalImage = images.reduce(into: (maxHeight: CGFloat(0), maxWidth: CGFloat(0))){ result, image in
            if image.size.width > image.size.height && image.size.height > result.maxHeight {
                result = (image.size.height, image.size.width)
            }
        }
        
        guard maxSizeOfHorisontalImage != (0, 0) else { return Constants.layoutInsets }
        
        let bottomInset = appScreenShotsView.collectionView.bounds.height - Constants.layoutInsets.top - Constants.layoutInsets.bottom - maxSizeOfHorisontalImage.maxHeight
        
        var layoutInsets = Constants.layoutInsets
        layoutInsets.bottom = bottomInset
        
        return layoutInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellMaxHeight = collectionView.bounds.height - (Constants.layoutInsets.top + Constants.layoutInsets.bottom) * 2
        let cellMaxWidh = collectionView.bounds.width - (Constants.layoutInsets.left + Constants.layoutInsets.right) * 2
        
        guard cellMaxWidh > 0 && cellMaxHeight > 0 else { return CGSize(width: 0, height: 0)}
        
        let imageWithToHeightRatio = images[indexPath.item].size.width / images[indexPath.item].size.height
        var size: CGSize {
            if imageWithToHeightRatio <= 1 {
                let cellWith = cellMaxHeight * imageWithToHeightRatio
                return CGSize(width: cellWith, height: cellMaxHeight)
            } else {
                let cellHeight = cellMaxWidh / imageWithToHeightRatio
                return CGSize(width: cellMaxWidh, height: cellHeight)
            }
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.layoutInsets.left
    }
}
