//
//  ViewController.swift
//  Instagrid
//
//  Created by Nicolas Hecker on 15/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var selectedButton: UIButton?
    private var selectedImage: UIImage?
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    // Outlet
    @IBOutlet weak var delmLabel: UILabel!
    @IBOutlet weak var thirstyLabel: UILabel!
    @IBOutlet weak var pictureView: UIView!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    @IBOutlet weak var layout1Button: UIButton!
    @IBOutlet weak var layout2Button: UIButton!
    @IBOutlet weak var layout3Button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setLabel()
        
        //Swipe
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        guard let swipeGestureRecognizer else { return }
        pictureView.addGestureRecognizer(swipeGestureRecognizer)
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGestureRecognizer.direction = .left
        } else {
            swipeGestureRecognizer.direction = .up
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGestureRecognizer?.direction = .left
        } else {
            swipeGestureRecognizer?.direction = .up
        }
        setLabel()
    }
    
    private func setLabel() {
        delmLabel.font = UIFont(name: "delm-medium", size: 25.0)
        delmLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        thirstyLabel.font = UIFont(name: "ThirstySoftRegular", size: 30.0)
        thirstyLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    //Action
    @IBAction func showLayout(_ sender: UIButton) {
        [layout1Button, layout2Button, layout3Button].forEach { button in
            button?.isSelected = false
        }
        sender.isSelected = true
        switch sender.tag {
        case 0:
            topButton.isHidden = true
            bottomButton.isHidden = false
        case 1:
            topButton.isHidden = false
            bottomButton.isHidden = true
        case 2:
            topButton.isHidden = false
            bottomButton.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func pictureButton(_ sender: UIButton) {
        selectedButton = sender
        addPicture()
    }
    
    
    private func addPicture() {
        let picturePicker = UIImagePickerController()
        picturePicker.sourceType = .photoLibrary
        picturePicker.delegate = self
        present(picturePicker, animated: true)
    }
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if swipeGestureRecognizer?.direction == .up {
            animateGridView(x: 0, y: -self.view.frame.height)
        } else {
            animateGridView(x: -self.view.frame.width, y: 0)
        }
        sharePictureView()
    }
    
    private func sharePictureView() {
        if let image = pictureView.convertViewToImage() {
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            activityViewController.completionWithItemsHandler = { _, _, _, _ in
                UIView.animate(withDuration: 0.2) {
                    self.pictureView.transform = .identity
                    self.topButton.transform = .identity
                    self.bottomButton.transform = .identity
                    
                }
            }
            present(activityViewController, animated: true)
        }
    }
    
    private func animateGridView(x: CGFloat, y: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.pictureView.transform = CGAffineTransform(translationX: x, y: y)
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage, let button = selectedButton {
            button.setImage(selectedImage, for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
