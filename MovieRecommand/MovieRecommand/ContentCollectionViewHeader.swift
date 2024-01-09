//
//  ContentCollectionViewHeader.swift
//  MovieRecommand
//
//  Created by jinyong yun on 1/8/24.
//

import UIKit

class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionNameLabel = UILabel() //단일 이름 속성 라벨
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel) //UICollectionReusableView에 직접적으로 추가
        
        sectionNameLabel.snp.makeConstraints { //sectionNameLabel에 오토레이아웃 설정
            $0.centerY.equalToSuperview() // UICollectionReusableView 중심과 Y축 맞춰
            $0.top.bottom.leading.equalToSuperview().offset(10) //UICollectionReusableView와 위 아래 옆을 10씩 띄우기
        }
        
        
        
    }
    
}
