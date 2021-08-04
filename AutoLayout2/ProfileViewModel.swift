
class ProfileViewModel{
    var person = Person()
    let people = ["Male", "Female", "Others"]

    func setDate(date : String){
        person.bdayDate = date
    }
    
    func setGender(strGender: String){
        person.gender = strGender
    }
    
    func getImgName()-> String{
        return person.gender + "Selected"
    }
    
}
