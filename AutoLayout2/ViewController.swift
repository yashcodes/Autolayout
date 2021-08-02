//
//  ViewController.swift
//  AutoLayout2
//
//  Created by Yash on 20/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var gender = "No gender selected"
    var strDate = ""
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
            let dateFormatter = DateFormatter()

            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short

            strDate = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func genderSelected(_ sender: UIButton) {
        gender = sender.titleLabel?.text ?? "No gender selected"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView1.layer.cornerRadius = 10
        imgView1.clipsToBounds = true
        
        imgView2.layer.cornerRadius = 10
        imgView2.clipsToBounds = true
        
        imgView3.layer.cornerRadius = 10
        imgView3.clipsToBounds = true
        
        nextButton.layer.cornerRadius = 10
        nextButton.clipsToBounds = true
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailsViewController
        destinationVC.genderOfPerson.text = gender
        destinationVC.date.text = strDate
    }
}

