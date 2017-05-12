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

// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable function_body_length

import UIKit

import MaterialComponents.MaterialTextField
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialTypography

final class TextFieldSwiftExample: UIViewController {

  let scrollView = UIScrollView()

  let controlLabel: UILabel = {
    let controlLabel = UILabel()
    controlLabel.translatesAutoresizingMaskIntoConstraints = false
    controlLabel.text = "Options"
    controlLabel.font = MDCTypography.headlineFont()
    controlLabel.textColor = UIColor(white: 0, alpha: MDCTypography.headlineFontOpacity())
    return controlLabel
  }()

  let singleLabel: UILabel = {
    let singleLabel = UILabel()
    singleLabel.translatesAutoresizingMaskIntoConstraints = false
    singleLabel.text = "Single Line Text Fields"
    singleLabel.font = MDCTypography.headlineFont()
    singleLabel.textColor = UIColor(white: 0, alpha: MDCTypography.headlineFontOpacity())
    return singleLabel
  }()
  var allTextFieldControllers = [MDCTextInputController]()

  let multiLabel: UILabel = {
    let multiLabel = UILabel()
    multiLabel.translatesAutoresizingMaskIntoConstraints = false
    multiLabel.text = "Multi Line Text Views"
    multiLabel.font = MDCTypography.headlineFont()
    multiLabel.textColor = UIColor(white: 0, alpha: MDCTypography.headlineFontOpacity())
    return multiLabel
  }()

  var allTextViewControllers = [MDCTextInputController]()

  var allInputControllers = [MDCTextInputController]()
  var controllersWithCharacterCount = [MDCTextInputController]()
  var controllersFullWidth = [MDCTextInputController]()

  let unstyledTextField = MDCTextField()

  let characterModeButton = MDCButton()
  let clearModeButton = MDCButton()
  let underlineButton = MDCButton()

  lazy var appBar: MDCAppBar = self.setupAppBar()

  override func viewDidLoad() {
    super.viewDidLoad()
    appBar.addSubviewsToParent()

    view.backgroundColor = UIColor(white:0.97, alpha: 1.0)

    title = "Material Text Fields"

    let textFieldControllersFullWidth = setupFullWidthTextFields()

    allTextFieldControllers = [setupDefaultTextFields(),
                     textFieldControllersFullWidth,
                     setupFloatingTextFields(),
                     setupSpecialTextFields()].flatMap { $0 }

    let textViewControllersFullWidth = setupFullWidthTextViews()

    allTextViewControllers = [setupDefaultTextViews(),
                    textViewControllersFullWidth,
                    setupFloatingTextViews(),
                    setupSpecialTextViews()].flatMap { $0 }

    controllersFullWidth = textFieldControllersFullWidth + textViewControllersFullWidth

    allInputControllers = allTextFieldControllers + allTextViewControllers

    setupScrollView()
  }

  func setupDefaultTextFields() -> [MDCTextInputController] {
    let textFieldDefault = MDCTextField()
    scrollView.addSubview(textFieldDefault)
    textFieldDefault.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefault.delegate = self
    textFieldDefault.clearButtonMode = .whileEditing

    let textFieldControllerDefault = MDCTextInputController(input: textFieldDefault)

    textFieldControllerDefault.presentation = .default

    let textFieldDefaultPlaceholder = MDCTextField()
    scrollView.addSubview(textFieldDefaultPlaceholder)
    textFieldDefaultPlaceholder.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefaultPlaceholder.placeholder = "This is a text field w/ inline placeholder"
    textFieldDefaultPlaceholder.delegate = self

    textFieldDefaultPlaceholder.clearButtonMode = .whileEditing

    let textFieldControllerDefaultPlaceholder =
      MDCTextInputController(input: textFieldDefaultPlaceholder)

    textFieldControllerDefaultPlaceholder.presentation = .default

    let textFieldDefaultCharMax = MDCTextField()
    scrollView.addSubview(textFieldDefaultCharMax)
    textFieldDefaultCharMax.translatesAutoresizingMaskIntoConstraints = false

    textFieldDefaultCharMax.placeholder = "This is a text field w/ character count"
    textFieldDefaultCharMax.delegate = self
    textFieldDefaultCharMax.clearButtonMode = .whileEditing

    let textFieldControllerDefaultCharMax = MDCTextInputController(input: textFieldDefaultCharMax)
    textFieldControllerDefaultCharMax.characterCountMax = 50

    controllersWithCharacterCount.append(textFieldControllerDefaultCharMax)

    return [textFieldControllerDefault, textFieldControllerDefaultPlaceholder,
            textFieldControllerDefaultCharMax]
  }

  func setupFullWidthTextFields() -> [MDCTextInputController] {
    let textFieldFullWidth = MDCTextField()
    scrollView.addSubview(textFieldFullWidth)
    textFieldFullWidth.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidth.delegate = self
    textFieldFullWidth.clearButtonMode = .whileEditing

    let textFieldControllerFullWidth = MDCTextInputController(input: textFieldFullWidth)
    textFieldControllerFullWidth.presentation = .fullWidth

    let textFieldFullWidthPlaceholder = MDCTextField()
    scrollView.addSubview(textFieldFullWidthPlaceholder)
    textFieldFullWidthPlaceholder.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidthPlaceholder.placeholder = "This is a full width text field"
    textFieldFullWidthPlaceholder.delegate = self
    textFieldFullWidthPlaceholder.clearButtonMode = .whileEditing

    let textFieldControllerFullWidthPlaceholder =
      MDCTextInputController(input: textFieldFullWidthPlaceholder)
    textFieldControllerFullWidthPlaceholder.presentation = .fullWidth

    let textFieldFullWidthCharMax = MDCTextField()
    scrollView.addSubview(textFieldFullWidthCharMax)
    textFieldFullWidthCharMax.translatesAutoresizingMaskIntoConstraints = false

    textFieldFullWidthCharMax.placeholder = "This is a full width text field"
    textFieldFullWidthCharMax.delegate = self
    textFieldFullWidthCharMax.clearButtonMode = .whileEditing

    let textFieldControllerFullWidthCharMax =
      MDCTextInputController(input: textFieldFullWidthCharMax)
    textFieldControllerFullWidthCharMax.presentation = .fullWidth
    textFieldControllerFullWidthCharMax.characterCountMax = 50

    controllersWithCharacterCount.append(textFieldControllerFullWidthCharMax)

    return [textFieldControllerFullWidth, textFieldControllerFullWidthPlaceholder,
            textFieldControllerFullWidthCharMax]
  }

  func setupFloatingTextFields() -> [MDCTextInputController] {
    let textFieldFloating = MDCTextField()
    scrollView.addSubview(textFieldFloating)
    textFieldFloating.translatesAutoresizingMaskIntoConstraints = false

    textFieldFloating.placeholder = "This is a text field w/ floating placeholder"
    textFieldFloating.delegate = self
    textFieldFloating.clearButtonMode = .whileEditing

    let textFieldControllerFloating = MDCTextInputController(input: textFieldFloating)

    textFieldControllerFloating.presentation = .floatingPlaceholder

    let textFieldFloatingCharMax = MDCTextField()
    scrollView.addSubview(textFieldFloatingCharMax)
    textFieldFloatingCharMax.translatesAutoresizingMaskIntoConstraints = false

    textFieldFloatingCharMax.placeholder = "This is floating with character count"
    textFieldFloatingCharMax.delegate = self
    textFieldFloatingCharMax.clearButtonMode = .whileEditing

    let textFieldControllerFloatingCharMax = MDCTextInputController(input: textFieldFloatingCharMax)
    textFieldControllerFloatingCharMax.presentation = .floatingPlaceholder
    textFieldControllerFloatingCharMax.characterCountMax = 50

    controllersWithCharacterCount.append(textFieldControllerFloatingCharMax)

    return [textFieldControllerFloating, textFieldControllerFloatingCharMax]
  }

  func setupSpecialTextFields() -> [MDCTextInputController] {
    let textFieldDisabled = MDCTextField()
    scrollView.addSubview(textFieldDisabled)
    textFieldDisabled.translatesAutoresizingMaskIntoConstraints = false

    textFieldDisabled.placeholder = "This is a disabled text field"
    textFieldDisabled.delegate = self
    textFieldDisabled.isEnabled = false

    let textFieldControllerDefaultDisabled = MDCTextInputController(input: textFieldDisabled)

    let textFieldCustomFont = MDCTextField()
    scrollView.addSubview(textFieldCustomFont)
    textFieldCustomFont.translatesAutoresizingMaskIntoConstraints = false

    textFieldCustomFont.font = UIFont.preferredFont(forTextStyle: .headline)
    textFieldCustomFont.placeholder = "This is a custom font"
    textFieldCustomFont.delegate = self
    textFieldCustomFont.clearButtonMode = .whileEditing

    let textFieldControllerDefaultCustomFont = MDCTextInputController(input: textFieldCustomFont)

    let bundle = Bundle(for: TextFieldSwiftExample.self)
    let imagePath = bundle.path(forResource: "ic_search", ofType: "png")!
    let leftViewImage = UIImage(contentsOfFile: imagePath)!

    let textFieldLeftView = MDCTextField()
    textFieldLeftView.leftViewMode = .always
    textFieldLeftView.leftView = UIImageView(image:leftViewImage)

    scrollView.addSubview(textFieldLeftView)
    textFieldLeftView.translatesAutoresizingMaskIntoConstraints = false

    textFieldLeftView.placeholder = "This has a left view"
    textFieldLeftView.delegate = self
    textFieldLeftView.clearButtonMode = .whileEditing

    let textFieldControllerDefaultLeftView = MDCTextInputController(input: textFieldLeftView)

    let textFieldLeftViewFloating = MDCTextField()
    textFieldLeftViewFloating.leftViewMode = .always
    textFieldLeftViewFloating.leftView = UIImageView(image:leftViewImage)

    scrollView.addSubview(textFieldLeftViewFloating)
    textFieldLeftViewFloating.translatesAutoresizingMaskIntoConstraints = false

    textFieldLeftViewFloating.placeholder = "This has a left view and floats"
    textFieldLeftViewFloating.delegate = self
    textFieldLeftViewFloating.clearButtonMode = .whileEditing

    let textFieldControllerDefaultLeftViewFloating =
      MDCTextInputController(input: textFieldLeftViewFloating)
    textFieldControllerDefaultLeftViewFloating.presentation = .floatingPlaceholder

    scrollView.addSubview(unstyledTextField)
    unstyledTextField.translatesAutoresizingMaskIntoConstraints = false

    unstyledTextField.placeholder = "This is an unstyled text field (no controller)"
    unstyledTextField.delegate = self
    unstyledTextField.clearButtonMode = .whileEditing

    return [textFieldControllerDefaultDisabled, textFieldControllerDefaultCustomFont,
            textFieldControllerDefaultLeftView, textFieldControllerDefaultLeftViewFloating]
  }

  func setupDefaultTextViews() -> [MDCTextInputController] {
    let textViewDefault = MDCTextView()
    scrollView.addSubview(textViewDefault)
    textViewDefault.translatesAutoresizingMaskIntoConstraints = false

    let textViewControllerDefault = MDCTextInputController(input: textViewDefault)

    let textViewDefaultPlaceholder = MDCTextView()
    scrollView.addSubview(textViewDefaultPlaceholder)
    textViewDefaultPlaceholder.translatesAutoresizingMaskIntoConstraints = false

    textViewDefaultPlaceholder.placeholder = "This is a multi line text view with placeholder"

    let textViewControllerDefaultPlaceholder =
      MDCTextInputController(input: textViewDefaultPlaceholder)

    let textViewDefaultCharMax = MDCTextView()
    scrollView.addSubview(textViewDefaultCharMax)
    textViewDefaultCharMax.translatesAutoresizingMaskIntoConstraints = false

    textViewDefaultCharMax.placeholder = "This is a multi line text view with placeholder"

    let textViewControllerDefaultCharMax = MDCTextInputController(input: textViewDefaultCharMax)
    textViewControllerDefaultCharMax.characterCountMax = 140

    controllersWithCharacterCount.append(textViewControllerDefaultCharMax)

    return [textViewControllerDefault, textViewControllerDefaultPlaceholder,
            textViewControllerDefaultCharMax]
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

    controllersWithCharacterCount.append(textViewControllerFullWidthCharMax)

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

    controllersWithCharacterCount.append(textViewControllerFloatingCharMax)

    return [textViewControllerFloating, textViewControllerFloatingCharMax]
  }

  func setupSpecialTextViews() -> [MDCTextInputController] {
    let textViewCustomFont = MDCTextView()
    scrollView.addSubview(textViewCustomFont)
    textViewCustomFont.translatesAutoresizingMaskIntoConstraints = false

    textViewCustomFont.placeholder = "This has a custom font"

    let textViewControllerDefaultCustomFont = MDCTextInputController(input: textViewCustomFont)

    return [textViewControllerDefaultCustomFont]
  }

  func setupControls() -> [UIView] {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(container)

    let errorLabel = UILabel()
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    errorLabel.text = "In Error:"
    errorLabel.font = MDCTypography.subheadFont()
    errorLabel.textColor = UIColor(white: 0, alpha: MDCTypography.subheadFontOpacity())
    container.addSubview(errorLabel)

    let errorSwitch = UISwitch()
    errorSwitch.translatesAutoresizingMaskIntoConstraints = false
    errorSwitch.addTarget(self,
                        action: #selector(TextFieldSwiftExample.errorSwitchDidChange(errorSwitch:)),
                        for: .touchUpInside)
    container.addSubview(errorSwitch)

    let helperLabel = UILabel()
    helperLabel.translatesAutoresizingMaskIntoConstraints = false
    helperLabel.text = "Show Helper Text:"
    helperLabel.font = MDCTypography.subheadFont()
    helperLabel.textColor = UIColor(white: 0, alpha: MDCTypography.subheadFontOpacity())
    container.addSubview(helperLabel)

    let helperSwitch = UISwitch()
    helperSwitch.translatesAutoresizingMaskIntoConstraints = false
    helperSwitch.addTarget(self,
                    action: #selector(TextFieldSwiftExample.helperSwitchDidChange(helperSwitch:)),
                    for: .touchUpInside)
    container.addSubview(helperSwitch)

    let views = ["errorLabel": errorLabel, "errorSwitch": errorSwitch,
                 "helperLabel": helperLabel, "helperSwitch": helperSwitch]
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-[errorLabel]-[errorSwitch]|", options: [.alignAllCenterY], metrics: nil, views: views))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-[helperLabel]-[helperSwitch]|", options: [.alignAllCenterY], metrics: nil, views: views))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "V:|-[errorSwitch]-[helperSwitch]|", options: [], metrics: nil, views: views))

    characterModeButton.translatesAutoresizingMaskIntoConstraints = false
    characterModeButton.addTarget(self,
                                  action: #selector(TextFieldSwiftExample.buttonDidTouch(button:)),
                                  for: .touchUpInside)
    characterModeButton.setTitle("Character Count Mode: Always", for: .normal)
    characterModeButton.setTitleColor(.white, for: .normal)
    scrollView.addSubview(characterModeButton)

    clearModeButton.translatesAutoresizingMaskIntoConstraints = false
    clearModeButton.addTarget(self,
                              action: #selector(TextFieldSwiftExample.buttonDidTouch(button:)),
                              for: .touchUpInside)
    clearModeButton.setTitle("Clear Button Mode: While Editing", for: .normal)
    clearModeButton.setTitleColor(.white, for: .normal)
    scrollView.addSubview(clearModeButton)

    underlineButton.translatesAutoresizingMaskIntoConstraints = false
    underlineButton.addTarget(self,
                              action: #selector(TextFieldSwiftExample.buttonDidTouch(button:)),
                              for: .touchUpInside)

    underlineButton.setTitle("Underline Mode: While Editing", for: .normal)
    underlineButton.setTitleColor(.white, for: .normal)
    scrollView.addSubview(underlineButton)

    return [container, characterModeButton, underlineButton, clearModeButton]
  }

  func setupSectionLabels() {
    scrollView.addSubview(controlLabel)
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

    let mainViews: [String: UIView] = ["header": self.appBar.headerStackView,
                                       "scrollView": scrollView]
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
      withVisualFormat: "V:[header][scrollView]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: mainViews))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: mainViews))
    let marginOffset: CGFloat = 16
    let margins = UIEdgeInsets(top: 0, left: marginOffset, bottom: 0, right: marginOffset)

    scrollView.layoutMargins = margins

    setupSectionLabels()

    let prefix = "view"
    let concatenatingClosure = {
      (accumulator, object: AnyObject) in
      accumulator + "[" + self.unique(from: object, with: prefix) +
        "]" + "-"
    }

    let allControls = setupControls()
    let controlsString = allControls.reduce("", concatenatingClosure)

    var controls = [String: UIView]()
    allControls.forEach { control in
      controls[unique(from: control, with: prefix)] =
      control
    }

    let allTextFields = allTextFieldControllers.flatMap { $0.input }
    let textFieldsString = allTextFields.reduce("", concatenatingClosure)

    var textFields = [String: UIView]()
    allTextFields.forEach { input in
      textFields[unique(from: input, with: prefix)] = input
    }

    let allTextViews = allTextViewControllers.flatMap { $0.input }
    let textViewsString = allTextViews.reduce("", concatenatingClosure)

    var textViews = [String: UIView]()
    allTextViews.forEach { input in
      textViews[unique(from: input, with: prefix)] = input
    }

    let visualString = "V:|-10-[controlLabel]-" + controlsString + "20-[singleLabel]-" +
      textFieldsString + "[unstyledTextField]-20-[multiLabel]-" + textViewsString + "20-|"

    let labels: [String: UIView] = ["controlLabel": controlLabel,
                                    "singleLabel": singleLabel,
                                    "multiLabel": multiLabel,
                                    "unstyledTextField": unstyledTextField]

    var views = [String: UIView]()

    let dictionaries = [labels, textFields, controls, textViews]

    dictionaries.forEach { dictionary in
      dictionary.forEach { (key, value) in
        views[key] = value

        let leading = NSLayoutConstraint(item: value,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: value.superview,
                           attribute: .leadingMargin,
                           multiplier: 1.0,
                           constant: 0.0)
        leading.priority = 750.0
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: value,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: value.superview,
                                         attribute: .trailing,
                                         multiplier: 1.0,
                                         constant: 0.0)
        trailing.priority = 750.0
        trailing.isActive = true
      }
    }

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: visualString,
                                                               options: [.alignAllCenterX],
                                                               metrics: nil,
                                                                 views: views))

    controllersFullWidth.flatMap { $0.input }.forEach { input in
      NSLayoutConstraint(item: input,
                         attribute: .leading,
                         relatedBy: .equal,
                         toItem: input.superview,
                         attribute: .leading,
                         multiplier: 1.0,
                         constant: 0).isActive = true
      NSLayoutConstraint(item: input,
                         attribute: .trailing,
                         relatedBy: .equal,
                         toItem: input.superview,
                         attribute: .trailing,
                         multiplier: 1.0,
                         constant: 0).isActive = true
    }
  }

  func setupAppBar() -> MDCAppBar {
    let appBar = MDCAppBar()

    self.addChildViewController(appBar.headerViewController)
    appBar.headerViewController.headerView.backgroundColor = MDCPalette.blue().tint500
    appBar.headerViewController.headerView.tintColor = .white
    appBar.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

    return appBar
  }

  func unique(from input: AnyObject, with prefix: String) -> String {
    return prefix + String(describing: Unmanaged.passUnretained(input).toOpaque())
  }

  func errorSwitchDidChange(errorSwitch: UISwitch) {
    allInputControllers.forEach { controller in
      if errorSwitch.isOn {
        controller.set(errorText: "Uh oh! Error. Try something else.", errorAccessibilityValue: nil)
      } else {
        controller.set(errorText: nil, errorAccessibilityValue: nil)
      }
    }
  }

  func helperSwitchDidChange(helperSwitch: UISwitch) {
    allInputControllers.forEach { controller in
      controller.helper = helperSwitch.isOn ? "This is helper text." : nil
    }
  }

  func buttonDidTouch(button: MDCButton) {
    var controllersToChange = allInputControllers
    var partialTitle = ""

    if button == characterModeButton {
      partialTitle = "Character Count Mode"
      controllersToChange = controllersWithCharacterCount
    } else if button == clearModeButton {
      partialTitle = "Clear Button Mode"
      controllersToChange = allTextFieldControllers
    } else {
      partialTitle = "Underline View Mode"
    }

    let closure: (UITextFieldViewMode, String) -> Void = { mode, title in
      controllersToChange.forEach { controller in
        if button == self.characterModeButton {
          controller.characterMode = mode
        } else if button == self.clearModeButton {
          if let input = controller.input as? UITextField {
            input.clearButtonMode = mode
          }
        } else {
          controller.underlineMode = mode
        }

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
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

extension TextFieldSwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["Text Field", "(Swift)"]
  }
  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
