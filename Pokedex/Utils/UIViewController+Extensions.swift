//
//  UIViewController+Extensions.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

extension UIViewController: UIGestureRecognizerDelegate {
    func setupNavigationBar(withTitle title: String, and searchController: UISearchController) {
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationItem.searchController = searchController
        navigationItem.title = title
    }

    func alert(of error: PokedexAPI.NetworkError, hanlder: (() -> Void)? = nil) {
        var messageString: String?
        switch error {
            case .requestError(let message):
                messageString = message ?? "Ha habido un error con la petición"
            case .internalServerError:
                messageString = "Ha habido un error con el servidor, ¡Intenta de nuevo!"
            case .decodeError(let decodeMessage):
                messageString = decodeMessage
            case .unknown, .urlNil:
                messageString = "Ha habido un error desconocido"
        }
        let alert = UIAlertController(title: "Error", message: messageString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: { _ in hanlder?() }))
        present(alert, animated: true, completion: nil)
    }

    func show(indicator: UIActivityIndicatorView, in viewController: UIViewController) {
        viewController.view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
        viewController.view.isUserInteractionEnabled = false
    }

    func hide(indicator: UIActivityIndicatorView, in viewController: UIViewController) {
        indicator.removeFromSuperview()
        viewController.view.isUserInteractionEnabled = true
    }
}
