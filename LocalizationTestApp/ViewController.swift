import Combine
import UIKit

class ViewController: UIViewController {
    
    // TODO: шаблоны на nsdateformatter.com
    private let template = "dMMMMyEEEE"
    private var value1: Measurement<UnitLength>?
    private var value1Data: Double?
    private var value1Type: UnitLength = .kilometers
    private var value2: Measurement<UnitLength>?
    private var value2Data: Double?
    private var value2Type: UnitLength = .miles
    
    // MARK: - UI
    
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
    
    // MARK: - Combine
    
    @Published var isValue1Filled = false
    @Published var isValue2Filled = false
    
    private var isReadyToCalculate: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($isValue1Filled, $isValue2Filled)
            .map { value1, value2 in
                return value1 && value2
            }.eraseToAnyPublisher()
    }
    
    private var labelSubscriber: AnyCancellable?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        addTargets()
        setupSubscriber()
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
    
    private func setupSubscriber() {
        labelSubscriber = isReadyToCalculate
            .receive(on: RunLoop.main)
            .sink(receiveValue: { isReady in
                self.resultMeasureLabel.text = isReady ? self.getCalculationResult() : "Check input data 🤷‍♀️"
            })
    }
    
    private func getCalculationResult() -> String {
        let measureResult = value1! + value2!
        let ru = Locale(identifier: "ru_RU")
        let measureFormatter = MeasurementFormatter()
        measureFormatter.locale = ru
        return measureFormatter.string(from: measureResult)
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
            isValue1Filled = false
            return
        }
        value1 = Measurement(value: doubleValue, unit: value1Type)
        isValue1Filled = true
    }
    
    @objc func measureValue2DidChange(_ sender: UITextField) {
        guard let text = sender.text,
              let doubleValue = Double(text) else {
            isValue2Filled = false
            return
        }
        value2 = Measurement(value: doubleValue, unit: value2Type)
        isValue2Filled = true
    }
    
    @objc func changeMeasureValue1Type(_ sender: UISegmentedControl) {
        value1Type = Value1Type(rawValue: sender.selectedSegmentIndex)!.getUnitLength()
        measureValue1TextField.text = nil
        isValue1Filled = false
        
    }
    
    @objc func changeMeasureValue2Type(_ sender: UISegmentedControl) {
        value2Type = Value2Type(rawValue: sender.selectedSegmentIndex)!.getUnitLength()
        measureValue2TextField.text = nil
        isValue2Filled = false
    }

}

// MARK: - Layout

private extension ViewController {
    
    func setupLayout() {
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
            rawDateTextField.heightAnchor.constraint(equalToConstant: 44),
            
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
}
