MTTextStyle
===========

Centralize your app's text styles and take advantage of iOS 7 dynamic font sizing for free.

Easily apply centralized text styles to text UI elements like UILabel, UITextView, UITextField, UIButton and even drawing context (CGContextRef). Respect user settings of font size and updates live if user changes preferred font size.

Locate text throughout the appliation that hasn't been centralized by setting decentralizedStyledTextLocator to YES. Text that hasn't been centralized will not be affected, while centralized text will turn green and use Chalkduster font.


Usage
-----

    [self.myLabel applyMTTextStyle:[MTTextStyle styleForStyleType:MTTextStyleTypeBody]];
