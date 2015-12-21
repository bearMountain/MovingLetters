



import UIKit


class LetterView: UIView {
    
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
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
                strokeLayers[i].addAnimation(animation, forKey: "path")
                
                newStrokeLayers.append(strokeLayers[i])
            }
        }
        
        strokeLayers = newStrokeLayers
    }
    
    //MARK: - Private
    
    // Vars
    
    var strokeLayers = [CAShapeLayer]()
    let animationDuration = 2.0
    
    // Methods
    
    func lineLayerWithPath(path: CGPath) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 3
        shapeLayer.lineCap = "round"
        
        return shapeLayer;
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
