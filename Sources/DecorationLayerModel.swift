import UIKit
import Core

private let π = CGFloat(M_PI)
private let π_2 = CGFloat(M_PI_2)

private extension UIEdgeInsets {
    func clip(type type: DecorationType, offset: CGFloat = 0) -> UIEdgeInsets {
        switch type {
        case .Full:
            return UIEdgeInsets(top: top + offset, left: left + offset, bottom: bottom + offset, right: right + offset)
        case .Top:
            return UIEdgeInsets(top: top + offset, left: left + offset, bottom: 0, right: right + offset)
        case .Middle:
            return UIEdgeInsets(top: 0, left: left + offset, bottom: 0, right: right + offset)
        case .Bottom:
            return UIEdgeInsets(top: 0, left: left + offset, bottom: bottom + offset, right: right + offset)
        case .None:
            return UIEdgeInsetsZero
        }
    }
}

/**
 Model for providing layers to the DecorationNode
 */
struct DecorationLayerModel {
    private let color: UIColor
    private let padding: UIEdgeInsets
    private let cornerInfo: CornerInfo
    private let border: Border?
    
    init(color: UIColor,
         padding: UIEdgeInsets = UIEdgeInsets(),
         cornerInfo: CornerInfo = CornerInfo(radius: 0, corners: .AllCorners),
         border: Border? = nil
        ) {
        self.color = color
        self.padding = padding
        self.cornerInfo = cornerInfo
        self.border = border
    }
    
    func padding(type type: DecorationType) -> UIEdgeInsets {
        // correction for drawing a line around a point, half before and half after
        let offset = (border?.width ?? 0)/2
        return padding.clip(type: type, offset: offset)
    }
    
    func strokingPath(rect rect: CGRect, type: DecorationType) -> UIBezierPath? {
        let padding = self.padding(type: type)
        let decorationRect = rect.insetsBy(padding)
        let path = UIBezierPath()
        let left = decorationRect.minX
        let right = decorationRect.maxX
        let top = decorationRect.minY
        let bottom = decorationRect.maxY
        let cornerRadius = cornerInfo.radius
        
        switch type {
        case .None:
            return nil
        case .Full:
            return maskingPath(rect: rect, type: type)
        case .Top:
            let corners = cornerInfo.corners(decoration: type)
            path.moveToPoint(CGPoint(x: left, y: bottom))
            
            if corners.contains(.TopLeft) {
                let center = CGPoint(x: left + cornerRadius, y: top + cornerRadius)
                let leftTop = CGPoint(x: left, y: center.y)
                path.addLineToPoint(leftTop)
                path.addArcWithCenter(center, radius: cornerRadius, startAngle: -π, endAngle: -π_2, clockwise: true)
            }
            else {
                path.addLineToPoint(CGPoint(x: left, y: top))
            }
            if corners.contains(.TopRight) {
                let center = CGPoint(x: right - cornerRadius, y: top + cornerRadius)
                let rightTop = CGPoint(x: center.x, y: top)
                path.addLineToPoint(rightTop)
                path.addArcWithCenter(center, radius: cornerRadius, startAngle: -π_2, endAngle: 0, clockwise: true)
            }
            else {
                path.addLineToPoint(CGPoint(x: right, y: top))
            }
            path.addLineToPoint(CGPoint(x: right, y: bottom))
        case .Middle:
            path.moveToPoint(CGPoint(x: left, y: top))
            path.addLineToPoint(CGPoint(x: left, y: bottom))
            path.moveToPoint(CGPoint(x: right, y: top))
            path.addLineToPoint(CGPoint(x: right, y: bottom))
        case .Bottom:
            let corners = cornerInfo.corners(decoration: type)
            path.moveToPoint(CGPoint(x: left, y: top))
            
            if corners.contains(.BottomLeft) {
                let center = CGPoint(x: left + cornerRadius, y: bottom - cornerRadius)
                let bottomLeft = CGPoint(x: left, y: center.y)
                path.addLineToPoint(bottomLeft)
                path.addArcWithCenter(center, radius: cornerRadius, startAngle: -π, endAngle: π_2, clockwise: false)
            }
            else {
                path.addLineToPoint(CGPoint(x: left, y: bottom))
            }
            if corners.contains(.BottomRight) {
                let center = CGPoint(x: right - cornerRadius, y: bottom - cornerRadius)
                let bottomRight = CGPoint(x: center.x, y: bottom)
                path.addLineToPoint(bottomRight)
                path.addArcWithCenter(center, radius: cornerRadius, startAngle: π_2, endAngle: 0, clockwise: false)
            }
            else {
                path.addLineToPoint(CGPoint(x: right, y: bottom))
            }
            path.addLineToPoint(CGPoint(x: right, y: top))
        }
        
        return path
    }
    
    func mask(rect rect: CGRect, type: DecorationType) -> CAShapeLayer {
        let outerPath = UIBezierPath(rect: rect)
        outerPath.usesEvenOddFillRule = true
        let maskPath = maskingPath(rect: rect, type: type)
        outerPath.appendPath(maskPath)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = outerPath.CGPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
        return maskLayer
    }
    
    var maskedLayer: CALayer {
        let layer = CALayer()
        layer.backgroundColor = color.CGColor
        return layer
    }
    
    var strokeLayer: CAShapeLayer? {
        guard let border = border else { return nil }
        let layer = CAShapeLayer()
        layer.strokeColor = border.color.CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        return layer
    }

    private func maskingPath(rect rect: CGRect, type: DecorationType) -> UIBezierPath {
        let corners = cornerInfo.corners(decoration: type)
        let cornerRadii = self.cornerInfo.radii
        let padding = self.padding(type: type)
        let frame = rect.insetsBy(padding)
        let path = UIBezierPath(roundedRect: frame, byRoundingCorners: corners, cornerRadii: cornerRadii)
        path.closePath()
        return path
    }
}
