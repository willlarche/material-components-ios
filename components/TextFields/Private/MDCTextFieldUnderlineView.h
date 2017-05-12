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

#import <UIKit/UIKit.h>

/**
 * A view that draws the underline effect for an instance of GOOTextField. The underline has three
 * possible states enabled && unfocused, enabled && focused, diabled, each with different colors and
 * style.
 *
 * @ingroup GOOInputs
 */
@interface GOOUnderlineView : UIView
@property(nonatomic, strong) UIColor *focusedColor;
@property(nonatomic, strong) UIColor *unfocusedColor;
@property(nonatomic, strong) UIColor *errorColor;
@property(nonatomic, assign) BOOL enabled;
@property(nonatomic, assign) BOOL erroneous;
@property(nonatomic, assign) BOOL focusBorderHidden;
@property(nonatomic, assign) BOOL normalBorderHidden;
@property(nonatomic, strong) CAShapeLayer *disabledBorder;
@property(nonatomic, strong) CALayer *focusedBorder;

- (void)animateFocusBorderIn;

- (void)animateFocusBorderOut;

@end
