import UIKit
import RealmSwift
class Person: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var birthday: String = ""
    
    convenience init(name: String, birthday: String) {
        self.init()
        self.name = name
        self.birthday = birthday
    }
}
let realm = try! Realm()//lấy instance
//Thêm dữ liệu vào Realm Database
let personA = Person(name: "Nguyễn Văn Trà",birthday: "22/03/2002")
let personB = Person(name: "Nguyễn Thị ABC",birthday: "01/01/2001")
try! realm.write {
    realm.add(personA)
        realm.add(personB)
    print("Success")
}
//Đọc dữ liệu
let realm = try! Realm()//khởi tạo đối tượng
let lists = realm.objects(Person.self)//ử dụng function .objects với model type là Person để lấy các object đã lưu
let persons = Array(lists)
print(persons)

//Cập nhật dữ liệu
let currentName = "Nguyễn Văn Trà" //currentName và currentBirthday được sử dụng để xác định đối tượng cần cập nhật dữ liệu
let currentBirthday = "22/03/2002"
let personFilter = realm.objects(Person.self).filter("name = %@ AND birthday = %@", currentName, currentBirthday)
//Function .filter dùng để thực hiện việc lọc dữ liệu được lưu trữ trong Realm Database.Ý nghĩa của câu query “name = %@ AND birthday = %@” như sau: Tìm các đối tượng có tên là currentName và có ngày sinh là currentBirthday
let personEdit = Array(personFilter).first
//Array(personFilter).first: Chuyển kiểu dữ liệu của biến personFilter sang Array, và lấy phần tử đầu tiên của nó
if let newPerson = personEdit {
  try! realm.write {
      newPerson.birthday = "08/01/2002"
  }
}
//.write để thực viện việc cập nhật dữ liệu mới
print(Array(realm.objects(Person.self)))

//Xoá dữ liệu
let currentName = "Nguyễn Văn Trà"
let currentBirthday = "08/01/2002"
let personFilter = realm.objects(Person.self).filter("name = %@ AND birthday = %@", currentName, currentBirthday)
try! realm.write {
    realm.delete(personFilter)
}
//trước tiên ta cũng cần select ra đối tượng đó và gọi Function .delete
print(Array(realm.objects(Person.self)))
