//
//  MemoReadVC.swift
//  MemberManagement
//
//  Created by 503-17 on 28/11/2018.
//  Copyright © 2018 the. All rights reserved.
//

import UIKit

class MemoReadVC: UIViewController {
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    //데이터를 넘겨받을 변수
    var memo : MemoVO?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.subject.text = memo?.title
        self.contents.text = memo?.contents
        self.img.image = memo?.image
        //self.navigationItem.title = "상세보기"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
