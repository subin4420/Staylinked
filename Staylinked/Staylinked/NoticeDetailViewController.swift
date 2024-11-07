//
//  NoticeDetailViewController.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/06/03.
//

import Foundation
import UIKit

class NoticeDetailViewController: UIViewController{
    var noticeDetail: Notice?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let detail = noticeDetail else {return}
        titleLabel.text = "\(detail.title)"
        dateLabel.text = "\(detail.Date)"
        contentLabel.text = "\(detail.content)"
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)

    }
    
}
