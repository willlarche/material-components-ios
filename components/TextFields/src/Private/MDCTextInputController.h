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
 limitations under the License. */

#import "MDCTextInput.h"

/** Protocol implemented by a text field controlled by a |MDCTextFieldController|. */

@protocol MDCControlledTextInput

@property(nonatomic, nullable, strong) UIFont *font;

/** The text rect for the text field that fits it's contents given the provided bounds. */
- (CGRect)textRectThatFitsForBounds:(CGRect)bounds;

@optional

/** Vertical padding between the text and the border view. Defaults to 8.0f if not implemented. */
- (CGFloat)borderVerticalPadding;

@end

/** A controller for common traits shared by text field controls. */
@interface MDCTextInputController : NSObject <MDCTextInput>

/** Whether the text field is enabled. */
@property(nonatomic, getter=isEnabled) BOOL enabled;

/** Size of the character limit view. */
@property(nonatomic, readonly) CGSize characterLimitViewSize;

/** Height of the font appropriately ceiled. */
@property(nonatomic, readonly) CGFloat fontHeight;

@property(nonatomic, nullable, strong) UIColor *textColor;

@property(nonatomic, nullable, strong) UIColor *cursorColor;

/** Inset set on the text container based upon the text field's style. */
@property(nonatomic, readonly) UIEdgeInsets textContainerInset;

/** Designated initializer with the controlled text field and whether it is multiline. */
- (nonnull instancetype)initWithTextField:(UIView<MDCControlledTextInput, MDCTextInput> *_Nonnull)textField
                      isMultiline:(BOOL)isMultiline NS_DESIGNATED_INITIALIZER;

/** @deprecated Please use initWithTextField:isMultiline:. */
- (nonnull instancetype)init NS_UNAVAILABLE;

/** Called by the controlled text field to notify the controller that it's text was set. */
- (void)didSetText;

/** Called by the controlled text field to notify the controller that it's font was set. */
- (void)didSetFont;

/** Layout views on the controlled text field with animations disabled. */
- (void)layoutSubviewsWithAnimationsDisabled;

/** Perform all updates when editing starts. */
- (void)didBeginEditing;

/** Perform all updates when editing ends. */
- (void)didEndEditing;

/** Perform all updates when the text field changes. */
- (void)didChange;

/** Validates the text field if it has a validator present. */
- (void)validate;

/** 
 Whether or not to layout the UI for right-to-left languages. Query this to make layout decisions. 
 */
- (BOOL)shouldLayoutForRTL;

@end
