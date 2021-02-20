//
//  AppButton.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/2/2021.
//

import UIKit

@IBDesignable
class AppButton: UIButton {

    /// Color of the background of the button when it is enabled.
    @IBInspectable var fillColor: UIColor? = .white {
        didSet {
            if self.isEnabled {
                shapeLayer?.fillColor = fillColor?.cgColor
            }
        }
    }

    /// Color of the background of the button when it is NOT enabled.
    @IBInspectable var inactiveFillColor: UIColor? = .lightGray {
        didSet {
            if !self.isEnabled {
                shapeLayer?.fillColor = fillColor?.cgColor
            }
        }
    }

    /// Color of the background of the button when it is NOT enabled.
    @IBInspectable var highlightedFillColor: UIColor? = .lightGray {
        didSet {
            if self.isHighlighted {
                shapeLayer?.fillColor = highlightedFillColor?.cgColor
            }
        }
    }

    @IBInspectable var fillImage: UIImage? {
        didSet {
            self.imageLayer.contents = self.fillImage?.cgImage
        }
    }

    @IBInspectable var numberOfLines: Int = 0 {
        didSet {
            titleLabel?.numberOfLines = numberOfLines
        }
    }

    /// Color of the title of the button when it is NOT enabled.
    @IBInspectable var inactiveTextColor: UIColor? = .darkGray {
        didSet {
            self.setTitleColor(inactiveTextColor, for: .disabled)
        }
    }

    @IBInspectable var minimumLeftMargin: CGFloat = 10 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable var minimumRightMargin: CGFloat = 10 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable var minimumTopMargin: CGFloat = 5 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable var minimumBottomMargin: CGFloat = 5 {
        didSet { setNeedsLayout() }
    }

    /// Corner radius of the button, using `UIBezierPath` to get a smoother curvature.
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet { setNeedsLayout() }
    }

    /// Color of the border of the button.
    @IBInspectable var borderColor: UIColor? = .clear {
        didSet { shapeLayer?.strokeColor = borderColor?.cgColor }
    }

    /// Width of the border of the button.
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet { shapeLayer?.lineWidth = borderWidth }
    }

    /// Extra translation of the shadow of the button on the X axis.
    @IBInspectable var shadowOffsetX: CGFloat = 0 {
        didSet { shapeLayer?.shadowOffset = shadowOffset }
    }

    /// Extra translation of the shadow of the button on the Y axis.
    @IBInspectable var shadowOffsetY: CGFloat = 2 {
        didSet { shapeLayer?.shadowOffset = shadowOffset }
    }

    /// Opacity of the shadow of the button. 0 is transparent, 1 is opaque.
    @IBInspectable var shadowOpacity: Float = 0.15 {
        didSet { shapeLayer?.shadowOpacity = shadowOpacity }
    }

    /// Radius of the shadow for the button.
    @IBInspectable var shadowRadius: CGFloat = 2 {
        didSet { shapeLayer?.shadowRadius = shadowRadius }
    }

    /// If the image is on the right
    @IBInspectable var hasRightImage: Bool = false {
        didSet { self.semanticContentAttribute = .forceRightToLeft }
    }

    /// Internal utility to construct the shadow offset from the `IBInspectable` properties.
    private var shadowOffset: CGSize {
        return CGSize(width: self.shadowOffsetX, height: self.shadowOffsetY) }

//    /// Sets the background image's content mode. Defaults to `.scaleAspectFill` and has effect only if a `fillImage` is set.
    var imageContentMode: UIView.ContentMode = .scaleAspectFit
//    {
//        didSet {
//            imageLayer.contentsGravity = contentMode.gravity
//        }
//    }

    override var isEnabled: Bool {
        didSet {
            self.shapeLayer?.fillColor = self.isEnabled
                ? self.fillColor?.cgColor
                : self.inactiveFillColor?.cgColor
        }
    }

    override var isHighlighted: Bool {
        didSet {
            self.shapeLayer?.fillColor = self.isHighlighted
                ? self.highlightedFillColor?.cgColor
                : (self.isEnabled ? self.fillColor?.cgColor : self.inactiveFillColor?.cgColor)
        }
    }

    weak var roundedPath: UIBezierPath? {
        // Update the shape of the button and of the shadow.
        return UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        )
    }

    /// The class of the base layer inside the button's view.
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    /// Internal utility to retrieve the base layer as a shape layer without casting it everytime.
    weak var shapeLayer: CAShapeLayer? {
        return self.layer as? CAShapeLayer
    }

//    /// A `CALayer` that manages the background image of the button, allowing it to be masked but whithout disrupting the shadow layer.
    lazy var imageLayer: CALayer = {
        let layer = CALayer()
        layer.frame = self.bounds
        layer.contents = fillImage?.cgImage
        // layer.contentsGravity = contentMode.gravity
        layer.mask = imageMaskLayer
        return layer
    }()

    /// A `CALayer` that masks the background image of the button, to give it the same curvature as the button itself.
    /// The `path` property of this layer is set in `layoutSubviews`.
    private lazy var imageMaskLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    /// Base setup. Assigning the values from the `IBInspectable`s.
    private func setup() {
        self.shapeLayer?.fillColor = self.isEnabled
            ? self.fillColor?.cgColor
            : self.inactiveFillColor?.cgColor

        self.shapeLayer?.strokeColor = self.borderColor?.cgColor
        self.shapeLayer?.lineWidth = borderWidth

        self.shapeLayer?.shadowOffset = shadowOffset
        self.shapeLayer?.shadowOpacity = shadowOpacity
        self.shapeLayer?.shadowRadius = shadowRadius

        self.shapeLayer?.backgroundColor = UIColor.clear.cgColor
        self.shapeLayer?.shadowColor = UIColor.black.cgColor

        layer.addSublayer(self.imageLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.shapeLayer?.path = self.roundedPath?.cgPath
        self.shapeLayer?.shadowPath = self.roundedPath?.cgPath
        self.imageMaskLayer.path = self.roundedPath?.cgPath

        self.imageLayer.frame = self.bounds
    }

    override var intrinsicContentSize: CGSize {
        let result = super.intrinsicContentSize
        let width = self.hasRightImage ?
            result.width : result.width + minimumLeftMargin + minimumRightMargin

        return CGSize(
            width: width,
            height: result.height + minimumTopMargin + minimumBottomMargin)
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - titleRect.width
        return titleRect.offsetBy(dx: availableWidth / 2, dy: 0)
    }
}
