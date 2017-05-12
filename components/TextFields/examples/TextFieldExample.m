//
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

#import "TextFieldExampleSupplemental.h"

@import MaterialComponents.MaterialTextFields;

@implementation TextFieldExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
  self.title = @"Material Text Fields";

  [self setupExampleViews];

  [self setupTextFields];
}

- (void)setupTextFields {
  MDCTextField *textFieldDefaultCharMax = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldDefaultCharMax];
  textFieldDefaultCharMax.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldDefaultCharMax.placeholder = @"Enter up to 50 characters";
  textFieldDefaultCharMax.delegate = self;

  // Second the controller is created to manage the text field
  MDCTextInputController *textFieldControllerDefaultCharMax =
  [[MDCTextInputController alloc] initWithTextInput:textFieldDefaultCharMax];
  textFieldControllerDefaultCharMax.characterCountMax = 50;

  MDCTextField *textFieldFloating = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldFloating];
  textFieldFloating.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldFloating.placeholder = @"Floating Placeholder";
  textFieldFloating.delegate = self;
  textFieldFloating.clearButtonMode = UITextFieldViewModeUnlessEditing;

  MDCTextInputController *textFieldControllerFloating =
  [[MDCTextInputController alloc] initWithTextInput:textFieldFloating];

  textFieldControllerFloating.presentationStyle = MDCTextInputPresentationStyleFloatingPlaceholder;

  MDCTextField *textFieldFullWidth = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldFullWidth];
  textFieldFullWidth.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldFullWidth.placeholder = @"Full Width";
  textFieldFullWidth.delegate = self;
  textFieldFullWidth.clearButtonMode = UITextFieldViewModeUnlessEditing;

  MDCTextInputController *textFieldControllerFullWidth =
  [[MDCTextInputController alloc] initWithTextInput:textFieldFullWidth];

  textFieldControllerFullWidth.presentationStyle = MDCTextInputPresentationStyleFullWidth;

  [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[charMax]-[floating]" options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing metrics:nil views:@{ @"charMax": textFieldDefaultCharMax, @"floating": textFieldFloating }]];
  [NSLayoutConstraint constraintWithItem:textFieldDefaultCharMax attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1 constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldDefaultCharMax attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1 constant:0].active = YES;

  [NSLayoutConstraint constraintWithItem:textFieldFullWidth attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:textFieldFloating attribute:NSLayoutAttributeBottomMargin multiplier:1 constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldFullWidth attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldFullWidth attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0].active = YES;
}

@end
