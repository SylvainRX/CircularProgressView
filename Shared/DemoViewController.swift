import UIKit

class DemoViewController: UIViewController {
  @IBOutlet private var circularProgressViewA: CircularProgressView!
  @IBOutlet private var circularProgressViewAHeightConstraint: NSLayoutConstraint!
  private lazy var circularProgressViewB: CircularProgressView = {
    let circularProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    circularProgressView.progress = 0.5
    return circularProgressView
  }()
  
  class func make() -> DemoViewController {
    let storyboard = UIStoryboard(name: String(describing: DemoViewController.self), bundle: Bundle.main)
    return storyboard.instantiateInitialViewController()!
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(circularProgressViewB)
    circularProgressViewB.center = CGPoint(x: view.center.x, y: view.center.y - 30)
  }

  @IBAction private func sizeSliderSlided(sender: UISlider) {
    let width = CGFloat(sender.value * 100)
    circularProgressViewAHeightConstraint.constant = width
  }

  @IBAction private func colorSliderSlided(sender: UISlider) {
    circularProgressViewA.progressTintColor = UIColor(hue: CGFloat(sender.maximumValue - sender.value), saturation: 1, brightness: 1, alpha: 1.0)
    circularProgressViewB.progressTintColor = UIColor(hue: CGFloat(sender.value), saturation: 1, brightness: 1, alpha: 1.0)
  }

  @IBAction private func widthSliderSlided(sender: UISlider) {
    circularProgressViewA.lineWidth = CGFloat((sender.maximumValue - sender.value) * 2)
    circularProgressViewB.lineWidth = CGFloat(sender.value * 2)
  }

  @IBAction private func progressSliderSlided(sender: UISlider) {
    circularProgressViewA.progress = sender.maximumValue - sender.value
    circularProgressViewB.progress = sender.value
  }
}
