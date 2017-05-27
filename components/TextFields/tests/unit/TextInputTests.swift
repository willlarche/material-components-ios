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

import XCTest
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialPalettes

class TextInputTests: XCTestCase {
  func testTextFieldTextInputProtocolConformance() {
    let textField = MDCTextField()

    XCTAssertNotNil(textField.leadingLabel)
    XCTAssertNotNil(textField.trailingLabel)
    XCTAssertNotNil(textField.placeholderLabel)

    textField.clearButtonColor = .red
    XCTAssertEqual(textField.clearButtonColor, .red)

    textField.textColor = .red
    XCTAssertEqual(textField.textColor, .red)

    let testText = "Test text"
    textField.text = testText
    XCTAssertEqual(textField.text, testText)

    let testPlaceholder = "Test placeholder"
    textField.placeholder = testPlaceholder
    XCTAssertEqual(textField.placeholder, testPlaceholder)

    textField.underlineColor = .red
    XCTAssertEqual(textField.underlineColor, .red)

    let width: CGFloat = 5.0
    textField.underlineHeight = width
    XCTAssertEqual(textField.underlineHeight, width)

    let testLeading = "Helper Test"
    textField.leadingLabel.text = testLeading
    XCTAssertEqual(textField.leadingLabel.text, testLeading)

    let testTrailing = "NN / NN"
    textField.trailingLabel.text = testTrailing
    XCTAssertEqual(textField.trailingLabel.text, testTrailing)
  }
}
