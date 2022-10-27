import UIKit

class ViewController: UIViewController {

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            "english", "french", "chinese"
        ])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = .zero
        segmentedControl.backgroundColor = .systemCyan
        segmentedControl.tintColor = .white
        return segmentedControl
    }()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = .boldSystemFont(ofSize: 24)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.text = "Hello, world!"
        return textLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGreen
    }

    private func setupLayout() {
        view.addSubview(segmentedControl)
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 32)
        ])
    }

}
