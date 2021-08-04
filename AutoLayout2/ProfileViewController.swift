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
    
    @IBAction func maleTapped(_ sender: UIControl) {
        configure(sender: sender, genderInt: 0)
    }
    
    @IBAction func femaleTapped(_ sender: UIControl) {
        configure(sender: sender, genderInt: 1)
    }
    
    @IBAction func othersTapped(_ sender: UIControl) {
        configure(sender: sender, genderInt: 2)
    }
    
    private func configure(sender : UIControl, genderInt : Int){
        resetButtonsConfiguration()
        vm.setGender(strGender: vm.people[genderInt])
        
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor(red: 0/255, green: 150/255, blue: 100/225, alpha: 1).cgColor
        
        let imageView = returnImageView(sender: sender)
                if let safeImageView = imageView{
                    safeImageView.image = UIImage(named: vm.getImgName())
                }
        let label = returnLabel(sender: sender)
                
        if let safeLabel = label{
                safeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
    
    private func resetButtonsConfiguration(){
        resetButtonProp(sender: male, imgName: vm.people[0])
        resetButtonProp(sender: female, imgName: vm.people[1])
        resetButtonProp(sender: others, imgName: vm.people[2])
    }
    
    
    private func resetButtonProp(sender : UIControl, imgName: String){
        let imgView = returnImageView(sender: sender)
        if let safeImgView = imgView{
            safeImgView.image = UIImage(named: imgName)
        }
        
        sender.layer.borderWidth = 0
        
        let label = returnLabel(sender: sender)
        if let safeLabel = label{
            safeLabel.font = UIFont.systemFont(ofSize: 17)
        }
    }

    private func returnImageView(sender: UIControl) -> UIImageView?{
        let images = sender.subviews.compactMap{$0 as? UIImageView}
        if images.count != 0{
            return images[0]
        }
        return nil
    }
    
    private func returnLabel(sender: UIControl) -> UILabel?{
        let labels = sender.subviews.compactMap{$0 as? UILabel}
        if labels.count != 0{
            return labels[0]
        }
        return nil
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
        destinationVC.setLabelTexts(strGender: vm.person.gender, strName: vm.person.name, strBdayDate: vm.person.bdayDate)
    }
    
    private func updateDate(){
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
        vm.person.name = textField.text ?? "Enter your name"
    }
}
