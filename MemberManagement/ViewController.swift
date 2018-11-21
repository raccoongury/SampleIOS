//
//  ViewController.swift
//  MemberManagement
//
//  Created by 503-17 on 21/11/2018.
//  Copyright © 2018 the. All rights reserved.
//

import UIKit

import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var loginbtn: UIButton!
    
    //AppDelegate 객체에 대한 참조 변수
    var appDelegate : AppDelegate!
    
    
    @IBAction func login(_ sender: Any) {
        if loginbtn.title(for: .normal) == "로그인"{
            
            //로그인 대화상자 생성
            let alert = UIAlertController(title: "로그인", message: nil, preferredStyle: .alert)
            //대화상자에 입력을 받을 수 있는 텍스트 필드를 2개 추가
            alert.addTextField(){(tf) in tf.placeholder = "아이디를 입력하세요"}
            alert.addTextField() {(tf) in tf.placeholder = "비밀번호를 입력하세요"
                tf.isSecureTextEntry = true
            }
            //버튼 생성
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            alert.addAction(UIAlertAction(title: "로그인", style: .default){
                (_) in
                //입력한 id 와 pw를 가져오기
                let id = alert.textFields![0].text
                let pw = alert.textFields![1].text
                //웹에 요청
                let request = Alamofire.request("http://192.168.0.116:8080/server/member/login?id=\(id!)&pw=\(pw!)", method:.get, parameters:nil)
                //결과 사용
                request.responseJSON{
                    response in
                    //결과 확인
                    //print(response.result.value!)
                    if let jsonObject = response.result.value as? [String:Any]{
                        //result 키의 내용 가져오기
                        let result = jsonObject["result"] as! NSDictionary
                        let id = result["id"] as! NSString
                        if id == "NULL"{
                            self.title = "로그인 실패"
                        }else{
                            //로그인 성공했을 때 로그인 정보 저장
                            self.appDelegate.id = id as String
                            self.appDelegate.nickname =
                                (result["nickname"] as! NSString) as String
                            self.appDelegate.image =
                                (result["image"] as! NSString) as String
                            
                            self.title = "\(self.appDelegate.nickname!)님 로그인"
                            
                            //image 에 저장된 데이터로 서버에서 이미지를 다운로드 받아 타이틀로 설정
                            let request = Alamofire.request("http://192.168.0.116:8080/server/images/\(self.appDelegate.image!)", method:.get, parameters:nil)
                            request.response{
                                response in
                                //다운로드 받은 데이터를 가지고 image 생성
                                let image = UIImage(data:response.data!)
                                //이미지를 출력하기 위해서 ImageView 만들기
                                let imageView = UIImageView(frame:CGRect(x:0, y:0, width:40, height:40))
                                imageView.contentMode = .scaleAspectFit
                                imageView.image = image
                                //네비게이션 바에 배치
                                self.navigationItem.titleView = imageView
                            }
                            
                            self.loginbtn.setTitle("로그아웃", for:.normal)
                        }
                    }
                }
            })
            
            
            //로그인 대화상자를 출력
            self.present(alert, animated: true)
        }else{
            //로그인 정보를 삭제
            appDelegate.id = nil
            appDelegate.nickname = nil
            appDelegate.image = nil
            //네비게이션 바의 타이틀과 버튼의 타이틀을 변경
            self.title = "로그인이 안 된 상태"
            loginbtn.setTitle("로그인", for: .normal)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AppDelegate에 대한 참조를 생성
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //상위 클래스의 메소드 호출
        super.viewWillAppear(animated)
        //로그인 여부 확인
        if appDelegate.id == nil{
            self.title = "로그인이 되어 있지 않음"
            self.loginbtn.setTitle("로그인", for: .normal)
        }else{
            self.title = "로그인 된 상태"
            self.loginbtn.setTitle("로그아웃", for: .normal)
        }
    }
    
    
}

