import SwiftUI

struct DemoView: UIViewControllerRepresentable {

  func makeUIViewController(context: Context) -> UIViewController {
    return DemoViewController.make()
  }

  func updateUIViewController(_: UIViewController, context: Context) {}
}
