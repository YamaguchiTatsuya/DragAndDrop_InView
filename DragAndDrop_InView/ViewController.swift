//
//  ViewController.swift
//  DragAndDrop_InView
//
//  Created by TATSUYA YAMAGUCHI on 2020/02/08.
//  Copyright © 2020 TATSUYA YAMAGUCHI. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    private var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupImage()
        setupGesture()
    }

    private func setupImage() {
            
        guard let image = NSImage(named: "Pikachu") else {
            return
        }
        imageView = NSImageView(image: image)
        let width: CGFloat = 100
        let height = width / image.width * image.height
        imageView.frame = CGRect(x: 0,y: 0, width: width, height: height)
            
        self.view.addSubview(imageView)
    }
        
    private func setupGesture() {
        
        let panGestureRecognizer = NSPanGestureRecognizer(target: self, action: #selector(self.drawView(recognizer:)))
        
        imageView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func drawView(recognizer: NSPanGestureRecognizer) {
        
        guard let targetView = recognizer.view else {
            assertionFailure("targetView is nil")
            return
        }
        
        let distance = recognizer.translation(in: targetView)
        
        let newCenter = CGPoint(x: targetView.center.x + distance.x,
                                 y: targetView.center.y + distance.y)
        
        targetView.center = newCenter
        
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: targetView)//clear distance
    }
}


extension NSImage {

    var width: CGFloat {
        return size.width
    }

    var height: CGFloat {
        return size.height
     }
}

extension NSView {
    
    var x: CGFloat {
        return frame.origin.x
    }

    var y: CGFloat {
        return frame.origin.y
    }
    
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var center: CGPoint {
        get {
            return CGPoint(x: x + width/2,
                           y: y + height/2)
            
        }
        set {
            let center = newValue
            setFrameOrigin(CGPoint(x: center.x - width/2,
                                   y: center.y - height/2))
        }
    }
}
