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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            nameField.resignFirstResponder()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        updateDate()
        vm.setGender(strGender: vm.people[0])
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        view.endEditing(true)
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
    @IBSegueAction func makeDetailsVC(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> DetailsViewController? {
        return DetailsViewController(coder: coder, person: vm.person)
    }
    
}

//functions responding to textfield
extension ProfileViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        vm.person.name = textField.text ?? "Enter your name"
    }
}

// functions responding to the notification of keyboard appearing and disappear
extension ProfileViewController{
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
      
      self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      self.view.frame.origin.y = 0
    }
}

//functions to change appearences of gender buttons
extension ProfileViewController{
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
}

//functions responding to DatePicker
extension ProfileViewController{
    private func updateDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        vm.setDate(date: dateFormatter.string(from: self.datePicker.date))
    }
}
