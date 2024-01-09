//
//  UIButton.swift
//  MovieRecommand
//
//  Created by jinyong yun on 1/9/24.
//

import UIKit

extension UIButton {
    func adjustVerticalLayout(_ spacing: CGFloat = 0) {
        let imageSize = self.imageView?.frame.size ?? .zero
        let titleLabelSize = self.titleLabel?.frame.size ?? .zero
        
        self.configuration?.imagePadding = spacing
        self.configuration?.titlePadding = spacing
        self.configuration?.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: -imageSize.width, bottom: -(imageSize.height + spacing), trailing: 0)

        //self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0) 이거 deprecated됨
        //self.imageEdgeInsets = UIEdgeInsets(top: -(titleLabelSize.height + spacing), left: 0, bottom: 0, right: -titleLabelSize.width)
        
        
    }
    
}
