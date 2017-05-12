/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import UIKit

import MaterialComponents.MaterialTextField
import MaterialComponents.MaterialButtons

class TextFieldSwiftExample: UIViewController {

  let scrollView = UIScrollView()

  let singleLabel: UILabel = {
    let singleLabel = UILabel()
    singleLabel.translatesAutoresizingMaskIntoConstraints = false
    singleLabel.text = "Single Line Text Fields"
    return singleLabel
  }()
  var allTextFields = [MDCTextInputController]()

  let multiLabel: UILabel = {
    let multiLabel = UILabel()
    multiLabel.translatesAutoresizingMaskIntoConstraints = false
    multiLabel.text = "Multi Line Text Views"
    return multiLabel
  }()

  var allTextViews = [MDCTextInputController]()

  var allInputs = [MDCTextInputController]()

  let characterModeButton = UIButton()
  let underlineButton = UIButton()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

    allTextFields = [setupDefaultTextFields(),
                     setupFullWidthTextFields(),
                     setupFloatingTextFields(),
                     setupSpecialTextFields()].flatMap { $0 }

    allTextViews = [setupDefaultTextViews(),
                    setupFullWidthTextViews(),
                    setupFloatingTextViews(),
                    setupSpecialTextViews()].flatMap { $0 }

    allInputs = allTextFields + allTextViews
    setupScrollView()
  }

  func setupDefaultTextFields() -> [MDCTextInputController] {
    let textFieldDefault = MDCTextField()
    scrollView.addSubview(textFieldDefault)
    textFieldDefault.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefault.placeholder = "This is a text field w/ floating placeholder"
    textFieldDefault.delegate = self

    textFieldDefault.leadingLabel.text = "Helper text"

    textFieldDefault.clearButtonMode = .always

    let textFieldControllerDefault = MDCTextInputController(input: textFieldDefault)

    textFieldControllerDefault.presentation = .default
    textFieldControllerDefault.characterCountMax = 50

    let textFieldDefaultCharMax = MDCTextField()
    scrollView.addSubview(textFieldDefaultCharMax)
    textFieldDefaultCharMax.translatesAutoresizingMaskIntoConstraints = false

    let textFieldControllerDefaultCharMax = MDCTextInputController(input: textFieldDefaultCharMax)

    return [textFieldControllerDefault, textFieldControllerDefaultCharMax]
  }
  func setupFullWidthTextFields() -> [MDCTextInputController] {
    let textFieldFullWidth = MDCTextField()
    scrollView.addSubview(textFieldFullWidth)
    textFieldFullWidth.translatesAutoresizingMaskIntoConstraints = false

    let textFieldControllerFullWidth = MDCTextInputController(input: textFieldFullWidth)

    let textFieldFullWidthCharMax = MDCTextField()
    scrollView.addSubview(textFieldFullWidthCharMax)
    textFieldFullWidthCharMax.translatesAutoresizingMaskIntoConstraints = false

    let textFieldControllerFullWidthCharMax =
      MDCTextInputController(input: textFieldFullWidthCharMax)

    return [textFieldControllerFullWidth, textFieldControllerFullWidthCharMax]
  }

  func setupFloatingTextFields() -> [MDCTextInputController] {
    let textFieldFloating = MDCTextField()
    scrollView.addSubview(textFieldFloating)
    textFieldFloating.translatesAutoresizingMaskIntoConstraints = false
    textFieldFloating.placeholder = "This is a text field w/ floating placeholder"
    textFieldFloating.delegate = self

    textFieldFloating.leadingLabel.text = "Helper text"

    textFieldFloating.clearButtonMode = .always

    let textFieldControllerFloating = MDCTextInputController(input: textFieldFloating)

    textFieldControllerFloating.presentation = .floatingPlaceholder
    textFieldControllerFloating.characterCountMax = 50

    let textFieldFloatingCharMax = MDCTextField()
    scrollView.addSubview(textFieldFloatingCharMax)
    textFieldFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false

    let textFieldControllerFloatingCharMax = MDCTextInputController(input: textFieldFloatingCharMax)

    return [textFieldControllerFloating, textFieldControllerFloatingCharMax]
  }

  func setupSpecialTextFields() -> [MDCTextInputController] {
    let textFieldDisabled = MDCTextField()
    scrollView.addSubview(textFieldDisabled)
    textFieldDisabled.translatesAutoresizingMaskIntoConstraints = false

    let textFieldControllerDefaultDisabled = MDCTextInputController(input: textFieldDisabled)

    let textFieldCustomFont = MDCTextField()
    scrollView.addSubview(textFieldCustomFont)
    textFieldCustomFont.translatesAutoresizingMaskIntoConstraints = false

    let textFieldControllerDefaultCustomFont = MDCTextInputController(input: textFieldCustomFont)

    let textFieldLeftView = MDCTextField()
    scrollView.addSubview(textFieldLeftView)
    textFieldLeftView.translatesAutoresizingMaskIntoConstraints = false

    let textFieldControllerDefaultLeftView = MDCTextInputController(input: textFieldLeftView)

    return [textFieldControllerDefaultDisabled, textFieldControllerDefaultCustomFont,
            textFieldControllerDefaultLeftView]
  }

  func setupDefaultTextViews() -> [MDCTextInputController] {
    let textViewDefault = MDCTextView()
    scrollView.addSubview(textViewDefault)
    textViewDefault.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerDefault = MDCTextInputController(input: textViewDefault)

    let textViewDefaultCharMax = MDCTextView()
    scrollView.addSubview(textViewDefaultCharMax)
    textViewDefaultCharMax.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerDefaultCharMax = MDCTextInputController(input: textViewDefaultCharMax)

    return [textViewControllerDefault, textViewControllerDefaultCharMax]
  }

  func setupFullWidthTextViews() -> [MDCTextInputController] {
    let textViewFullWidth = MDCTextView()
    scrollView.addSubview(textViewFullWidth)
    textViewFullWidth.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerFullWidth = MDCTextInputController(input: textViewFullWidth)

    let textViewFullWidthCharMax = MDCTextView()
    scrollView.addSubview(textViewFullWidthCharMax)
    textViewFullWidthCharMax.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerFullWidthCharMax = MDCTextInputController(input: textViewFullWidthCharMax)

    return [textViewControllerFullWidth, textViewControllerFullWidthCharMax]
  }

  func setupFloatingTextViews() -> [MDCTextInputController] {
    let textViewFloating = MDCTextView()
    scrollView.addSubview(textViewFloating)
    textViewFloating.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerFloating = MDCTextInputController(input: textViewFloating)

    let textViewFloatingCharMax = MDCTextView()
    scrollView.addSubview(textViewFloatingCharMax)
    textViewFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerFloatingCharMax = MDCTextInputController(input: textViewFloatingCharMax)

    return [textViewControllerFloating, textViewControllerFloatingCharMax]
  }

  func setupSpecialTextViews() -> [MDCTextInputController] {
    let textViewCustomFont = MDCTextView()
    scrollView.addSubview(textViewCustomFont)
    textViewCustomFont.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerDefaultCustomFont = MDCTextInputController(input: textViewCustomFont)

    return [textViewControllerDefaultCustomFont]
  }

  func setupLabels() {
    scrollView.addSubview(singleLabel)

    scrollView.addSubview(multiLabel)

    NSLayoutConstraint(item: singleLabel,
                       attribute: .leading,
                       relatedBy: .equal,
                       toItem: view,
                       attribute: .leadingMargin,
                       multiplier: 1,
                       constant: 0).isActive = true

    NSLayoutConstraint(item: singleLabel,
                       attribute: .trailing,
                       relatedBy: .equal,
                       toItem: view,
                       attribute: .trailingMargin,
                       multiplier: 1,
                       constant: 0).isActive = true

  }

  func setupScrollView() {
    view.addSubview(scrollView)

    scrollView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["scrollView": scrollView]))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["scrollView": scrollView]))
    setupLabels()

    let concatenatingClosure = {
      (accumulator, keyValue: (key: String, value: UIView)) in
      accumulator + "[" + keyValue.key + "]" + "-"
    }

    var textFields = [String: UIView]()
    allTextFields.flatMap { $0.input }.forEach { input in
      textFields["input" + String(describing: Unmanaged.passUnretained(input).toOpaque())] = input
    }

    let textFieldsString = textFields.reduce("", concatenatingClosure)

    var controls = [String: UIView]()
    setupControls().forEach { control in
      controls["control" + String(describing: Unmanaged.passUnretained(control).toOpaque())] =
        control
    }

    let controlsString = controls.reduce("", concatenatingClosure)

    var textViews = [String: UIView]()
    allTextViews.flatMap { $0.input }.forEach { input in
      textViews["input" + String(describing: Unmanaged.passUnretained(input).toOpaque())] = input
    }

    let textViewsString = textViews.reduce("", concatenatingClosure)

    let visualString = "V:|-[singleLabel]-" + textFieldsString + "[multiLabel]-" + controlsString +
      textViewsString + "|"

    let labels: [String: UIView] = ["singleLabel": singleLabel, "multiLabel": multiLabel]

    var views = [String: UIView]()

    let dictionaries = [labels, textFields, controls, textViews]

    dictionaries.forEach { dictionary in
      dictionary.forEach { (key, value) in
        views[key] = value
      }
    }

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: visualString,
                                                               options: [.alignAllLeft,
                                                                         .alignAllRight],
                                                               metrics: nil,
                                                               views: views))
  }

  func setupControls() -> [UIView] {
    let errorLabel = UILabel()
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    errorLabel.text = "In Error"
    scrollView.addSubview(errorLabel)

    let errorSwitch = UISwitch()
    errorSwitch.translatesAutoresizingMaskIntoConstraints = false
    errorSwitch.addTarget(self,
       action: #selector(TextFieldSwiftExample.errorSwitchDidChange(errorSwitch:)),
       for: .touchUpInside)
    scrollView.addSubview(errorSwitch)

    let helperLabel = UILabel()
    helperLabel.translatesAutoresizingMaskIntoConstraints = false
    helperLabel.text = "Show Helper Text"
    scrollView.addSubview(helperLabel)

    let helperSwitch = UISwitch()
    helperSwitch.translatesAutoresizingMaskIntoConstraints = false
    helperSwitch.addTarget(self,
        action: #selector(TextFieldSwiftExample.helperSwitchDidChange(helperSwitch:)),
        for: .touchUpInside)
    scrollView.addSubview(helperSwitch)

    let underlineButton = UIButton()
    underlineButton.translatesAutoresizingMaskIntoConstraints = false
    underlineButton.addTarget(self,
                              action: #selector(TextFieldSwiftExample.buttonDidTouch(button:)),
                              for: .touchUpInside)

    underlineButton.setTitle("Underline Mode: Always", for: .normal)

    scrollView.addSubview(underlineButton)

    let characterButton = UIButton()
    characterButton.translatesAutoresizingMaskIntoConstraints = false
    characterButton.addTarget(self,
        action: #selector(TextFieldSwiftExample.buttonDidTouch(button:)),
        for: .touchUpInside)
    characterButton.setTitle("Character Count Mode: Always", for: .normal)
    scrollView.addSubview(characterButton)

    return [errorLabel, errorSwitch, helperLabel, helperSwitch, underlineButton, characterButton]
  }

  func errorSwitchDidChange(errorSwitch: UISwitch) {
    allInputs.forEach { controller in
      if errorSwitch.isOn {
        controller.set(errorText: "Uh oh! Error. Try something else.", errorAccessibilityValue: nil)
      } else {
        controller.set(errorText: nil, errorAccessibilityValue: nil)
      }
    }
  }

  func helperSwitchDidChange(helperSwitch: UISwitch) {
    allInputs.forEach { controller in
      controller.helper = helperSwitch.isOn ? "This is helper text." : nil
    }
  }

  func buttonDidTouch(button: UIButton) {
    var partialTitle = ""
    if button == underlineButton {
      partialTitle = "Underline View Mode"
    } else {
      partialTitle = "Character Count Mode"
    }

    let closure: (UITextFieldViewMode, String) -> Void = { mode, title in
      self.allInputs.forEach { controller in
        controller.underlineMode = mode

        button.setTitle(title + ": " + self.modeName(mode: mode), for: .normal)
      }
    }

    let alert = UIAlertController(title: partialTitle,
                                  message: nil,
                                  preferredStyle: .alert)
    presentAlert(alert: alert, partialTitle: partialTitle, closure: closure)
  }

  func presentAlert (alert: UIAlertController,
                     partialTitle: String,
    closure: @escaping (_ mode: UITextFieldViewMode, _ title: String) -> Void) -> Void {

    for rawMode in 0...3 {
      let mode = UITextFieldViewMode(rawValue: rawMode)!
      alert.addAction(UIAlertAction(title: modeName(mode: mode),
                                    style: .default,
                                    handler: { _ in
        closure(mode, partialTitle)
      }))
    }

    present(alert, animated: true, completion: nil)
  }

  func modeName(mode: UITextFieldViewMode) -> String {
    switch mode {
    case .always:
      return "Always"
    case .whileEditing:
      return "While Editing"
    case .unlessEditing:
      return "Unless Editing"
    case .never:
      return "Never"
    }
  }
}

extension TextFieldSwiftExample: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}

extension TextFieldSwiftExample: UITextViewDelegate {
}

extension TextFieldSwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["Text Field", "(Swift)"]
  }
  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
