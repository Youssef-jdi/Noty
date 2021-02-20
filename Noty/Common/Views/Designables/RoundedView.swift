//
//  RoundedView.swift
//  Noty
//
//  Created by Youssef Jdidi on 16/2/2021.
//

import UIKit

@IBDesignable
/// A rounded view 🤯.
/// Draws the nice "contiguous" corner radius instead of the classic one.
class RoundedView: UIView {

    // MARK: - IBInspectables

    /// Color of the background of the button when it is enabled.
    @IBInspectable var fillColor: UIColor = .white {
        didSet {
            shapeLayer.fillColor = fillColor.cgColor
        }
    }

    /// Image that fills the background of the button if present.
    @IBInspectable var fillImage: UIImage? {
        didSet {
            self.imageLayer.contents = self.fillImage?.cgImage
        }
    }

    /// Corner radius of the button, using `UIBezierPath` to get a smoother curvature.
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet { setNeedsLayout() }
    }

    /// Color of the border of the button.
    @IBInspectable var borderColor: UIColor = .clear {
        didSet { shapeLayer.strokeColor = borderColor.cgColor }
    }

    /// Width of the border of the button.
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet { shapeLayer.lineWidth = borderWidth }
    }

    /// Extra translation of the shadow of the button on the X axis.
    @IBInspectable var shadowOffsetX: CGFloat = 0 {
        didSet { shapeLayer.shadowOffset = shadowOffset }
    }

    /// Extra translation of the shadow of the button on the Y axis.
    @IBInspectable var shadowOffsetY: CGFloat = 5 {
        didSet { shapeLayer.shadowOffset = shadowOffset }
    }

    /// Opacity of the shadow of the button. 0 is transparent, 1 is opaque.
    @IBInspectable var shadowOpacity: Float = 0.15 {
        didSet { shapeLayer.shadowOpacity = shadowOpacity }
    }

    /// Radius of the shadow for the button.
    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet { shapeLayer.shadowRadius = shadowRadius }
    }

    /// Wheter it should round the upper right corner of the view.
    @IBInspectable var roundTopRightCorner: Bool = true {
        didSet { setNeedsLayout() }
    }

    /// Wheter it should round the upper left corner of the view.
    @IBInspectable var roundTopLeftCorner: Bool = true {
        didSet { setNeedsLayout() }
    }

    /// Wheter it should round the bottom right corner of the view.
    @IBInspectable var roundBottomRightCorner: Bool = true {
        didSet { setNeedsLayout() }
    }

    /// Wheter it should round the bottom left corner of the view.
    @IBInspectable var roundBottomLeftCorner: Bool = true {
        didSet { setNeedsLayout() }
    }

    // MARK: - Other properties

    var roundCornerMask: UIRectCorner {
        let mask = UIRectCorner(rawValue: 0)

        return zip(
            [
                roundTopLeftCorner,
                roundTopRightCorner,
                roundBottomLeftCorner,
                roundBottomRightCorner
            ],
            [
                UIRectCorner.topLeft,
                UIRectCorner.topRight,
                UIRectCorner.bottomLeft,
                UIRectCorner.bottomRight
            ]).lazy
            .filter { $0.0 }
            .reduce(into: mask) { $0.formUnion($1.1) }
    }

    var roundedPath: UIBezierPath {
        return UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: roundCornerMask,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
    }

    /// Internal utility to construct the shadow offset from the `IBInspectable` properties.
    private var shadowOffset: CGSize {
        return CGSize(width: shadowOffsetX, height: shadowOffsetY) }

    // MARK: - CALayers

    /// The class of the base layer inside the button's view.
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    /// Internal utility to retrieve the base layer as a shape layer without casting it everytime.
    private var shapeLayer: CAShapeLayer {
        return self.layer as! CAShapeLayer // swiftlint:disable:this force_cast
    }

    /// A `CALayer` that manages the background image of the view, allowing it to be masked but whithout disrupting the shadow layer.
    lazy var imageLayer: CALayer = {
        let layer = CALayer()
        layer.frame = self.bounds
        layer.contents = fillImage?.cgImage
        layer.contentsGravity = contentMode.gravity
        layer.mask = imageMaskLayer
        return layer
    }()

    /// A `CALayer` that masks the background image of the view, to give it the same curvature as the button itself.
    /// The `path` property of this layer is set in `layoutSubviews`.
    private lazy var imageMaskLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        self.shapeLayer.fillColor = self.fillColor.cgColor

        self.shapeLayer.strokeColor = self.borderColor.cgColor
        self.shapeLayer.lineWidth = borderWidth

        self.shapeLayer.shadowOffset = shadowOffset
        self.shapeLayer.shadowOpacity = shadowOpacity
        self.shapeLayer.shadowRadius = shadowRadius

        self.shapeLayer.backgroundColor = UIColor.clear.cgColor
        self.shapeLayer.shadowColor = UIColor.black.cgColor

        layer.insertSublayer(imageLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Update the shape of the button and of the shadow.
        self.shapeLayer.path = self.roundedPath.cgPath
        self.shapeLayer.shadowPath = self.roundedPath.cgPath
        self.imageMaskLayer.path = self.roundedPath.cgPath

        self.imageLayer.frame = self.bounds
    }

    func setFillColor(color: UIColor) {
        self.shapeLayer.fillColor = color.cgColor
    }
}

extension UIView.ContentMode {
    var gravity: CALayerContentsGravity {
        switch self {
        case .bottom: return CALayerContentsGravity.bottom
        case .bottomLeft: return CALayerContentsGravity.bottomLeft
        case .bottomRight: return CALayerContentsGravity.bottomRight

        case .top: return CALayerContentsGravity.top
        case .topLeft: return CALayerContentsGravity.topLeft
        case .topRight: return CALayerContentsGravity.topRight

        case .left: return CALayerContentsGravity.left
        case .right: return CALayerContentsGravity.right

        case .center: return CALayerContentsGravity.center

        case .scaleToFill: return CALayerContentsGravity.resize
        case .scaleAspectFit: return CALayerContentsGravity.resizeAspect
        case .scaleAspectFill: return CALayerContentsGravity.resizeAspectFill
        case .redraw: return CALayerContentsGravity.center
        @unknown default:
            fatalError("cucu")
        }
    }
}
