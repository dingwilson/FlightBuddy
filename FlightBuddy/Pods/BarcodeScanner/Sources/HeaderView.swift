import UIKit

/// UI elements on the navigation bar
final class HeaderElement {
  static func makeLabel() -> UILabel {
    let label = UILabel()
    label.text = Title.text
    label.font = Title.font
    label.textColor = Title.color
    label.numberOfLines = 1
    label.textAlignment = .center
    return label
  }

  static func makeCloseButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(CloseButton.text, for: UIControlState())
    button.titleLabel?.font = CloseButton.font
    button.tintColor = CloseButton.color
    return button
  }
}
