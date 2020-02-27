//
//  ViewController.swift
//  Random Image Generator
//
//  Created by admin on 2/27/20.
//  Copyright © 2020 Brandon Goldman Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var randomImageView: UIImageView!

    @IBOutlet weak var widthField: UITextField!
    
    @IBOutlet weak var heightField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        generateLogic()
    }
    
    func getImage() {
        let h = Int(randomImageView.frame.size.height)
        let w = Int(randomImageView.frame.size.width)
        let baseURL = "https://picsum.photos"
        let fullURL = "\(baseURL)/\(w)/\(h)"
        if let url = URL.init(string: fullURL) {
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in DispatchQueue.main.async {
                    self.randomImageView.image = UIImage.init(data: data!)
                }
            }
            task.resume()
        }
    }
    
    @IBAction func showDetails(_ sender: Any) {
        let h = Int(randomImageView.frame.size.height)
        let w = Int(randomImageView.frame.size.width)
        // create the alert
        let alert = UIAlertController(title: "Photo Details", message: "Width: \(w) \n Height: \(h)", preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func generateLogic() {
        // user input
        let myHeight = Int(heightField.text ?? "500") ?? 500
        let myWidth = Int(widthField.text ?? "300") ?? 300
        
        // hide keyboard
        view.endEditing(true)

        // dynamically change imageview
        let screenSize = UIScreen.main.bounds
        let screenWidth = Int(screenSize.width) - (myWidth)
        let screenHeight = Int(screenSize.height) - (myHeight)
        
        randomImageView.frame = CGRect(x: (screenWidth)/2, y: (screenHeight)/2, width: myWidth, height: myHeight)
        
        getImage()
    }
    
    @IBAction func randomImgBtn(_ sender: Any) {
        generateLogic()
    }
}

