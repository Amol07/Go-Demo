//
//  UIView+Ext.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
}

typealias UIAlertControllerHandler = ( _ alertController: UIAlertController, _ selectedIndex: Int ) -> Void

extension UIViewController {
    func showAlert(title: String, message: String, buttonTitles: [String] = ["OK"], handler: UIAlertControllerHandler?) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionHandler = { action  -> Void in
            handler?( controller, controller.actions.firstIndex(of: action ) ?? -1 )
        }
        for title in buttonTitles[ 0..<buttonTitles.count ] {
            controller.addAction( UIAlertAction( title: title, style: .default, handler: actionHandler))
        }
        self.present(controller, animated: true, completion: nil)
    }
}

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 3.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
