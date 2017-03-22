/*
 Copyright 2016-present the Material Components for iOS authors. All Rights
 Reserved.

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

#import <UIKit/UIKit.h>

#pragma mark - Unapproved API
@class MDCTextInputUnderlineView;
#pragma mark - Approved API
/**
 The Material Design guideslines have many suggestions for handling text input. The inputs that
 conform to this protocol have all the API necessary to customize them to those suggestions.

 They are, however, dumb; they do not handle error state nor validation.

 - For handling error states and other Material behaviors use an MDCTextInputController on your
 inputs
 - For validation, there are many 3rd party libraries you can use like:
   - https://github.com/3lvis/Validation
   - https://github.com/adamwaite/Validator
 */

/** Common API for Material Design themed text inputs. */
@protocol MDCTextInput <NSObject>

/** A Boolean value indicating whether the text field is currently in edit mode. */
@property(nonatomic, readonly, getter=isEditing) BOOL editing;

/** The text displayed in the text input. */
@property(nonatomic, nullable, copy) NSString *text;

/** The text displayed in the text input with style attributes. */
@property(nonatomic, nullable, copy) NSAttributedString *attributedText;

/** The color of the text in the input. */
@property(nonatomic, nullable, strong) UIColor *textColor;

/**
 The text string of the placeholder label.
 Bringing convenience api found in UITextField to all MDCTextInputs. Maps to the .text of the
 placeholder label.
 */
@property(nonatomic, nullable, copy) NSString *placeholder;

/**
 The attributed text string of the placeholder label.
 Bringing convenience api found in UITextField to all MDCTextInputs. Maps to the .attributedText of
 the
 placeholder label.
 */
@property(nonatomic, nullable, copy) NSAttributedString *attributedPlaceholder;

/**
 The label displaying text when no input text has been entered. The Material Design guidelines call
 this 'Hint text.'
 */
@property(nonatomic, nonnull, strong, readonly) UILabel *placeholderLabel;

/**
 The label on the trailing side under the input.

 This will usually be used for placeholder text to be displayed when no text has been entered. The
 Material Design guidelines call this 'Helper text.'
 */
@property(nonatomic, nonnull, strong, readonly)
    IBInspectable UILabel *leadingUnderlineLabel NS_SWIFT_NAME(leadingLabel);

/**
 The label on the trailing side under the input.

 This will usually be for the character count / limit.
 */
@property(nonatomic, nonnull, strong, readonly)
    IBInspectable UILabel *trailingUnderlineLabel NS_SWIFT_NAME(trailingLabel);

/**
 The color applied to the underline.

 Default is black with Material Design hint text opacity.
 */
@property(nonatomic, nullable, strong) UIColor *underlineColor UI_APPEARANCE_SELECTOR;

/** The thickness of the underline. */
@property(nonatomic, assign) CGFloat underlineWidth UI_APPEARANCE_SELECTOR;

#pragma mark - New API
/** Should it have the standard behavior of disappearing when you type? Defaults to YES. */
@property(nonatomic, assign) BOOL hidesPlaceholderOnInput;
/** Inset set on the text container based upon the text field's style. */
@property(nonatomic, readonly) UIEdgeInsets textContainerInset;

@end
