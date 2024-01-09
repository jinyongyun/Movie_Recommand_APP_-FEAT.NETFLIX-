//
//  ContentCollectionViewCell.swift
//  MovieRecommand
//
//  Created by jinyong yun on 1/8/24.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /*갑자기 contentView가 나와 의문일 수도 있는데
        UICollectionViewCell의 경우 cell의 layout을 표현하는 개체는 기본 cell이 있고,
        기본 contentViewCell이 있다. contentView를 superView로 보고 여기다 설정을 해야 보인다.*/
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true // 뷰의 크기에 맞춰 하위 뷰가 잘림(clipped)
        
        imageView.contentMode = .scaleAspectFill //이미지 뷰를 어떻게 표시할거냐
        
        contentView.addSubview(imageView) // contentView에 subView를 추가, 우리가 스토리보드에서 component를 올리는 것과 같음
        
        imageView.snp.makeConstraints { //이미지 뷰의 오토 레이아웃을 설정
            $0.edges.equalToSuperview() //imageView의 superView 즉 contentView에 딱 맞게
        }
    }
    
    
    
}

