//
//  ReservationViewController.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/04/28.
//

import UIKit
import FirebaseDatabase

class ReservationViewController: UIViewController{
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var reservationButton: UIButton!
    @IBOutlet weak var reserveDatePicker: UIDatePicker!
    //날짜를 정하면 그 날짜를 서버 reservation.json에 예약 추가하기
    //이전 날짜 선택되면 안되게
    let databaseRef = Database.database().reference()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    @IBAction func reservationButtonTapped(_ sender: UIButton) {
        let selectedDate = reserveDatePicker.date
        let currentPId = UserManager.shared.currentPatientId

        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: selectedDate)
        if let hour = components.hour {
            if hour >= 9 && hour <= 18 {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .short
                let formattedDate = dateFormatter.string(from: selectedDate)
                if let unwrappedPId = currentPId {
                    let reservationRef = databaseRef.child("patients").child("patient\(unwrappedPId)").child("appointmentDate")
                                reservationRef.setValue(formattedDate) { (error, ref) in
                                    if let error = error {
                                        print("Failed to save reservation: \(error.localizedDescription)")
                                    } else {
                                        print("Reservation saved successfully.")
                                    }
                                }
                }
                print("Selected date: \(formattedDate)")
                infoLabel.text = "\(formattedDate)으로 예약 되었습니다."

            } else {
                infoLabel.text = "예약은 9시부터 18시까지 가능합니다."
                
            }
        }
    }
}
