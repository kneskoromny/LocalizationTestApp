import Combine
import UIKit

class ViewController: UIViewController {

    // TODO: шаблоны на nsdateformatter.com
    private let template = "dMMMMyEEEE"
    private var value1: Measurement<UnitLength>?
    private var value2: Measurement<UnitLength>?
    
    private let upperContainerView = UIFactory.view
    private let lowerContainerView = UIFactory.view
    private let upperLabel = UIFactory.titleLabel
    private let lowerLabel = UIFactory.titleLabel
    private let localizeSegmentedControl = UIFactory.localizeSegmentedControl
    private let formattedDateLabel = UIFactory.resultLabel
    private let rawDateTextField = UIFactory.rawDateTextField
    private let measureValue1TextField = UIFactory.measureInputTextField
    private let measureValue2TextField = UIFactory.measureInputTextField
    private let measureValue1SegmentedControl = UIFactory.measureValue1SegmentedControl
    private let measureValue2SegmentedControl = UIFactory.measureValue2SegmentedControl
    private let resultMeasureLabel = UIFactory.resultLabel
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        addTargets()
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    private func setupDesign() {
        view.backgroundColor = .systemGreen
        upperContainerView.backgroundColor = .systemMint
        lowerContainerView.backgroundColor = .systemYellow
        upperLabel.text = "DateFormatter"
        lowerLabel.text = "MeasureFormatter"
    }
    
    private func addTargets() {
        localizeSegmentedControl.addTarget(self, action: #selector(changeLocale(_:)), for: .valueChanged)
        rawDateTextField.addTarget(self, action: #selector(dateInputDidChange(_:)), for: .editingChanged)
        
        measureValue1TextField.addTarget(self, action: #selector(measureValue1DidChange(_:)), for: .editingChanged)
        measureValue2TextField.addTarget(self, action: #selector(measureValue2DidChange(_:)), for: .editingChanged)
        measureValue1SegmentedControl.addTarget(self, action: #selector(changeMeasureValue1Type(_:)), for: .valueChanged)
        measureValue2SegmentedControl.addTarget(self, action: #selector(changeMeasureValue2Type(_:)), for: .valueChanged)
    }

    private func setupLayout() {
        view.addSubview(upperContainerView)
        view.addSubview(lowerContainerView)
        upperContainerView.addSubview(upperLabel)
        upperContainerView.addSubview(localizeSegmentedControl)
        upperContainerView.addSubview(formattedDateLabel)
        upperContainerView.addSubview(rawDateTextField)
        lowerContainerView.addSubview(lowerLabel)
        lowerContainerView.addSubview(measureValue1TextField)
        lowerContainerView.addSubview(measureValue2TextField)
        lowerContainerView.addSubview(measureValue1SegmentedControl)
        lowerContainerView.addSubview(measureValue2SegmentedControl)
        lowerContainerView.addSubview(resultMeasureLabel)
        
        NSLayoutConstraint.activate([
            upperContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            upperContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            upperContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            upperContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            lowerContainerView.topAnchor.constraint(equalTo: upperContainerView.bottomAnchor),
            lowerContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            lowerContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            lowerContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            upperLabel.topAnchor.constraint(equalTo: upperContainerView.topAnchor, constant: 48),
            upperLabel.centerXAnchor.constraint(equalTo: upperContainerView.centerXAnchor),
            
            localizeSegmentedControl.topAnchor.constraint(equalTo: upperLabel.bottomAnchor, constant: 32),
            localizeSegmentedControl.leadingAnchor.constraint(equalTo: upperContainerView.leadingAnchor, constant: 16),
            localizeSegmentedControl.trailingAnchor.constraint(equalTo: upperContainerView.trailingAnchor, constant: -16),
            localizeSegmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            rawDateTextField.topAnchor.constraint(equalTo: localizeSegmentedControl.bottomAnchor, constant: 32),
            rawDateTextField.centerXAnchor.constraint(equalTo: upperContainerView.centerXAnchor),
            rawDateTextField.widthAnchor.constraint(equalToConstant: 300),
            rawDateTextField.heightAnchor.constraint(equalToConstant: 100),
            
            formattedDateLabel.topAnchor.constraint(equalTo: rawDateTextField.bottomAnchor, constant: 32),
            formattedDateLabel.leadingAnchor.constraint(equalTo: upperContainerView.leadingAnchor, constant: 16),
            formattedDateLabel.trailingAnchor.constraint(equalTo: upperContainerView.trailingAnchor, constant: -16),
            
            lowerLabel.topAnchor.constraint(equalTo: lowerContainerView.topAnchor, constant: 24),
            lowerLabel.centerXAnchor.constraint(equalTo: lowerContainerView.centerXAnchor),
            
            measureValue1TextField.topAnchor.constraint(equalTo: lowerLabel.bottomAnchor, constant: 32),
            measureValue1TextField.leadingAnchor.constraint(equalTo: lowerContainerView.leadingAnchor, constant: 16),
            measureValue1TextField.widthAnchor.constraint(equalTo: lowerContainerView.widthAnchor, multiplier: 0.4),
            measureValue1TextField.heightAnchor.constraint(equalToConstant: 44),
            
            measureValue2TextField.topAnchor.constraint(equalTo: measureValue1TextField.bottomAnchor, constant: 32),
            measureValue2TextField.leadingAnchor.constraint(equalTo: lowerContainerView.leadingAnchor, constant: 16),
            measureValue2TextField.widthAnchor.constraint(equalTo: lowerContainerView.widthAnchor, multiplier: 0.4),
            measureValue2TextField.heightAnchor.constraint(equalToConstant: 44),
            
            measureValue1SegmentedControl.trailingAnchor.constraint(equalTo: lowerContainerView.trailingAnchor, constant: -16),
            measureValue1SegmentedControl.centerYAnchor.constraint(equalTo: measureValue1TextField.centerYAnchor),
            measureValue1SegmentedControl.widthAnchor.constraint(equalTo: lowerContainerView.widthAnchor, multiplier: 0.4),
            measureValue1SegmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            measureValue2SegmentedControl.trailingAnchor.constraint(equalTo: lowerContainerView.trailingAnchor, constant: -16),
            measureValue2SegmentedControl.centerYAnchor.constraint(equalTo: measureValue2TextField.centerYAnchor),
            measureValue2SegmentedControl.widthAnchor.constraint(equalTo: lowerContainerView.widthAnchor, multiplier: 0.4),
            measureValue2SegmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            resultMeasureLabel.topAnchor.constraint(equalTo: measureValue2TextField.bottomAnchor, constant: 32),
            resultMeasureLabel.leadingAnchor.constraint(equalTo: lowerContainerView.leadingAnchor, constant: 16),
            resultMeasureLabel.trailingAnchor.constraint(equalTo: lowerContainerView.trailingAnchor, constant: -16)
        ])
    }
    
    private func getLocale(dependsOf index: Int) -> Locale {
        var locale = Locale(identifier: "ru_RU")
        switch index {
        case 0: locale = Locale(identifier: "ru_RU")
        case 1: locale = Locale(identifier: "en")
        case 2: locale = Locale(identifier: "zh_CN")
        case 3: locale = Locale(identifier: "ja")
        case 4: locale = Locale(identifier: "de_DE")
        case 5: locale = Locale(identifier: "it")
        default: locale = Locale(identifier: "el")
        }
        return locale
    }
    
    private func getLocalizedText(from optionalText: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let text = optionalText,
              let date = dateFormatter.date(from: text) else {
            return "Check input data 🤷‍♀️"
        }
        let locale = getLocale(dependsOf: localizeSegmentedControl.selectedSegmentIndex)
        dateFormatter.locale = locale
        dateFormatter.setLocalizedDateFormatFromTemplate(template)
        return dateFormatter.string(from: date)
        
    }
    
    // MARK: - Actions
    
    @objc func changeLocale(_ sender: UISegmentedControl) {
        formattedDateLabel.text = getLocalizedText(from: rawDateTextField.text)
    }
    
    @objc func dateInputDidChange(_ sender: UITextField) {
        formattedDateLabel.text = getLocalizedText(from: sender.text)
    }
    
    @objc func measureValue1DidChange(_ sender: UITextField) {
        guard let text = sender.text,
              let doubleValue = Double(text) else {
            return
        }
        value1 = Measurement(value: doubleValue, unit: UnitLength.kilometers)
        print("value1: \(value1)")
    }
    
    @objc func measureValue2DidChange(_ sender: UITextField) {
        guard let text = sender.text,
              let doubleValue = Double(text) else {
            return
        }
        value2 = Measurement(value: doubleValue, unit: UnitLength.miles)
        print("value2: \(value2)")
    }
    
    @objc func changeMeasureValue1Type(_ sender: UISegmentedControl) {
    }
    
    @objc func changeMeasureValue2Type(_ sender: UISegmentedControl) {
    }

}
