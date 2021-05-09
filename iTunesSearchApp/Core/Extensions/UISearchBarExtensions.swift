//
//  UISearchBarExtensions.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 05.05.2021.
//

import UIKit

extension UISearchBar {

    public var textField: UITextField? {
        return self.searchTextField
    }

    public var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap{ $0 as? UIActivityIndicatorView }.first
    }
    
    private var searchIcon: UIImage? {
            let subViews = subviews.flatMap { $0.subviews }
            return  ((subViews.filter { $0 is UIImageView }).first as? UIImageView)?.image
        }

    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let leftViewSize = textField?.leftView?.frame.size ?? CGSize(width: 20, height: 20)
                    let newActivityIndicator = UIActivityIndicatorView(style: .medium)
                    newActivityIndicator.startAnimating()
                    let clearImage = UIImage().imageWithPixelSize(size: leftViewSize) ?? UIImage()
                    self.setImage(clearImage, for: .search, state: .normal)
                    textField?.leftViewMode = .always
                    textField?.leftView?.addSubview(newActivityIndicator)
                    newActivityIndicator.center = CGPoint(x: leftViewSize.width/2, y: leftViewSize.height/2)
                }
            } else {
                activityIndicator?.removeFromSuperview()
                self.setImage(searchIcon, for: .search, state: .normal)
            }
        }
    }
}
