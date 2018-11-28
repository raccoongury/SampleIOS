//
//  TheaterListController.swift
//  iOSApp
//
//  Created by 502 on 2018. 11. 27..
//  Copyright © 2018년 502. All rights reserved.
//

import UIKit

class TheaterListController: UITableViewController {
    
    //파싱한 결과를 저장할 변수
    var data = [NSDictionary]()
    //데이터를 읽을 시작 위치
    var startLocation = 0
    
    //웹에서 데이터를 다운로드 받아서 파싱한 후 결과를 저장하는 메소드 생성
    func download(){
        //다운로드 받을 URL 생성하기
        let addr = "http://swiftapi.rubypaper.co.kr:2029/theater/list?s_page=\(startLocation)&s_list=10"
        let url = URL(string:addr)
        
        //문자열로 다운로드 받기
        let stringdata = try! NSString(contentsOf: url!, encoding: 0x80_000_422)
        //print(stringdata)
        //문자열을 바이트 배열로 변환
        let encdata = stringdata.data(using: String.Encoding.utf8.rawValue)
        let result = try! JSONSerialization.jsonObject(with: encdata!, options: []) as? NSArray
        //배열의 데이터를 순회하면서 데이터를 self.data에 추가
        for imsi in result!{
            self.data.append(imsi as! NSDictionary)
        }
        
        /*
         //Data 까지는 받아지는데 Dictionary 나 Array로 변환할 때 에러가 나면 대부분 Encoding 문제 입니다.
         //이런 경우에는 문자열로 다운로드 받은 Data로 변환해서 수행하면 됩니다.
         let apidata = try! Data(contentsOf: url!)
         //데이터가 출력되지 않으면 url을 확인해보고 인터넷 권한 부분을 확인
         //print(apidata)
         
         //데이터 파싱
         let result = try! JSONSerialization.jsonObject(with: apidata, options: []) as? NSArray
         print(result!)
         */
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        download()
        self.navigationItem.title = "영화관 목록"
        self.title = "영화관 목록"
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    //섹션의 개수를 설정하는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //행의 개수를 설정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    //셀을 만들어 주는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheaterCell", for: indexPath) as! TheaterCell
        //출력할 데이터 찾아오기
        let theater = self.data[indexPath.row]
        //데이터 출력
        cell.lblName.text = theater["상영관명"] as? String
        cell.lblPhone.text = theater["연락처"] as? String
        cell.lblAddr.text = theater["소재지지번주소"] as? String
        return cell
    }
    
    //셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //데이터 찾아오기
        let theater = self.data[indexPath.row]
        
        //하위 뷰 컨트롤러 객체 생성
        let displayMapViewController = self.storyboard?.instantiateViewController(withIdentifier: "DisplayMapViewController") as! DisplayMapViewController
        //데이터 넘겨주기
        displayMapViewController.theater = theater
        //비동기 적으로 푸시
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(displayMapViewController, animated: true)
        }
    }
    
    
}
