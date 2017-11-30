//
//  ViewController.swift
//  ConcurrencyNASA
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var spaceImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spiner.isHidden = true
    }
    
    @IBAction func loadImageButtonPressed(_ sender: UIButton) {
        loadImage()
    }
    
    func loadImage() {
        let urlStr = "https://www.nasa.gov/sites/default/files/thumbnails/image/14797031062_4cbe0f218f_o.jpg"
        guard let url = URL(string: urlStr) else {return}
        self.spiner.startAnimating()
        self.spiner.isHidden = false
        DispatchQueue.global().async {
            guard let rawImageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                guard let onlineImage = UIImage(data: rawImageData) else {return}
                self.spaceImageView.image = onlineImage
                print("Just set image")
                self.spiner.stopAnimating()
                self.spiner.isHidden = true
            }
            print("Just dispatched to main queue")
        }
        print("Just dispatched to Global queue")
    }
}

