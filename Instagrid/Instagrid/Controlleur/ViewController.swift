//
//  ViewController.swift
//  Instagrid
//
//  Created by Nicolas Hecker on 15/06/2023.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // Outlet
    @IBOutlet weak var delmLabel: UILabel!
    @IBOutlet weak var thirstyLabel: UILabel!
    @IBOutlet weak var Layout1: UIButton!
    @IBOutlet weak var Layout2: UIButton!
    @IBOutlet weak var Layout3: UIButton!
    
    @IBOutlet weak var buttonTopLeft: UIButton!
    @IBOutlet weak var ButtonTop: UIButton!
    
    @IBOutlet weak var buttonBottomLeft: UIButton!
    @IBOutlet weak var ButtonBottom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        delmLabel.font = UIFont(name: "delm-medium", size: 25.0)
        delmLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        thirstyLabel.font = UIFont(name: "ThirstySoftRegular", size: 30.0)
        thirstyLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    @IBAction func showLayout1(_ sender: Any) {
        ButtonTop.isHidden = true
        ButtonBottom.isHidden = false
        Layout1.isSelected = true
        Layout2.isSelected = false
        Layout3.isSelected = false
    }
    @IBAction func showLayout2(_ sender: Any) {
        ButtonTop.isHidden = false
        ButtonBottom.isHidden = true
        Layout1.isSelected = false
        Layout2.isSelected = true
        Layout3.isSelected = false
    }
    @IBAction func showLayout3(_ sender: Any) {
        ButtonTop.isHidden = false
        ButtonBottom.isHidden = false
        Layout1.isSelected = false
        Layout2.isSelected = false
        Layout3.isSelected = true
    }
    @IBAction func pictureButton(_ sender: Any) {
        addPicture()
    }
    
    
    private func addPicture() {
        let picturePicker = UIImagePickerController()
        picturePicker.sourceType = .photoLibrary
        picturePicker.delegate = self
        present(picturePicker, animated: true, completion: nil)
        
    }
    
}

