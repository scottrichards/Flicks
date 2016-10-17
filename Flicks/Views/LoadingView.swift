//
//  LoadingView.swift
//  Flicks
//
//  Created by Scott Richards on 10/17/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    var viewHeight : CGFloat = 55
    var viewWidth : CGFloat?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame : CGRect) {
        super.init(frame: frame)
        viewWidth = frame.size.width
        viewHeight = frame.size.height
        buildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
    }
}
