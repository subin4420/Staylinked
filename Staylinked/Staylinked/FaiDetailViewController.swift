//
//  FaiDetailViewController.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/06/09.
//

import Foundation
import UIKit

class FaiDetailViewController: UIViewController{
    var faiDetail: FAI?

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let detail = faiDetail else {return}
        titleLabel.text = "제목: \(detail.title)"
        answerLabel.text = "질문: \(detail.answer)"
        contentLabel.text = "답변: \(detail.content)"
    }


}

