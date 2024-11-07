//
//  DietViewController.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/04/28.dd
//


import UIKit
import Kingfisher
import FirebaseDatabase


class DietViewController: UIViewController{
    @IBOutlet weak var underlyingConditionLabel: UILabel!
    @IBOutlet weak var allergyLabel: UILabel!
    var ref: DatabaseReference! //firebase realtime database 의  루트

    @IBOutlet weak var dietImageView: UIImageView!
    //환자의 기저질환 및 알러지를 라벨에 출력해주고
    //식단 이미지 받아와 출력하기
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var diseaseId: Int?
        navigationController?.navigationBar.isHidden = false
        let currentPId = UserManager.shared.currentPatientId
        ref = Database.database().reference().child("patients")
        // Firebase 실시간 데이터베이스의 "patients" 경로에 대한 쿼리 생성
        ref.observe(.value) { (snapshot) in
             guard let data = snapshot.value as? [String: Any] else {
                 // 데이터가 없거나 형식이 맞지 않는 경우 처리
                 return
             }
             do {
                 // 데이터를 Data 형태로 변환
                 let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                 
                 // 데이터를 구조체 배열로 디코딩
                 let decoder = JSONDecoder()
                 
                 let patients = try decoder.decode([String: Patient].self, from: jsonData)
                 let filteredPatients = patients.filter { $0.value.patientId == currentPId }
                 DispatchQueue.main.async {
                     for patient in filteredPatients.values{
                         print("patient.patientDiseaseInfo.diseaseId = \(patient.patientDiseaseInfo.diseaseId)")
                         diseaseId = patient.patientDiseaseInfo.diseaseId
                         self.allergyLabel.text = "알러지: \(patient.patientDiseaseInfo.allergy)"
                         self.underlyingConditionLabel.text = "기저질환: \(patient.patientDiseaseInfo.underlyingCondition)"
                     }
                     self.ref = Database.database().reference()
                     if let unwrappedDiseaseId = diseaseId {
                         self.ref.child("diseaseManagementTips").child("diseaseManagementTips").child("disease\(unwrappedDiseaseId)").observeSingleEvent(of: .value) { (snapshot) in
                                 print(snapshot)
                             if let diseaseData = snapshot.value as? [String: Any],
                                let diseaseURL = diseaseData["dietImageURL"] as? String {
                                 print("diseaseName: \(diseaseURL)")
                                 if let url = URL(string: diseaseURL) {
                                     self.dietImageView.kf.setImage(with: url)
                                 }
                             } else {
                                 print("Error retrieving disease data")
                             }
                         }
                     }
                     else {
                         print("error")
                         return
                     }
                 }
             } catch {
                 print("Error decoding JSON: \(error)")
             }
             
         }
    }
}

