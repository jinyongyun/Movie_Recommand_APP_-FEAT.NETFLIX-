//
//  Content.swift
//  MovieRecommand
//
//  Created by jinyong yun on 1/8/24.
//

import UIKit

struct Content: Decodable {
    let sectionType: SectionType // 타입이기 때문에 enum으로 바꿔주는 것이 더 직관적
    let sectionName: String
    let contentItem: [Item]
    
    enum SectionType: String, Decodable {
        case basic
        case main
        case large
        case rank
    }
}

struct Item: Decodable {
    let description: String
    let imageName: String
    
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
        //바로 imageName을 이미지로 리턴
    }
    
}

