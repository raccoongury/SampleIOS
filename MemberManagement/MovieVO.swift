import Foundation
import UIKit

struct MovieVO{
    var title : String?
    var genreNames : String?
    var linkUrl : String?
    var ratingAverage : Double?
    var thumbnailImage : String?
    
    //thumbnailImage에서 다운로드 받아서 이미지를 저장할 변수
    var image : UIImage?
}
