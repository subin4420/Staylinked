//
//  noticeViewController.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/06/03.
//

import Foundation
import FirebaseDatabase

class NoticeViewController: UITableViewController{
    var noticeList: [Notice] = []
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        let nibName = UINib(nibName: "NoticeListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "NoticeListCell")
        ref = Database.database().reference().child("notices").child("notices")
        ref.observe(.value) {
            snapshot in guard let value = snapshot.value as? [String:[String: Any]] else {return}
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let noticeData = try JSONDecoder().decode([String: Notice].self, from: jsonData)
                let noticeList = Array(noticeData.values)
                self.noticeList = noticeList.sorted{$0.noticeId < $1.noticeId}
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
            
        }
        
    }
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeListCell", for: indexPath) as? NoticeListCell else {return UITableViewCell()}
        print(noticeList[indexPath.row].title)
        cell.titleLabel.text = "\(noticeList[indexPath.row].title)"
        cell.dateLabel.text = "\(noticeList[indexPath.row].Date)"
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "NoticeDetailViewController") as? NoticeDetailViewController else {return}
        
        detailViewController.noticeDetail = noticeList[indexPath.row]
        self.show(detailViewController, sender: nil)
    }
    
}
