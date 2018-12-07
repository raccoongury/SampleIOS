//
//  MemoVO.swift
//  MemberManagement
//
//  Created by 503-17 on 28/11/2018.
//  Copyright © 2018 the. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class MemoVO{
    var num:Int32?
    var memoIdx:Int?//데이터 식별값
    var title:String?//제목
    var contents:String?//내용
    var image:UIImage?//이미지
    var regdate:Date?//작성일
    
    //MemoMO 인스턴스를 구별하기 위한 변수
    var objectID: NSManagedObjectID?
}


