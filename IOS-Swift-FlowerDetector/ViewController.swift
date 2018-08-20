//
//  ViewController.swift
//  IOS-Swift-FlowerDetector
//
//  Created by Pooya on 2018-05-29.
//  Copyright © 2018 Pooya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // MARK: Properties
    let model = FlowerClassifier()
    
    // MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prediction: UILabel!
    
    // MARK: UIView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(lhs: randRange(lower: 1, upper: 22))
    }

    private func setup(lhs:Int) {
        
        let flowername = "flower" + String(format:"%03d",lhs) + ".jpg"
        
        let file = flowername // "flower001.jpg" //"rose.jpg"
        let image = UIImage(named: file)!
        
        let buffer = image.buffer()!
        guard let output = try? model.prediction(data: buffer) else {
            print("failed")
            return
        }
        
        let proba = Int(output.prob[output.classLabel]!*100)
        
        imageView.image = image
        prediction.text = "I think it's a \(output.classLabel) at \(proba)%"
        
    }
    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    
    
    @IBAction func nextBtn(_ sender: UIButton) {
        
        setup(lhs: randRange(lower: 1, upper: 22))
        
    }
    
    
    
    
}


