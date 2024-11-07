//
//  QnAViewControll.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/06/03.
//
// 직접 문의하기
// 문의 제목 문의 내용
import Foundation
import UIKit
import FirebaseDatabase

class QnAViewController: UIViewController{
    @IBOutlet weak var successLabel: UILabel!
    //문의디비에 추가하는 기능
    //직접문의한 경우 답변을 볼 수 있는 기능도 구현해야한다.
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextField: UITextField!
    var inputValue: String?
    let databaseRef = Database.database().reference()
    
    @IBAction func inputButtonTapped(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        guard let title = titleTextField.text else {return}
        guard let content = contentTextField.text else {return}
        let reservationRef = databaseRef.child("inquiries").child("inquiries")
        reservationRef.observeSingleEvent(of: .value) { (snapshot) in
            let inquiryCount = snapshot.childrenCount
            let newInquiryId = inquiryCount + 1
            let newInquiryData: [String: Any] = [
                "content": content,
                "guardianId": UserManager.shared.currentGuardianId!,
                "inquiryDate": currentDate,
                "inquiryId": newInquiryId,
                "title": title
            ]
            let newInquiryRef = reservationRef.child("inquiry\(newInquiryId)")
            newInquiryRef.setValue(newInquiryData) { (error, _) in
                if let error = error {
                    self.successLabel.text = "Failed to add new inquiry: \(error.localizedDescription)"
                    print("Failed to add new inquiry: \(error.localizedDescription)")
                } else {
                    self.addButton.isEnabled = false
                    self.successLabel.text = "New inquiry added successfully."
                    print("New inquiry added successfully.")
                }
            }
        }
        
    }
}
