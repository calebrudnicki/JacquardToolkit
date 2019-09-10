//
//  JSQRCodeInstructionsView.swift
//  JacquardToolkit
//
//  Created by Caleb Rudnicki on 6/22/19.
//

import UIKit
import NotificationCenter

class JSQRCodeInstructionsView: UIView {
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = JSConstants.JSStrings.UI.scannerInitialPrompt
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Jacket ID"
        textField.font = UIFont(name: "HelveticaNeue-Thin", size: 24)
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .jsDarkGrey
        textField.autocapitalizationType = UITextAutocapitalizationType(rawValue: 3)!
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let button: UIButton = {
       let button = UIButton()
        button.setTitle(JSConstants.JSStrings.UI.trayButtonLabel, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let helpImageView: UIImageView = {
        let helpImageView = UIImageView()
        helpImageView.backgroundColor = .gray
        helpImageView.layer.borderWidth = 2
        helpImageView.layer.borderColor = UIColor.black.cgColor
        helpImageView.translatesAutoresizingMaskIntoConstraints = false
        return helpImageView
    }()
    
    // MARK: Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTitleLabel),
            name: Notification.Name(JSConstants.JSStrings.Notifications.scanSuccessfulScanner),
            object: nil
        )
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        addSubviews([containerView, titleLabel, textField, button, helpImageView])
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    ///MARK: Constraints
    
    public override func updateConstraints() {
        super.updateConstraints()
    
        guard let superview = self.superview else {
            return
        }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 32),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(greaterThanOrEqualTo: textField.bottomAnchor, constant: 32),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            button.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.25)
        ])
        
        NSLayoutConstraint.activate([
            helpImageView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 32),
            helpImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            helpImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            helpImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
    }
    
    //MARK: UI Functions

    @objc private func updateTitleLabel(userInfo: Notification) {
        titleLabel.text = JSConstants.JSStrings.UI.scannerSecondaryPrompt
    }
    
    @objc private func searchButtonTapped() {
        if let text = textField.text?.uppercased() {
            NotificationCenter.default.post(
                name:  NSNotification.Name(rawValue: JSConstants.JSStrings.Notifications.scanSuccessfulKeyboard),
                object: nil,
                userInfo: [JSConstants.JSStrings.Notifications.jacketID: text]
            )
        }
    }
    
    @objc private func textFieldDidChange() -> Bool {
        if let enteredText = textField.text, enteredText.count > 9, enteredText.count < 12 {
            if String(enteredText.prefix(5)).isInt &&
                String(enteredText.suffix(4)).isInt {
                textField.layer.borderColor = UIColor.gray.cgColor
                button.isEnabled = true
                return true
            }
        }
        textField.layer.borderColor = UIColor.red.cgColor
        button.isEnabled = false
        return false
    }

}