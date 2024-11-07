//
//  HealthInfoViewController.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/04/28.
//

import UIKit
import FirebaseDatabase


class HealthInfoViewController: UIViewController{
    var patientList: [Patient] = []
    var ref: DatabaseReference! //firebase realtime database 의  루트
    
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var medicalActionLabel: UILabel!
    //patients.json에 환자의 특이사항과 의료행위에서 내려 받아 라벨에 띄여주기
    //viewWillAppear됄 때 되면 될 듯
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.todayLabel.layer.cornerRadius = 10
        self.todayLabel.layer.masksToBounds = true
        self.todayLabel.text = "Hello"
        self.medicalActionLabel.layer.cornerRadius = 10
        self.medicalActionLabel.layer.masksToBounds = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUserEmail = UserManager.shared.currentUserEmail
        let currentGId = UserManager.shared.currentGuardianId
        let currentPId = UserManager.shared.currentPatientId
        
        
        ref = Database.database().reference().child("patients")
        print(ref)
        // Firebase 실시간 데이터베이스의 "patients" 경로에 대한 쿼리 생성
               ref.observe(.value) { (snapshot) in
                   guard let data = snapshot.value as? [String: Any]
                   else {
                       // 데이터가 없거나 형식이 맞지 않는 경우 처리
                       return
                   }
                   
                   do {
                       // 데이터를 Data 형태로 변환
                       let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                       
                       // 데이터를 구조체 배열로 디코딩
                       let decoder = JSONDecoder()
                       let patients = try decoder.decode([String: Patient].self, from: jsonData)
                       
                       // guardianId에 해당하는 환자 필터링
                       let filteredPatients = patients.filter { $0.value.guardianId == currentGId }
                       
                       // 가져온 데이터를 활용하여 필요한 작업 수행
                       DispatchQueue.main.async {
                           // filteredPatients 변수에 guardianId와 일치하는 환자 데이터가 저장됨
                           // filteredPatients 딕셔너리를 순회하면서 각 환자 데이터를 활용할 수 있음
                           for patient in filteredPatients.values {
                               print(patient)
                               self.todayLabel.textAlignment = .justified
                               self.todayLabel.text = patient.notes
                               self.medicalActionLabel.textAlignment = .left
                               self.medicalActionLabel.text = patient.medicalProcedure
                           }
                       }
                   } catch {
                       print("Error decoding JSON: \(error)")
                   }
               }
    }
}
