//
//  UIAlertView.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 08/12/24.
//

import SwiftUI
import UIKit

struct AlertViewController: UIViewControllerRepresentable {
    var title: String
    var message: String
    var actions: [UIAlertAction]
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard uiViewController.presentedViewController == nil else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        uiViewController.present(alert, animated: true)
    }
}
