//
//  UIImageView+Extensions.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

extension UIImageView {

    func downloadAvatar(from id: Int) {
        if let url = PokedexAPI.Endpoints.getPokemonLargeImage(String(id)).url {
            downloadImage(fromURL: url)
        }
    }

    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        downloadImage(fromURL: url)
    }

    private func downloadImage(fromURL url: URL) {
        self.activityIndicator.startAnimating()
        self.image = nil
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.callInMainThread {
                    self.removeIndicator()
                }
            }
            if let data = data {
                self.callInMainThread {
                    self.removeIndicator()
                    self.image = UIImage(data: data)
                }
            }
            self.callInMainThread {
                self.removeIndicator()
            }
        }.resume()
    }

    private var activityIndicator: UIActivityIndicatorView {

        if let indicator = self.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
            return indicator
        }
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        activityIndicator.stopAnimating()
        self.addSubview(activityIndicator)
        return activityIndicator

    }

    private func removeIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }

    private func callInMainThread(_ completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            completion()
        }
    }
}
