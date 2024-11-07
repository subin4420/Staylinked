//
//  MainViewController.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/04/28.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
// 구조체 정의
struct Guardian: Codable {
    let age: Int
    let email: String
    let guardianId: Int
    let name: String
    let patientId: Int
    let phoneNumber: String
}


class UserManager {
    static let shared = UserManager()  // 싱글톤 인스턴스
    
    var currentUserEmail: String?  // 로그인한 사용자의 이메일
    var currentGuardianId: Int?
    var currentPatientId: Int?
    var currentDiseaseId: Int?
    var currentPatientName: String?
    private init() {}  // 외부에서 인스턴스 생성 방지
}

class MainViewController: UIViewController{
    var guardianList: [Guardian] = []

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do{
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError{
            print("ERROR: signout \(signOutError.description)")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var ref: DatabaseReference!
        navigationController?.navigationBar.isHidden = true
        if let userEmail = Auth.auth().currentUser?.email {
            UserManager.shared.currentUserEmail = userEmail
        }
        guard let currentUserEmail = Auth.auth().currentUser?.email else {return}
        print("currentUserEmail = \(currentUserEmail)")
        
        ref = Database.database().reference().child("guardians").child("guardians")
        // Firebase 실시간 데이터베이스의 "patients" 경로에 대한 쿼리 생성
       ref.observe(.value) { (snapshot) in
           guard let data = snapshot.value as? [String: Any] else {
               // 데이터가 없거나 형식이 맞지 않는 경우 처리
               print("데이터가 없거나 형식이 맞지 않는 경우 처리")
               return
           }
           
           do {
               // 데이터를 Data 형태로 변환
               let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
               
               // 데이터를 구조체 배열로 디코딩
               let decoder = JSONDecoder()
               let guardians = try decoder.decode([String: Guardian].self, from: jsonData)
               
               // guardianId에 해당하는 환자 필터링
               let filteredGuardian = guardians.filter { $0.value.email == currentUserEmail }
               
               // 가져온 데이터를 활용하여 필요한 작업 수행
               DispatchQueue.main.async {
                   // filteredPatients 변수에 guardianId와 일치하는 환자 데이터가 저장됨
                   // filteredPatients 딕셔너리를 순회하면서 각 환자 데이터를 활용할 수 있음
                   for guardian in filteredGuardian.values {
                       if let userEmail = Auth.auth().currentUser?.email {
                           UserManager.shared.currentGuardianId = guardian.guardianId
                           UserManager.shared.currentPatientId = guardian.patientId                           
                       }
                       self.welcomeLabel.text = "\(guardian.name) 님"
                       print("guardian email: \(guardian.email)")
                       print("guardian id: \(guardian.guardianId)")
                       print("guardian name: \(guardian.name)")
                       print("guardian's patientId: \(guardian.patientId)")
                       print("----------")
                   }
               }
               
               /*struct Guardian: Codable {
                let age: Int
                let email: String
                let guardianId: Int
                let name: String
                let patientId: Int
                let phoneNumber: String
            }*/
           } catch {
               print("Error decoding JSON: \(error)")
           }
       }
}




    
}
//}                    welcomeLabel.text = """
//\(guardain.name)보호자님
//"""
//parksubin486@naver.com
// Firebase Realtime Database 참조 생성


    
    

    

