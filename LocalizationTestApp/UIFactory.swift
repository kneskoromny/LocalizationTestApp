import UIKit

final class UIFactory {
    
    static var view: UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static var titleLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 36)
        label.textColor = .white
        return label
    }
    
    static var localizeSegmentedControl: UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: [
            "ru", "en", "ch", "ja", "de", "it",  "el"
        ])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = .zero
        segmentedControl.backgroundColor = .systemCyan
        segmentedControl.tintColor = .white
        return segmentedControl
    }
    
    static var resultLabel: UILabel {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = .boldSystemFont(ofSize: 24)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.text = "Check input data 🤷‍♀️"
        return textLabel
    }
    
    static var rawDateTextField: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "DD/MM/YYYY",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2]
        )
        textField.font = .boldSystemFont(ofSize: 24)
        textField.textColor = .white
        textField.backgroundColor = .systemMint
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 5
        return textField
    }
    
    static var measureInputTextField: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "VALUE",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2]
        )
        textField.font = .boldSystemFont(ofSize: 24)
        textField.textColor = .white
        textField.backgroundColor = .systemYellow
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 5
        return textField
    }
    
    static var measureValue1SegmentedControl: UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: [
            "km", "m", "mm"
        ])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = .zero
        segmentedControl.backgroundColor = .systemOrange
        segmentedControl.tintColor = .white
        return segmentedControl
    }
    
    static var measureValue2SegmentedControl: UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: [
            "mi", "yd", "ft"
        ])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = .zero
        segmentedControl.backgroundColor = .systemOrange
        segmentedControl.tintColor = .white
        return segmentedControl
    }
}
