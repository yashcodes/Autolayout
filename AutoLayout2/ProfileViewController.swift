//
//  ViewController.swift
//  AutoLayout2
//
//  Created by Yash on 20/07/21.
//

import UIKit

class ProfileViewController: UIViewController{

    var vm = ProfileViewModel()

    @IBOutlet weak var male: UIControl!
    @IBOutlet weak var female: UIControl!
    @IBOutlet weak var others: UIControl!
    
    @IBOutlet weak var nextButton: UIButton!

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDate()
    }
    
    @IBOutlet weak var nameField: UITextField!
    
    
    @objc func genderSelected(_ sender: UIControl) {
    
        male.subviews.compactMap{$0 as? UIImageView}[0].image = UIImage(named: vm.people[0])
        male.layer.borderWidth = 0
        male.subviews.compactMap{$0 as? UILabel}[0].font = UIFont.systemFont(ofSize: 17)
        
        female.subviews.compactMap{$0 as? UIImageView}[0].image = UIImage(named: vm.people[1])
        female.layer.borderWidth = 0
        female.subviews.compactMap{$0 as? UILabel}[0].font = UIFont.systemFont(ofSize: 17)
        
        others.subviews.compactMap{$0 as? UIImageView}[0].image = UIImage(named: vm.people[2])
        others.layer.borderWidth = 0
        others.subviews.compactMap{$0 as? UILabel}[0].font = UIFont.systemFont(ofSize: 17)
        
        let strGender = sender.subviews.compactMap{$0 as? UILabel}[0].text!
        vm.setGender(strGender: strGender)
        
        sender.subviews.compactMap{$0 as? UIImageView}[0].image = UIImage(named: vm.getImgName())
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor(red: 0/255, green: 150/255, blue: 100/225, alpha: 1).cgColor
        sender.subviews.compactMap{$0 as? UILabel}[0].font = UIFont.boldSystemFont(ofSize: 18)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        configureTapGesture()
        updateDate()
        vm.setGender(strGender: vm.people[0])
        male.addTarget(self, action: #selector(genderSelected(_:)), for: .touchUpInside)
        female.addTarget(self, action: #selector(genderSelected(_:)), for: .touchUpInside)
        others.addTarget(self, action: #selector(genderSelected(_:)), for: .touchUpInside)
        
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
        destinationVC.bdayOfPerson.text = vm.person.bdayDate!
        destinationVC.genderOfPerson.text = vm.person.gender
        destinationVC.nameOfPerson.text = vm.person.name
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
