import UIKit

class DetailsViewController: UIViewController{
    
    @IBOutlet weak var genderOfPerson: UILabel!
    @IBOutlet weak var nameOfPerson: UILabel!
    @IBOutlet weak var bdayOfPerson: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func setLabelTexts(strGender: String, strName: String, strBdayDate: String){
        genderOfPerson.text = strGender
        nameOfPerson.text = strName
        bdayOfPerson.text = strBdayDate
    }
}

