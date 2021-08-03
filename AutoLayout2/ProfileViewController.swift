//
//  ViewController.swift
//  AutoLayout2
//
//  Created by Yash on 20/07/21.
//

import UIKit

class ProfileViewController: UIViewController{

    var vm = ProfileViewModel()

    @IBOutlet weak var Male: UIButton!
    @IBOutlet weak var Female: UIButton!
    @IBOutlet weak var Others: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDate()
    }
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func genderSelected(_ sender: UIButton) {
        Male.setImage(UIImage(named: vm.people[0]), for: .normal)
        Male.layer.borderWidth = 0
        Male.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        Female.setImage(UIImage(named: vm.people[1]), for: .normal)
        Female.layer.borderWidth = 0
        Female.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        Others.setImage(UIImage(named: vm.people[2]), for: .normal)
        Others.layer.borderWidth = 0
        Others.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        vm.setGender(strGender: (sender.titleLabel?.text!)!)
        sender.setImage(UIImage(named: vm.getImgName()), for: .normal)
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor(red: 0/255, green: 150/255, blue: 100/225, alpha: 1).cgColor
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        configureTapGesture()
        updateDate()
        vm.setGender(strGender: vm.people[0])
    }
    
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        view.endEditing(true)
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailsViewController
        destinationVC.strDate = vm.person.bdayDate!
        destinationVC.strGender = vm.person.gender
        destinationVC.nameText = vm.person.name
    }
    
    func updateDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        vm.setDate(date: dateFormatter.string(from: self.datePicker.date))
    }
}

extension ProfileViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        vm.person.name = textField.text
    }
}
