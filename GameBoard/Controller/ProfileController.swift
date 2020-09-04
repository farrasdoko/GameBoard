//
//  ProfileController.swift
//  GameBoard
//
//  Created by Farras Doko on 17/08/20.
//  Copyright © 2020 dicoding. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    enum BarButtonState: String {
        case Edit, Done
    }

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editDescription: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cekSessionFirst()
        isEdit(false)
        
        editName.delegate = self
        editDescription.delegate = self
    }
    
    func cekSessionFirst() {
        if ProfileModel.name == "" {
            ProfileModel.name = name?.text ?? "Farras"
        } else {
            name.text = ProfileModel.name
        }
        if ProfileModel.desc == "" {
            ProfileModel.desc = desc?.text ?? " Description"
        } else {
            desc.text = ProfileModel.desc
        }
    }
    
    func isEdit(_ bool: Bool) {
        if bool {
            editName.isHidden = false
            editDescription.isHidden = false
            name.isHidden = true
            desc.isHidden = true
        } else {
            editName.isHidden = true
            editDescription.isHidden = true
            name.isHidden = false
            desc.isHidden = false
        }
    }
    
    @IBAction func editProfile(_ sender: UIBarButtonItem) {
        switch sender.title {
        case BarButtonState.Done.rawValue:
            isEdit(false)
            ProfileModel.name = editName.text ?? "Farras"
            ProfileModel.desc = editDescription.text ?? "Default description"
            name.text = editName.text
            desc.text = editDescription.text
            
            sender.title = "Edit"
        case BarButtonState.Edit.rawValue:
            isEdit(true)
            editName.text = name.text
            editDescription.text = desc.text
            
            sender.title = "Done"
            break
        default:
            break
        }
        
    }

}

extension ProfileController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
