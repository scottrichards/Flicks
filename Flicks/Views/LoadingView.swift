//
//  LoadingView.swift
//  Flicks
//
//  Created by Scott Richards on 10/17/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    static let DefaultHeight : CGFloat = 55
    static let LabelHeight : CGFloat = 20
    var viewHeight : CGFloat = LoadingView.DefaultHeight
    var viewWidth : CGFloat?
    var label : UILabel?
    var message : String? {
        didSet {
            if let label = label {
                label.text = message
                label.sizeToFit()
                label.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
                //CGPoint(frame.size.width/2, frame.size.height/2)
            }
        }
    }
    
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
    convenience init() {
        let frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: LoadingView.DefaultHeight)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
        let frame = CGRect(x: 10.0, y: 10.0, width: UIScreen.main.bounds.width - 20 , height: LoadingView.LabelHeight)
        label = UILabel(frame: frame)
//        label?.backgroundColor = UIColor.red
        label?.textColor = UIColor.darkGray
        label?.textAlignment = .center
        message = "Loading..."
        self.addSubview(label!)
        self.backgroundColor = UIColor.white
        self.alpha = 0.5
//        self.layer.cornerRadius = 5.0
    }
    
    class func addToView(view: UIView, animated: Bool) -> LoadingView {
        let loadingView = LoadingView()

        view.addSubview(loadingView)
        if (animated) {
            UIView.animate(withDuration: 0.5, delay: 0.1, animations: {
                loadingView.alpha = 1.0
            }, completion: nil)
        }
        return loadingView
    }
}
