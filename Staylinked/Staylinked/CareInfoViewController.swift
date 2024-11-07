//
//  CareInfoViewController.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/04/28.
//

import UIKit
import FirebaseDatabase

class CareInfoViewController: UIViewController{
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var habitLabel: UILabel!
    @IBOutlet weak var avoidfoodLabel: UILabel!
    var ref: DatabaseReference! //firebase realtime database 의  루트

    //diseaseManagementTips.json 접근해
    //가지고 있는 기저질환 id에 맞는 관리 팁을 출력해준다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        ref = Database.database().reference().child("patients")
        // Firebase 실시간 데이터베이스의 "patients" 경로에 대한 쿼리 생성
        let currentPId = UserManager.shared.currentPatientId
        print("순서 1 \(currentPId)")
        if let unwCurPId = currentPId{
            ref.observe(.value) { (snapshot) in
                 guard let data = snapshot.value as? [String: Any] else {
                     // 데이터가 없거나 형식이 맞지 않는 경우 처리
                     print("순서 1.5")
                     return
                 }
                do {
                    print("순서 2")
                    // 데이터를 Data 형태로 변환
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    
                    // 데이터를 구조체 배열로 디코딩
                    let decoder = JSONDecoder()
                    
                    let patients = try decoder.decode([String: Patient].self, from: jsonData)
                    let filteredPatients = patients.filter { $0.value.patientId == unwCurPId }
                    
                    DispatchQueue.main.async {
                        print("순서 3")
                        for patient in filteredPatients.values{
                            print("patient.patientDiseaseInfo.diseaseId = \(patient.patientDiseaseInfo.diseaseId)")
                            UserManager.shared.currentDiseaseId = patient.patientDiseaseInfo.diseaseId
                            UserManager.shared.currentPatientName = patient.name
                            }
                        print("순서 4")
                        let diseaseId = UserManager.shared.currentDiseaseId
                        print("befor diseaseId == \(diseaseId)")
                        self.ref = Database.database().reference().child("diseaseManagementTips").child("diseaseManagementTips")
                        if let unwrappedDiseaseId = diseaseId {
                            print("순서 5")
                            print("unwrappedDiseaseId == \(unwrappedDiseaseId)")
                            self.ref.child("disease\(unwrappedDiseaseId)").observe(.value) { (snapshot) in
                                if let diseaseData = snapshot.value as? [String: Any] {
                                    guard let diseaseName = diseaseData["diseaseName"] else {return}
                                    guard let managementTips = diseaseData["managementTips"] else {return}
                                    guard let avoidFood = diseaseData["avoidFood"] else {return}
                                    if let Pname = UserManager.shared.currentPatientName {
                                        self.TitleLabel.text = "\(Pname)님 건강 관리 Tips"
                                        self.habitLabel.text = "\(managementTips)"
                                        self.subTitleLabel.text = "\(diseaseName) 관리방법"
                                        self.avoidfoodLabel.text = "\(avoidFood)"
                                    }
                                }
                                else {
                                    print("Error retrieving disease data")
                                    return
                                }
                            }
                        }
                        else {
                            print("error")
                            return
                        }
                        
                    }//DispatchQueue
                        //UserManager.shared.currentDiseaseId 이용해 tip에서 tip가져오고 디비에 피해야할음식 넣기
                        }//do
                 catch {
                     print("Error decoding JSON: \(error)")
                 }
                 
             }
        }
        }
    }
    
    


