//
//  SideBarVC.swift
//  MemberManagement
//
//  Created by 503-17 on 30/11/2018.
//  Copyright © 2018 the. All rights reserved.
//

import UIKit

class SideBarVC: UITableViewController {
    let titles = ["메모 작성", "친구 새글", "달력 보기",
                  "공지사항", "통계", "계정 관리"]
    let icons = [UIImage(named: "icon01.png"),
                 UIImage(named: "icon02.png"),
                 UIImage(named: "icon03.png"),
                 UIImage(named: "icon04.png"),
                 UIImage(named: "icon05.png"),
                 UIImage(named: "icon06.png")]
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = UIColor.brown
        self.tableView.tableHeaderView = headerView
        
        nameLabel.frame = CGRect(x: 70, y: 15, width: 120, height: 30)
        nameLabel.text = "raccoongury"
        nameLabel.textColor = UIColor.white
        self.nameLabel.backgroundColor = UIColor.clear
        headerView.addSubview(nameLabel)
        
        emailLabel.frame = CGRect(x: 70, y: 30, width: 120, height: 30)
        emailLabel.text = "raccoongury@gmail.com"
        emailLabel.textColor = UIColor.white
        self.emailLabel.backgroundColor = UIColor.clear
        headerView.addSubview(emailLabel)
        
        let defaultProfile = UIImage(named: "account.jpg")
        profileImage.image = defaultProfile
        profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        //네모난 이미지 뷰를 등글게 만들기
        profileImage.layer.cornerRadius = (profileImage.frame.width/2)
        profileImage.layer.borderWidth = 0
        profileImage.layer.masksToBounds = true
        headerView.addSubview(profileImage)
        
    }

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let id = "MenuCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        
        return cell
    }
    
    //셀의 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let uv = self.storyboard?.instantiateViewController(withIdentifier:"MemoFormVC") as! MemoFormVC
            //사이드 바의 네비게이션 컨트롤러를 찾아오기
            let target = self.revealViewController().frontViewController as! UINavigationController
            //화면 출력
            target.pushViewController(uv, animated:true)
            //사이드 바 제거
            self.revealViewController().revealToggle(self)
            
        }else if indexPath.row == 5{
            let uv = self.storyboard?.instantiateViewController(withIdentifier:"ProfileVC") as! ProfileVC
            let target = self.revealViewController().frontViewController as! UINavigationController
            //화면 출력
            target.pushViewController(uv, animated:true)
            //사이드 바 제거
            self.revealViewController().revealToggle(self)
        }
    }
    
}
