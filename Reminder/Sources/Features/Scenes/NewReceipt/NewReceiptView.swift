//
//  NewReceiptView.swift
//  Reminder
//
//  Created by Gabriel Roveri on 24/04/25.
//

import Foundation
import UIKit

final class NewReceiptView: UIView {
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(systemName: "arrow.left"), for: .normal)
        button.tintColor = ColorsConstants.gray100
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Receipt"
        label.font = TextHeadings.heading
        label.textColor = ColorsConstants.primaryRedBase
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Add a new receipt to your list."
        label.font = TextHeadings.body
        label.textColor = ColorsConstants.gray200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+ Add Receipt", for: .normal)
        button.titleLabel?.font = TextHeadings.subHeading
        button.backgroundColor = ColorsConstants.primaryRedBase
        button.layer.cornerRadius = 12
        button.setTitleColor(ColorsConstants.gray800, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    } ()
    
    let recurrencePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    } ()
    
    let recurrenceOptions: [String] = [
        "1 em 1 hora",
        "2 em 2 horas",
        "4 em 24horas",
        "6 em 6 horas",
        "8 em 8 horas",
        "12 em 12 horas",
        "Um por dia",
    ]
    
    let remedyInput = Input(title: "Remedy", placeholder: "Enter a remedy")
    let timeInput = Input(title: "Time", placeholder: "Enter time")
    let recurrenceInput = Input(title: "Recurrence", placeholder: "Enter recurrence")
    let takeNowCheckbox = Checkbox(title: "Take now")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(backButton, titleLabel, descriptionLabel,
                    addButton, remedyInput, timeInput,
                    recurrenceInput, takeNowCheckbox)
        
        setupConstraints()
        setupTimeInput()
        setupRecurrenceInput()
        validateInputs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Back Button
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: MetricsConstants.small),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: MetricsConstants.small),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            
            // Description Label
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: MetricsConstants.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.high),
            
            // Remedy input
            remedyInput.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: MetricsConstants.medium),
            remedyInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            remedyInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.high),
            
            // Time input
            timeInput.topAnchor.constraint(equalTo: remedyInput.bottomAnchor, constant: MetricsConstants.medium),
            timeInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            timeInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.high),
            
            // Recurrency input
            recurrenceInput.topAnchor.constraint(equalTo: timeInput.bottomAnchor, constant: MetricsConstants.medium),
            recurrenceInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            recurrenceInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.high),
            
            // Checkbox
            takeNowCheckbox.topAnchor.constraint(equalTo: recurrenceInput.bottomAnchor, constant: MetricsConstants.medium),
            takeNowCheckbox.leadingAnchor.constraint(equalTo: recurrenceInput.leadingAnchor),
            takeNowCheckbox.trailingAnchor.constraint(equalTo: recurrenceInput.trailingAnchor),
            
            // Add button
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.high),
            addButton.heightAnchor.constraint(equalToConstant: 56),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -MetricsConstants.high),
        ])
    }
    
    private func validateInputs() {
        let isRemedyFilled = !(remedyInput.textField.text ?? "").isEmpty
        let isTimeFilled = !(timeInput.textField.text ?? "").isEmpty
        let isRecurrenceFilled = !(recurrenceInput.textField.text ?? "").isEmpty
        
        addButton.isEnabled = isRemedyFilled && isTimeFilled && isRecurrenceFilled
        addButton.backgroundColor = addButton.isEnabled ? ColorsConstants.primaryRedBase : ColorsConstants.gray500
    }
    
    private func setupObservers() {
        remedyInput.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        timeInput.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        recurrenceInput.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    @objc
    private func textFieldDidChange() {
        validateInputs()
    }
    
    private func setupRecurrenceInput() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectRecurrence))
        toolbar.setItems([doneButton], animated: true)
        
        recurrenceInput.textField.inputView = recurrencePicker
        recurrenceInput.textField.inputAccessoryView = toolbar
        
        recurrencePicker.delegate = self
        recurrencePicker.dataSource = self
    }
    
    @objc
    private func didSelectRecurrence() {
        let selectedRow = recurrencePicker.selectedRow(inComponent: 0)
        recurrenceInput.textField.text = recurrenceOptions[selectedRow]
        recurrenceInput.textField.resignFirstResponder()
        
        validateInputs()
    }
    
    private func setupTimeInput() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectTime))
        toolbar.setItems([doneButton], animated: true)
        
        timeInput.textField.inputView = timePicker
        timeInput.textField.inputAccessoryView = toolbar
    }
    
    @objc
    private func didSelectTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeInput.textField.text = formatter.string(from: timePicker.date)
        timeInput.textField.resignFirstResponder()
        
        validateInputs()
    }
}

extension NewReceiptView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recurrenceOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return recurrenceOptions[row]
    }
}
