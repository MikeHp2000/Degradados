//
//  ViewController.swift
//  Degradado2
//
//  Created by Miguel Angel Herrera Perez on 07/03/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [ UIColor.black.cgColor, UIColor.darkGray.cgColor ]
        newLayer.frame = view.frame
        
        view.layer.insertSublayer(newLayer, at: 0)
    }


}

