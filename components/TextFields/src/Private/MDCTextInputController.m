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
#import "MDCTextInput.h"

#import "MDCTextInputController.h"

#import "MDCTextInput+Internal.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputUnderlineView.h"
#import "MaterialAnimationTiming.h"

NSString *const MDCTextInputValidatorErrorColorKey = @"MDCTextInputValidatorErrorColor";
NSString *const MDCTextInputValidatorErrorTextKey = @"MDCTextInputValidatorErrorText";
NSString *const MDCTextInputValidatorAXErrorTextKey = @"MDCTextInputValidatorAXErrorText";
static const CGFloat MDCTextInputVerticalPadding = 16.f;

// These numers are straight from the redlines in the docs here:
// https://spec.MDCgleplex.com/quantum/components/text-fields

/**
 Checks whether the provided floating point number is approximately zero based on a small epsilon.

 Note that ULP-based comparisons are not used because ULP-space is significantly distorted around
 zero.

 Reference:
 https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/
 */

static inline UIColor *MDCTextInputUnderlineColor() {
  return [UIColor lightGrayColor];
}

@interface MDCTextInputController ()

@property(nonatomic, readonly) BOOL canValidate;
@property(nonatomic, strong) UILabel *characterLimitView;
@property(nonatomic, strong) UILabel *errorTextView;
@property(nonatomic, weak) UIView<MDCControlledTextInput, MDCTextInput> *textInput;

@end

@implementation MDCTextInputController

// We never use the text property. Instead always read from the text field.

@synthesize editing = _editing;
@synthesize leadingUnderlineLabel = _leadingUnderlineLabel;
@synthesize placeholderLabel = _placeholderLabel;
@synthesize text = _do_no_use_text;
@synthesize textColor = _textColor;
@synthesize trailingUnderlineLabel = _trailingUnderlineLabel;
@synthesize underlineColor = _underlineColor;
@synthesize underlineWidth = _underlineWidth;

- (instancetype)init {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (nonnull instancetype)initWithTextField:(UIView<MDCControlledTextInput> *_Nonnull)textInput
                              isMultiline:(BOOL)isMultiline {
  self = [super init];
  if (self) {
    _textInput = textInput;

    _textColor = MDCTextInputTextColor();
    _underlineColor = MDCTextInputUnderlineColor();

    // Initialize elements of UI
    _leadingUnderlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _placeholderLabel = [[UILabel alloc] initWithFrame:[self placeholderDefaultPositionFrame]];
    _trailingUnderlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];

    _placeholderLabel.textAlignment = NSTextAlignmentNatural;
    _placeholderLabel.layer.anchorPoint = CGPointZero;
    _placeholderLabel.userInteractionEnabled = NO;
    _placeholderLabel.alpha = 0;

    // TODO(larche) Get default placeholder text color.
    _placeholderLabel.textColor = [UIColor grayColor];
    _placeholderLabel.font = _textInput.font;

    [_textInput addSubview:_placeholderLabel];
    [_textInput sendSubviewToBack:_placeholderLabel];

    // Use the property accessor to create the underline view as needed.
    __unused MDCTextInputUnderlineView *underlineView = [self underlineView];
  }
  return self;
}

- (void)didSetText {
  [self didChange];
  [self.textInput setNeedsLayout];
}

- (void)didSetFont {
  UIFont *font = self.textInput.font;
  self.placeholderLabel.font = font;

  //  CGFloat scaleFactor = MDCTextInputTitleScaleFactor(font);
  //  self.floatingPlaceholderScaleTransform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);

  [self updatePlaceholderPosition];
}

- (void)layoutSubviewsWithAnimationsDisabled {
  //  self.characterLimitView.frame = [self characterLimitFrame];
  //  self.errorTextView.frame = [self underlineTextFrame];
  self.underlineView.frame = [self underlineViewFrame];
  [self updatePlaceholderPosition];
  [self updatePlaceholderAlpha];
}

- (UIEdgeInsets)textContainerInset {
  UIEdgeInsets textContainerInset = UIEdgeInsetsZero;
  //  switch (self.presentationStyle) {
  //    case MDCTextInputPresentationStyleDefault:
        textContainerInset.top = MDCTextInputVerticalPadding;
        textContainerInset.bottom = MDCTextInputVerticalPadding;
  //      break;
  //    case MDCTextInputPresentationStyleFloatingPlaceholder:
  //      textContainerInset.top = MDCTextInputVerticalPadding + MDCTextInputFloatingLabelTextHeight +
  //                               MDCTextInputFloatingLabelMargin;
  //      textContainerInset.bottom = MDCTextInputVerticalPadding;
  //      break;
  //    case MDCTextInputPresentationStyleFullWidth:
  //      textContainerInset.top = MDCTextInputFullWidthVerticalPadding;
  //      textContainerInset.bottom = MDCTextInputFullWidthVerticalPadding;
  //      textContainerInset.left = MDCTextInputFullWidthHorizontalPadding;
  //      textContainerInset.right = MDCTextInputFullWidthHorizontalPadding;
  //      break;
  //  }
  //
  //  // TODO(larche) Check this removal of validator.
  //  // Adjust for the character limit and validator.
  //  // Full width single line text fields have their character counter on the same line as the text.
  //  if ((self.characterLimit) &&
  //      (self.presentationStyle != MDCTextInputPresentationStyleFullWidth || [self.textInput isKindOfClass:[UITextView class]])) {
  //    textContainerInset.bottom += MDCTextInputValidationMargin;
  //  }
  //
  return textContainerInset;
}

- (void)didBeginEditing {
  // TODO(larche) Check this removal of underlineViewMode.
  //  if (self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
  //    [self.underlineView setNormalUnderlineHidden:YES];
  //  }
  //
  //  [CATransaction begin];
  //  [CATransaction setAnimationDuration:MDCTextInputAnimationDuration];
  //  [CATransaction
  //      setAnimationTimingFunction:[CAMediaTimingFunction
  //                                     mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut]];
  //
  //  // TODO(larche) Check this removal of underlineViewMode.
  //  if (self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
  //    [self.underlineView animateFocusUnderlineIn];
  //  }
  //  [self animatePlaceholderUp];
  //  [CATransaction commit];
  //
  //  [self updateCharacterCountLimit];
}

- (void)didEndEditing {
  // TODO(larche) Check this removal of underlineViewMode.
  //  if (self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
  //    [self.underlineView setNormalUnderlineHidden:NO];
  //  }
  //
  //  [CATransaction begin];
  //  [CATransaction setAnimationDuration:MDCTextInputDividerOutAnimationDuration];
  //  if (self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
  //    [self.underlineView animateFocusUnderlineOut];
  //  }
  //  [self animatePlaceholderDown];
  //  [CATransaction commit];
  //
    UILabel *label = (UILabel *)[self textInputLabel];
    if ([label isKindOfClass:[UILabel class]]) {
      [label setLineBreakMode:NSLineBreakByTruncatingTail];
    }
  //
  //  [self updateCharacterCountLimit];
}

- (void)didChange {
  [self updatePlaceholderAlpha];
}

// TODO(larche) Add back in properly.
- (BOOL)shouldLayoutForRTL {
  return NO;
  //  return MDCShouldLayoutForRTL() && MDCRTLCanSupportFullMirroring();
}

#pragma mark - Underline View Implementation

- (MDCTextInputUnderlineView *)underlineView {
  // TODO(larche) Check this removal of underlineViewMode.
  //  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth) {
  //    return nil;
  //  }
  //
  if (!_underlineView) {
    _underlineView = [[MDCTextInputUnderlineView alloc] initWithFrame:[self underlineViewFrame]];
    //    if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth) {
    //      _underlineView.normalUnderlineHidden = NO;
    //      _underlineView.focusUnderlineHidden = YES;
    //    } else {
    //      // TODO(larche) Check this removal of underlineViewMode.
    //      //      _underlineView.normalUnderlineHidden = (self.underlineViewMode ==
    //      //      UITextInputViewModeWhileEditing);
    //      // TODO(larche) Check this removal of underlineViewMode.
    //      //      _underlineView.focusUnderlineHidden = (self.underlineViewMode ==
    //      //      UITextInputViewModeUnlessEditing);
    //    }

    _underlineView.unfocusedColor = self.underlineColor;

    [self.textInput addSubview:_underlineView];
    [self.textInput sendSubviewToBack:_underlineView];
  }

  return _underlineView;
}

- (void)setUnderlineColor:(UIColor *)underlineColor {
  if (!underlineColor) {
    underlineColor = MDCTextInputUnderlineColor();
  }

  if (_underlineColor != underlineColor) {
    _underlineColor = underlineColor;
    [self updateColors];
  }
}

- (CGRect)underlineViewFrame {
  CGRect bounds = self.textInput.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect underlineFrame = CGRectZero;
  underlineFrame.size = [_underlineView sizeThatFits:bounds.size];
  CGRect textRect = [self.textInput textRectThatFitsForBounds:bounds];

  CGFloat underlineVerticalPadding = MDCTextInputUnderlineVerticalPadding;
  if ([self.textInput respondsToSelector:@selector(underlineVerticalPadding)]) {
    underlineVerticalPadding = self.textInput.underlineVerticalPadding;
  }

  if ([self.textInput isKindOfClass:[UITextView class]]) {
    // For multiline text fields, the textRectThatFitsForBounds is essentially the text container
    // and we can just measure from the bottom.
    underlineFrame.origin.y =
    CGRectGetMaxY(textRect) + underlineVerticalPadding - underlineFrame.size.height;
  } else {
    // For single line text fields, the textRectThatFitsForBounds is a best guess at the text
    // rect for the line of text, which may be rect adjusted for pixel boundaries.  Measure from the
    // center to get the best underline placement.
    underlineFrame.origin.y = CGRectGetMidY(textRect) + (self.textInput.font.pointSize / 2.0f) +
    underlineVerticalPadding - underlineFrame.size.height;
  }

  return underlineFrame;
}

#pragma mark - Properties Implementation

- (NSString *)placeholder {
  id placeholderString = self.placeholderLabel.text;
  if ([placeholderString isKindOfClass:[NSString class]]) {
    return (NSString *)placeholderString;
  } else if ([placeholderString isKindOfClass:[NSAttributedString class]]) {
    return [(NSAttributedString *)placeholderString string];
  }

  return nil;
}

- (void)setPlaceholder:(NSString *)placeholder {
  self.placeholderLabel.text = placeholder;
  [self updatePlaceholderAlpha];
  [self.textInput setNeedsLayout];
}

- (NSAttributedString *)attributedPlaceholder {
  id placeholderString = self.placeholderLabel.text;
  if ([placeholderString isKindOfClass:[NSString class]]) {
    // TODO(larche) Return string attributes also. Tho I feel like that should come from the titleView / placeholderLabel
    NSAttributedString *constructedString = [[NSAttributedString alloc] initWithString:(NSString *)placeholderString attributes:nil];
    return constructedString;
  } else if ([placeholderString isKindOfClass:[NSAttributedString class]]) {
    return (NSAttributedString *)placeholderString;
  }

  return nil;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  self.placeholderLabel.text = attributedPlaceholder.string;
  // TODO(larche) Read string attributes also. Tho I feel like that should come from the titleView / placeholderLabel

  [self updatePlaceholderAlpha];
  [self.textInput setNeedsLayout];
}

- (void)setEnabled:(BOOL)enabled {
  _enabled = enabled;
  self.underlineView.enabled = enabled;
}

//- (void)setPresentationStyle:(MDCTextInputPresentationStyle)presentationStyle {
//  if (_presentationStyle != presentationStyle) {
//    _presentationStyle = presentationStyle;
//    [self removeCharacterCountLimit];
//    [self updateCharacterCountLimit];
//    if (_presentationStyle == MDCTextInputPresentationStyleFullWidth) {
//      [_underlineView removeFromSuperview];
//      _underlineView = nil;
//    }
//    [self.textInput setNeedsLayout];
//  }
//}

- (void)setTextColor:(UIColor *)textColor {
  if (!textColor) {
    textColor = MDCTextInputTextColor();
  }

  if (_textColor != textColor) {
    _textColor = textColor;
    [self updateColors];
  }
}

// TODO(larche) Check this removal of setUnderlineViewMode.
- (void)updatePlaceholderPosition {
  CGRect frame = [self placeholderDefaultPositionFrame];

  self.placeholderLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
  self.placeholderLabel.center = frame.origin;
}

- (CGRect)placeholderFloatingPositionFrame {
  CGRect placeholderRect = [self placeholderDefaultPositionFrame];
  if (CGRectIsEmpty(placeholderRect)) {
    return placeholderRect;
  }

  //  placeholderRect.origin.y -= MDCTextInputFloatingLabelMargin + MDCTextInputFloatingLabelTextHeight;

  // In RTL Layout, make the title view go up and to the right.
  //  if ([self shouldLayoutForRTL]) {
  //    placeholderRect.origin.x =
  //    CGRectGetWidth(self.textInput.bounds) -
  //    placeholderRect.size.width * self.floatingPlaceholderScaleTransform.a;
  //  }

  return placeholderRect;
}

- (CGRect)placeholderDefaultPositionFrame {
  CGRect bounds = self.textInput.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect placeholderRect = [self.textInput textRectThatFitsForBounds:bounds];
  // Calculating the offset to account for a rightView in case it is needed for RTL layout,
  // before the placeholderRect is modified to be just wide enough for the text.
  CGFloat placeholderLeftViewOffset =
  CGRectGetWidth(bounds) - CGRectGetWidth(placeholderRect) - CGRectGetMinX(placeholderRect);
  CGFloat placeHolderWidth = [self placeHolderRequiredWidth];
  placeholderRect.size.width = placeHolderWidth;
  if ([self shouldLayoutForRTL]) {
    // The leftView (or leading view) of a UITextInput is placed before the text.  The rect
    // returned by UITextInput::textRectThatFitsForBounds: returns a rect that fills the field
    // from the trailing edge of the leftView to the leading edge of the rightView.  Since this
    // rect is not used directly for the placeholder, the space for the leftView must calculated
    // to determine the correct origin for the placeholder view when rendering for RTL text.
    placeholderRect.origin.x =
    CGRectGetWidth(self.textInput.bounds) - placeHolderWidth - placeholderLeftViewOffset;
  }
  placeholderRect.size.height = self.fontHeight;
  return placeholderRect;
}

- (CGFloat)placeHolderRequiredWidth {
  if (!self.textInput.font) {
    return 0;
  }
  return [self.placeholder sizeWithAttributes:@{NSFontAttributeName : self.textInput.font}].width;
}

- (void)updatePlaceholderAlpha {
  CGFloat opacity = self.textInput.text.length ? 0 : 1;
  self.placeholderLabel.alpha = opacity;
}

#pragma mark - Private

- (void)updateColors {
  self.textInput.tintColor = MDCTextInputCursorColor();
  self.textInput.textColor = self.textColor;

  self.underlineView.unfocusedColor = self.underlineColor;
}

- (UIView *)textInputLabel {
  Class targetClass = NSClassFromString(@"UITextInputLabel");
  // Loop through the text field's views until we find the UITextInputLabel which is used for the
  // label in UITextInput.
  NSMutableArray *toVisit = [NSMutableArray arrayWithArray:self.textInput.subviews];
  while ([toVisit count]) {
    UIView *view = [toVisit objectAtIndex:0];
    if ([view isKindOfClass:targetClass]) {
      return view;
    }
    [toVisit addObjectsFromArray:view.subviews];
    [toVisit removeObjectAtIndex:0];
  }
  return nil;
}

- (CGFloat)fontHeight {
  return MDCCeil(self.textInput.font.lineHeight);
}

@end
