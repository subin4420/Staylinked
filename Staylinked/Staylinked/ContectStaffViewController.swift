//
//  ContectStaffViewController.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/04/28.
//
import Foundation
import FirebaseDatabase
import UIKit
//FAI FAICell
class ContectStaffController: UITableViewController{
    var faiList: [FAI] = []
    var ref: DatabaseReference!
    //parksubin486@naver.com
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "FAICell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "FAICell")
        ref = Database.database().reference().child("frequentlyAskedInquiries")
            .child("frequentlyAskedInquiries")
        ref.observe(.value) {
            snapshot in guard let value = snapshot.value as? [String:[String: Any]] else {return}
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let noticeData = try JSONDecoder().decode([String: FAI].self, from: jsonData)
                let noticeList = Array(noticeData.values)
                self.faiList = noticeList.sorted{$0.inquiryId < $1.inquiryId}
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
            
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faiList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FAICell", for: indexPath) as? FAICell else {return UITableViewCell()}
        print(faiList[indexPath.row].title)
        cell.titleLabel.text = "\(faiList[indexPath.row].title)"
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "FaiDetailViewController") as? FaiDetailViewController else {return}
        
        detailViewController.faiDetail = faiList[indexPath.row]
        self.show(detailViewController, sender: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    

}
