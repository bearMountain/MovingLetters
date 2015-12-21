//
//  LetterView.swift
//  Moving Letters
//
//  Created by Jeffrey Camealy on 12/16/15.
//  Copyright © 2015 New Engineer. All rights reserved.
//

import UIKit

func p(x: Double,_ y: Double) -> CGPoint {
    return CGPoint(x: x, y: y)
}

func lineLayerWithPath(path: CGPath) -> CAShapeLayer {
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path
    shapeLayer.strokeColor = UIColor.whiteColor().CGColor
    shapeLayer.fillColor = UIColor.clearColor().CGColor
    shapeLayer.lineWidth = 3
    shapeLayer.lineCap = "round"
    
    return shapeLayer;
}

func strokeLayersForLetter(letter: Letter) -> [CAShapeLayer] {
    var strokeLayers = [CAShapeLayer]()
    for stroke in letter.strokes {
        let path = UIBezierPath()
        
        if let lineSegment = stroke as? LineSegment {
            path.moveToPoint(lineSegment.start)
            path.addLineToPoint(lineSegment.end)
        }
        
        if let bezierPath = stroke as? BezierPath {
            path.moveToPoint(bezierPath.start)
            var previousPoint = bezierPath.start
            for bezierPoint in bezierPath.points {
                let controlPoint1 = bezierPoint.controlPoint1 == nil ? previousPoint : bezierPoint.controlPoint1!
                let controlPoint2 = bezierPoint.controlPoint2 == nil ? bezierPoint.point : bezierPoint.controlPoint2!
                path.addCurveToPoint(bezierPoint.point, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
                previousPoint = bezierPoint.point
            }
        }
        
        let layer = lineLayerWithPath(path.CGPath)
        strokeLayers.append(layer)
    }
    
    return strokeLayers;
}



class LetterView: UIView {
    
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .redColor()
        
//        addLetter()
    }
    
    //MARK: - Public
    
    func drawLetter(newLetter: Letter) {
        let maxI = max(newLetter.strokes.count, strokeLayers.count)
        var newStrokeLayers = [CAShapeLayer]()
        
        for i in 0..<maxI {
            // More Strokes in new letter
            if (i >= strokeLayers.count) {
                // add layer
                let path = pathForStroke(newLetter.strokes[i])
                let lineLayer = lineLayerWithPath(path)
                self.layer.addSublayer(lineLayer)
                // animate stroke in
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.duration = animationDuration
                animation.fromValue = 0
                animation.toValue = 1
                animation.removedOnCompletion = false
                animation.fillMode = kCAFillModeForwards
                lineLayer.addAnimation(animation, forKey: "strokeEnd")
                
                newStrokeLayers.append(lineLayer)
            }
                
            // More Strokes in old letter
            else if (i >= newLetter.strokes.count) {
                // animate stroke out
                let layerToRemove = strokeLayers[i]
                CATransaction.begin()
                CATransaction.setCompletionBlock{
                    layerToRemove.removeFromSuperlayer()
                }
                
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.duration = animationDuration
                animation.fromValue = 1
                animation.toValue = 0
                animation.removedOnCompletion = false
                animation.fillMode = kCAFillModeForwards
                layerToRemove.addAnimation(animation, forKey: "strokeEnd")
                
                CATransaction.commit()
            }
                
            // Changing old stroke to new stroke
            else {
                let path = pathForStroke(newLetter.strokes[i])
                
                let strokeLayer = strokeLayers[i]
                
                let animation = CABasicAnimation(keyPath: "path")
                animation.duration = animationDuration
                animation.fromValue = strokeLayer.path
                strokeLayer.path = path
                animation.toValue = path
//                animation.removedOnCompletion = false
//                animation.fillMode = kCAFillModeForwards
                strokeLayers[i].addAnimation(animation, forKey: "path")
                
                newStrokeLayers.append(strokeLayers[i])
                
//                let animation = CABasicAnimation(keyPath: "path")
//                animation.duration = animationDuration
//                animation.fromValue = segmentLayer.path
//                segmentLayer.path = newPath
//                animation.toValue = newPath
//                animation.removedOnCompletion = false
//                animation.fillMode = kCAFillModeForwards
//                segmentLayer.addAnimation(animation, forKey: "path")
            }
        }
        
        strokeLayers = newStrokeLayers
    }
    
    //MARK: - Private
    
    var strokeLayers = [CAShapeLayer]()
    let animationDuration = 2.0
    
    func addLetter() {
//        // Path 1
//        let path1 = UIBezierPath()
//        path1.moveToPoint(p(30,0))
//        path1.addCurveToPoint(p(40,40), controlPoint1: p(0,0), controlPoint2: p(-10,60))
//        
//        // Path 2
//        let path2 = UIBezierPath()
//        path2.moveToPoint(p(0,0))
//        path2.addLineToPoint(p(0,50))
        
//        let aLayers = strokeLayersForLetter(A)
        let bLayers = strokeLayersForLetter(B)
        
        // Shape Layer
        for strokeLayer in bLayers {
            layer.addSublayer(strokeLayer)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = 2
            animation.fromValue = 0
            animation.toValue = 1
            strokeLayer.addAnimation(animation, forKey: "strokeEnd")
        }
        
        
        //
//        for (i, strokeLayer) in aLayers.enumerate() {
//            if i >= bLayers.count {
//                continue
//            }
//            
//            let animation = CABasicAnimation(keyPath: "path")
//            animation.duration = 2
//            animation.toValue = strokeLayer.path
//            animation.removedOnCompletion = false
//            animation.fillMode = kCAFillModeForwards
//            bLayers[i].addAnimation(animation, forKey: "path")
//        }

        
        // Animation
//        let animation = CABasicAnimation(keyPath: "path")
//        animation.duration = 2
//        animation.toValue = path2.CGPath
//        animation.removedOnCompletion = false
//        animation.fillMode = kCAFillModeForwards
//        strokeLayers[0].addAnimation(animation, forKey: "path")
    }
    
    func pathForStroke(stroke: Any) -> CGPath {
        let path = UIBezierPath()
        
        if let lineSegment = stroke as? LineSegment {
            path.moveToPoint(lineSegment.start)
            path.addLineToPoint(lineSegment.end)
        }
        
        if let bezierPath = stroke as? BezierPath {
            path.moveToPoint(bezierPath.start)
            var previousPoint = bezierPath.start
            for bezierPoint in bezierPath.points {
                let controlPoint1 = bezierPoint.controlPoint1 == nil ? previousPoint : bezierPoint.controlPoint1!
                let controlPoint2 = bezierPoint.controlPoint2 == nil ? bezierPoint.point : bezierPoint.controlPoint2!
                path.addCurveToPoint(bezierPoint.point, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
                previousPoint = bezierPoint.point
            }
        }
        
        return path.CGPath
    }
    
    //MARK: - Boilerplate

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
