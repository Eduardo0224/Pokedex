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
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationItem.searchController = searchController
        navigationItem.title = title
    }

    func setupNavigationBar(withTitle title: String, andLeftAction leftBarButtonAction: @escaping () -> Void) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow_down").withRenderingMode(.alwaysOriginal), style: .plain, action: leftBarButtonAction)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = title
        guard let futuraBTLightFont = UIFont(name: "Avenir-Book", size: 20) else { return }
        let foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let titleAttributes = [NSAttributedString.Key.font : futuraBTLightFont, NSAttributedString.Key.foregroundColor : foregroundColor]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
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

extension UIViewController {
    class func instantiateFromStoryboard<T: UIViewController>(_ name: StoryBoard) -> T {
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
    }
}

extension UIViewController {
    func sendAction(of events: UIControl.Event, to controls: UIControl...) {
        controls.forEach { (control) in
            control.sendActions(for: events)
        }
    }
}
