//
//  MTTextStyle.h
//
//  Created by Matthew Thomas on 4/18/13.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MTTextStyleType) {

	MTTextStyleTypeStandardFont, // Just apply standard font, leave other properties alone

	// Apple Standard Font Text Styles
	MTTextStyleTypeHeadline, // UIFontTextStyleHeadline (View headers)
	MTTextStyleTypeSubheadline, // UIFontTextStyleSubheadline (View subtitles)
	MTTextStyleTypeBody, // UIFontTextStyleBody
	MTTextStyleTypeFootnote, // UIFontTextStyleFootnote
	MTTextStyleTypeCaption1, // UIFontTextStyleCaption1
	MTTextStyleTypeCaption2, // UIFontTextStyleCaption2

	MTTextStyleTypePlaceholderText, // Textfield, search bar placeholder text
	MTTextStyleTypeSectionTitle, // For section headers
	MTTextStyleTypeCellMainText, // Cell title label
	MTTextStyleTypeCellSubtitleText, // Cell detail label
//	MTTextStyleTypeControlText, // For controls?
//	MTTextStyleTypeInputField, // For text view and text field
//	MTTextStyleTypeButtonText, // UIButton
//	MTTextStyleTypeDataLabelText, // For data-key labels
//	MTTextStyleTypeDataValueText, // For data-value label
//	MTTextStyleTypeEmptyDataText, // For "no data" labels
//	MTTextStyleTypeLoadMoreText, // For "load more"-type labels
};

@interface MTTextStyle : NSObject

@property (strong, nonatomic) NSString *fontName;
@property (assign, nonatomic) CGFloat fontSize;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *shadowColor;
@property (assign, nonatomic) CGSize shadowOffset;
@property (strong, nonatomic) UIColor *highlightedTextColor;

+ (void) startDecentralizedStyledTextLocator;
+ (void) stopDecentralizedStyledTextLocator;
+ (BOOL) isDecentralizedStyledTextLocatorActivated;

+ (NSString*) standardFontName;
+ (MTTextStyle*) styleWithFontName:(NSString*)fontName fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor shadowColor:(UIColor*)shadowColor shadowOffset:(CGSize)shadowOffset highlightedTextColor:(UIColor*)highlightedTextColor;
+ (MTTextStyle*) styleForStyleType:(MTTextStyleType)StyleType;
+ (MTTextStyle*) styleForStyleType:(MTTextStyleType)styleType overrideFontSize:(CGFloat)fontSize;

+ (CGFloat) preferredFontSizeForBaseFontSize:(CGFloat)baseFontSize;

- (UIFont*) font;
- (void) setFont:(UIFont*)aFont;

- (NSDictionary*) attributesDictionary;

- (void) applyStyleToContext:(CGContextRef)context;

@end

#pragma mark - UI Text Element Categories for applying MTStyles

@interface UILabel (MTStyling)

- (void) applyMTTextStyle:(MTTextStyle*)style;

@end

@interface UITextField (MTStyling)

- (void) applyMTTextStyle:(MTTextStyle*)style;
- (void) applyMTTextStyleForPlaceholder:(MTTextStyle *)style;

@end

@interface UITextView (MTStyling)

- (void) applyMTTextStyle:(MTTextStyle*)style;

@end

@interface UIButton (MTStyling)

- (void) applyMTTextStyle:(MTTextStyle*)style;

@end
