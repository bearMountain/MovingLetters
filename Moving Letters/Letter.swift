

import UIKit

struct Letter {
    let strokes: [Any]
}

struct BezierPoint {
    let point: CGPoint
    let controlPoint1: CGPoint?
    let controlPoint2: CGPoint?
}

struct BezierPath {
    let start: CGPoint
    let points: [BezierPoint]
}

struct LineSegment {
    let start: CGPoint
    let end: CGPoint
}


// A

let leftLine = LineSegment(start: p(2,10), end: p(5,100))
let points = [
    BezierPoint(point: p(17,2), controlPoint1: nil, controlPoint2:p(8,2)),
    BezierPoint(point: p(40,98), controlPoint1: p(26,1.5), controlPoint2: nil)
]
let arch = BezierPath(start: p(5, 100), points: points)
let crossLine = LineSegment(start: p(8, 50), end: p(44.5, 47.5))
let A = Letter(strokes: [leftLine, arch, crossLine])


// B

let mainShaft = LineSegment(start: p(9, 12), end: p(7, 98))
let secondShaft = LineSegment(start: p(7, 98), end: p(2, 5))
let topBArchPoints = [
    BezierPoint(point: p(48, 13), controlPoint1: nil, controlPoint2: p(41, -6)),
    BezierPoint(point: p(25.5, 41), controlPoint1: p(52.5, 31.5), controlPoint2: nil)
]
let topBArch = BezierPath(start: p(2,5), points: topBArchPoints)
let bottomBArchPoints = [
    BezierPoint(point: p(51, 83), controlPoint1: nil, controlPoint2: p(70, 52)),
    BezierPoint(point: p(-4.5, 85), controlPoint1: p(32, 114), controlPoint2: nil)
]
let bottomBarch = BezierPath(start: p(25.5, 41), points: bottomBArchPoints)
let B = Letter(strokes: [mainShaft, secondShaft, topBArch, bottomBarch])







