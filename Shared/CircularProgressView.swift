import UIKit

/// A view that depicts the progress of a task over time.
///
/// The CircularProgressView class provides properties for managing the style of the progress circle and for getting and
/// setting values that are pinned to the progress of a task.
@IBDesignable
class CircularProgressView: UIView {

  /// The current progress shown by the receiver.
  ///
  /// The current progress is represented by a floating-point value between 0.0 and 1.0, inclusive, where 1.0 indicates
  /// the completion of the task. The default value is 0.0. Values less than 0.0 and greater than 1.0 are pinned to
  /// those limits.
  @IBInspectable
  public var progress: Float = 0.0 {
    didSet {
      progress = min(max(progress, 0), 1.0)
      updateTrackPath()
      updateProgressPath()
    }
  }

  /// The color shown for the portion of the progress bar that is filled.
  @IBInspectable
  public var progressTintColor: UIColor = UIColor.blue { didSet { updateProgressColor() } }

  /// The color shown for the portion of the progress bar that is not filled.
  @IBInspectable
  public var trackTintColor: UIColor = UIColor(white: 0.85, alpha: 1) { didSet { updateTrackColor() } }

  /// The width of the circle's outline
  @IBInspectable
  public var lineWidth: CGFloat = 5 {
    didSet {
      updateTrackPath()
      updateProgressPath()
    }
  }

  private var radius: CGFloat { return (frame.width < frame.height ? frame.width / 2 : frame.height / 2) - lineWidth / 2 }
  private var startAngle: CGFloat = CGFloat.pi / 2
  private var angle: CGFloat { return CGFloat(2 * Float.pi * progress) }
  private var endAngle: CGFloat { return angle - startAngle }
  private var arcCenter: CGPoint { return CGPoint(x: frame.width / 2, y: frame.height / 2) }
  private var trackLayer = CAShapeLayer()
  private var progressLayer = CAShapeLayer()

  init(frame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200),
       progress: Float = 0.0,
       lineWidth: CGFloat = 5,
       startAngle: CGFloat = CGFloat.pi / 2,
       progressTintColor: UIColor = UIColor.blue,
       trackTintColor: UIColor = UIColor(white: 0.85, alpha: 1)) {
    self.progress = progress
    self.lineWidth = lineWidth
    self.startAngle = startAngle
    self.progressTintColor = progressTintColor
    self.trackTintColor = trackTintColor
    super.init(frame: frame)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func didMoveToSuperview() {
    trackLayer.masksToBounds = true
    progressLayer.masksToBounds = true

    trackLayer.fillColor = UIColor.clear.cgColor
    layer.addSublayer(trackLayer)

    progressLayer.lineCap = .round
    progressLayer.fillColor = UIColor.clear.cgColor
    layer.addSublayer(progressLayer)

    updateTrackColor()
    updateTrackPath()
    updateProgressColor()
    updateProgressPath()
  }

  private func updateTrackColor() {
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    trackLayer.strokeColor = trackTintColor.cgColor
    CATransaction.commit()
  }

  private func updateTrackPath() {
    trackLayer.path = endAngle + startAngle != 0.0
      ? UIBezierPath(arcCenter: arcCenter,
                     radius: radius,
                     startAngle: endAngle,
                     endAngle: -startAngle,
                     clockwise: true).cgPath
      : UIBezierPath(ovalIn: CGRect(x: lineWidth / 2,
                                    y: lineWidth / 2,
                                    width: frame.width - lineWidth,
                                    height: frame.height - lineWidth)).cgPath
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    trackLayer.lineWidth = lineWidth
    CATransaction.commit()
  }

  private func updateProgressColor() {
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    progressLayer.strokeColor = progressTintColor.cgColor
    CATransaction.commit()
  }

  private func updateProgressPath() {
    progressLayer.path = UIBezierPath(arcCenter: arcCenter,
                                      radius: radius,
                                      startAngle: -startAngle,
                                      endAngle: endAngle,
                                      clockwise: true).cgPath
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    progressLayer.lineWidth = lineWidth
    CATransaction.commit()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    CATransaction.begin()
    CATransaction.setDisableActions(true)
    trackLayer.frame = bounds
    progressLayer.frame = bounds
    CATransaction.commit()

    updateTrackPath()
    updateProgressPath()
  }
}
