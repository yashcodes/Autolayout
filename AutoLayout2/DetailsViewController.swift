import UIKit

class DetailsViewController: UIViewController{
    
    @IBOutlet weak var genderOfPerson: UILabel!
    @IBOutlet weak var nameOfPerson: UILabel!
    @IBOutlet weak var bdayOfPerson: UILabel!
    
    var strGender : String!
    var strDate : String!
    var nameText : String!
    
    override func viewDidLoad() {
        genderOfPerson.text = strGender
        bdayOfPerson.text = strDate
        nameOfPerson.text = nameText
    }
}

