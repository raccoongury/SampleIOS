//
//  MemoFormVC.swift
//  MemberManagement
//
//  Created by 503-17 on 28/11/2018.
//  Copyright © 2018 the. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController {
    //텍스트를 입력하는 도중에 호출되는 메소드
    var subject : String!
    //이미지 피커의 타입을 매개변수로 받아서 이미지 피커를 출력해주는 사용자 정의 메소드
    func presentPicker(source : UIImagePickerController.SourceType){
        //유효한 소스 타입이 아니면 중단
        guard UIImagePickerController.isSourceTypeAvailable(source) == true else{
            let alert = UIAlertController(title:"사용할 수 없는 타입입니다.", message:nil, preferredStyle:.alert)
            self.present(alert, animated:false)
            return
        }
        
        //이미지 피커 출력
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = source
        
        self.present(picker, animated:true)
    }
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    @IBAction func pick(_ sender: Any) {
        //대화상자 생성
        let select = UIAlertController(title:"이미지를 가져올 곳을 선택하세요!", message:nil, preferredStyle:.actionSheet)
        select.addAction(UIAlertAction(title:"카메라", style:.default){
            (_) in self.presentPicker(source:.camera)
        })
        select.addAction(UIAlertAction(title:"앨범", style:.default){
            (_) in self.presentPicker(source:.savedPhotosAlbum)
        })
        select.addAction(UIAlertAction(title:"사진 라이브러리", style:.default){
            (_) in self.presentPicker(source:.photoLibrary)
        })
        self.present(select, animated:true)
        
    }
    
    @IBAction func save(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
    }
    
    
    
}

//UITextViewDelegate
extension MemoFormVC : UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView){
        //입력된 문자열을 가져오기 - 사용을 편리하게 하기 위해서 형변환
        let contents = textView.text as NSString
        //글자수가 15자가 넘으면 15 그렇지 않으면 글자수를 저장
        let length = (contents.length > 15) ? 15 : contents.length
        self.subject = contents.substring(with:NSRange(location:0, length:length))
        self.navigationItem.title = subject
    }
}



//UIImagePickerControllerDelegate
extension MemoFormVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        self.preview.image =
            info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        picker.dismiss(animated:false)
    }
}

