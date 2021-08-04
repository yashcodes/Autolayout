import UIKit

class DetailsViewController: UIViewController{
    
    @IBOutlet weak var genderOfPerson: UILabel!
    @IBOutlet weak var nameOfPerson: UILabel!
    @IBOutlet weak var bdayOfPerson: UILabel!
    
    let person : Person
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelTexts()
    }
    
    init?(coder: NSCoder, person : Person){
        self.person = person
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setLabelTexts(){
        genderOfPerson.text = person.gender
        nameOfPerson.text = person.name
        bdayOfPerson.text = person.bdayDate
    }
}

