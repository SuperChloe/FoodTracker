//
//  SignupViewController.swift
//  FoodTracker
//
//  Created by Chloe on 2016-02-15.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var picButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signUp() {
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        let imageData = UIImageJPEGRepresentation(picView.image!, 1.0)
        let file = PFFile(data: imageData!)
        user["profilePic"] = file
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                //Show the errorString somewhere and let the user try again
            } else {
                //Segue to app
            }
        }
    }
    
// MARK: Buttons

    @IBAction func changePic(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pressedSignup(sender: UIButton) {
        signUp()
    }
    
    // MARK: Image Picker
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picView.contentMode = .ScaleAspectFit
            picView.image = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
