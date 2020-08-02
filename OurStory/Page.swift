//
//  Page.swift
//  OurStory
//
//  Created by Shawn Leo on 2020/7/24.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import Foundation
import UIKit

class Page: UIViewController{
    var textFrameList = [UITextField]()
    var graphicViewList = [UIImageView]()
    var backgroundTask = UIBackgroundTaskIdentifier(rawValue: 1)
    var currentPannedText:UITextField!
    var currentPannedGraph:UIImageView!
    
    func createTextFrame() -> Void {
        let newTextFrame = UITextField()
        newTextFrame.frame = CGRect(x: 80, y: 400, width: 180, height: 50)
        newTextFrame.layer.borderColor = UIColor.black.cgColor
        newTextFrame.layer.borderWidth = 1
        newTextFrame.isEnabled = true
        newTextFrame.isUserInteractionEnabled = true
        newTextFrame.allowsEditingTextAttributes = true
        newTextFrame.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(Textpanned(_:))))
        textFrameList.append(newTextFrame)
        self.view.addSubview(newTextFrame)
    }
    
    func createGraphicView(image: UIImage) -> Void {
        
    }
    
    func setBackground(background: UIImage) -> Void {
        
    }
    
    func PageDecode() -> String {
        return ""
    }
    
    func PageEncode(decodedPage: String) -> Page {
        return Page()
    }
    
    @objc func Textpanned(_ recognizer:UIPanGestureRecognizer){
        currentPannedText = (recognizer.view! as! UITextField)
        switch recognizer.state {
        case .changed:
            let translation = recognizer.translation(in: self.view)
            currentPannedText.center = CGPoint(x:currentPannedText.center.x + translation.x, y:currentPannedText.center.y + translation.y)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        case .ended:
            self.adjustToolPosition(pannedView: currentPannedText)
        default:
            return
        }
    }
    
    private func adjustToolPosition(pannedView:UITextField){
        pannedView.removeFromSuperview()
        currentPannedText = nil
        self.setupPage()
    }
        
    private func setupPage(){
        for textfield in textFrameList {
            self.view.addSubview(textfield)
        }
        for graph in graphicViewList {
            self.view.addSubview(graph)
        }
    }
    
}
