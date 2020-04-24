//
//  UIViewController+Helpers.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 10/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertController(title: String,
                             message: String,
                             actionText: String,
                             action: @escaping () -> Void) {
        guard presentedViewController == nil else {
            return
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let retryAction = UIAlertAction(title: actionText, style: .default, handler: { _ in
            action()
        })
        alertController.addAction(retryAction)
        present(alertController, animated: true, completion: nil)

    }
}
