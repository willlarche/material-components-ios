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

class TextFieldSwiftExample: UIViewController {

  let textField = MDCTextField()
  let textFieldBehavior: MDCTextInputBehavior

  let textFieldInline = MDCTextField()
  let textFieldInlineBehavior: MDCTextInputBehavior

  let textView = MDCTextView()
  let textViewBehavior: MDCTextInputBehavior

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    textFieldBehavior = MDCTextInputBehavior(input: textField)
    textFieldInlineBehavior = MDCTextInputBehavior(input: textFieldInline)
    textViewBehavior = MDCTextInputBehavior(input: textView)

    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    view.addSubview(textField)
    view.addSubview(textFieldInline)
    view.addSubview(textView)

    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "This is a text field w/ floating placeholder"
    textField.delegate = self

    textField.leadingLabel.text = "Helper text"

    textField.clearButtonMode = .always

    textFieldBehavior.presentation = .floatingPlaceholder
    textFieldBehavior.characterCountMax = 50

    textFieldInline.translatesAutoresizingMaskIntoConstraints = false
    textFieldInline.placeholder = "This is a text field w/ inline placeholder"
    textFieldInline.delegate = self

    textFieldInline.leadingLabel.text = "More helper text"

    textFieldInline.clearButtonMode = .always

    textFieldInlineBehavior.presentation = .default
    textFieldInlineBehavior.characterCountMax = 40

    // Hide TextView for now
    textView.alpha = 0
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.placeholderLabel.text = "This is a text view"
    textView.delegate = self

    textView.leadingLabel.text = "Leading test"
    textView.trailingLabel.text = "Trailing test"

    textViewBehavior.presentation = .default

    let errorSwitch = UISwitch()
    errorSwitch.translatesAutoresizingMaskIntoConstraints = false
    errorSwitch.addTarget(self, action: #selector(TextFieldSwiftExample.errorSwitchDidChange(errorSwitch:)), for: .touchUpInside)
    view.addSubview(errorSwitch)

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "V:|-100-[textField]-[textFieldInline]-[textView]-50-[switch]",
                                                               options: [.alignAllTrailing,
                                                                         .alignAllLeading],
                                                               metrics: nil,
                                                               views: ["switch": errorSwitch,
                                                                       "textField": textField,
                                                                       "textFieldInline": textFieldInline,
                                                                       "textView": textView]))

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-[textField]-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["textField": textField]))
  }

  func errorSwitchDidChange(errorSwitch: UISwitch) {
    textFieldBehavior.set(errorText: errorSwitch.isOn ? "Oh no! ERROR!!!" : nil, errorAccessibilityValue: nil)
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
