import UIKit
import Core

private let π = CGFloat(M_PI)
private let π_2 = CGFloat(M_PI_2)

public struct Border {
    public let color: UIColor
    public let width: CGFloat
    
    public init(color: UIColor, width: CGFloat = 1) {
        self.color = color
        self.width = width
    }
}

public struct CornerInfo {
    let allowedCorners: UIRectCorner
    let radius: CGFloat
    
    var radii: CGSize {
        return CGSize(width: radius, height: radius)
    }
    
    init(allowedCorners: UIRectCorner = .AllCorners, radius: CGFloat) {
        self.allowedCorners = allowedCorners
        self.radius = radius
    }
}

private extension BlockDecoration {
    var corners: UIRectCorner {
        switch self {
        case .Full:
            return [.TopLeft, .TopRight, .BottomLeft, .BottomRight]
        case .Top:
            return [.TopLeft, .TopRight]
        case .Bottom:
            return [.BottomLeft, .BottomRight]
        default:
            return []
        }
    }
}

private extension UIEdgeInsets {
    func clip(decoration decoration: BlockDecoration, offset: CGFloat = 0) -> UIEdgeInsets {
        switch decoration {
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

public struct DecorationModel {
    public let color: UIColor
    public let border: Border?
    public let padding: UIEdgeInsets
    public let cornerInfo: CornerInfo
    
    public init(color: UIColor, padding: UIEdgeInsets = UIEdgeInsets(), cornerInfo: CornerInfo = CornerInfo(allowedCorners: .AllCorners, radius: 8), border: Border? = nil) {
        self.color = color
        self.padding = padding
        self.cornerInfo = cornerInfo
        self.border = border
    }
    
    public func padding(decoration decoration: BlockDecoration) -> UIEdgeInsets {
        return padding.clip(decoration: decoration)
    }
    
    private func corners(decoration decoration: BlockDecoration) -> UIRectCorner {
        return decoration.corners.intersect(cornerInfo.allowedCorners)
    }
    
    private func maskingPath(rect rect: CGRect, decoration: BlockDecoration) -> UIBezierPath {
        let corners = self.corners(decoration: decoration)
        let cornerRadii = self.cornerInfo.radii
        let padding = self.padding(decoration: decoration)
        let frame = rect.insetsBy(padding)
        let path = UIBezierPath(roundedRect: frame, byRoundingCorners: corners, cornerRadii: cornerRadii)
        path.closePath()
        return path
    }
    
    public func strokingPath(forRect rect: CGRect, decoration: BlockDecoration) -> UIBezierPath? {
        let padding = self.padding(decoration: decoration)
        let decorationRect = rect.insetsBy(padding)
        let path = UIBezierPath()
        let left = decorationRect.minX
        let right = decorationRect.maxX
        let top = decorationRect.minY
        let bottom = decorationRect.maxY
        let cornerRadius = cornerInfo.radius
        
        switch decoration {
        case .None:
            return nil
        case .Full:
            return maskingPath(rect: rect, decoration: decoration)
        case .Top:
            let corners = self.corners(decoration: decoration)
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
            let corners = self.corners(decoration: decoration)
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
    
    public func maskingLayer(forBounds bounds: CGRect, decoration: BlockDecoration) -> CAShapeLayer {
        let outerPath = UIBezierPath(rect: bounds)
        outerPath.usesEvenOddFillRule = true
        let maskPath = maskingPath(rect: bounds, decoration: decoration)
        outerPath.appendPath(maskPath)
        let maskLayer = CAShapeLayer()
        maskLayer.path = outerPath.CGPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
        return maskLayer
    }
}
