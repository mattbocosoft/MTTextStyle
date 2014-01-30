//
//  MTTextStyle.m
//
//  Created by Matthew Thomas on 4/18/13.
//

#import "MTTextStyle.h"
#import <objc/runtime.h>

@implementation MTTextStyle

// Set this to YES to help locate text that is using this
// "style sheet"... by setting all conforming text to a
// distinct-looking "Chalkduster" font.
// Anything that doesn't have this font is not centralized.
BOOL decentralizedStyledTextLocator = NO;

+ (void) startDecentralizedStyledTextLocator
{
	decentralizedStyledTextLocator = YES;
}

+ (void) stopDecentralizedStyledTextLocator
{
	decentralizedStyledTextLocator = NO;
}

+ (BOOL) isDecentralizedStyledTextLocatorActivated
{
	return decentralizedStyledTextLocator;
}

+ (MTTextStyle*) styleWithFontName:(NSString*)fontName fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor shadowColor:(UIColor*)shadowColor shadowOffset:(CGSize)shadowOffset highlightedTextColor:(UIColor*)highlightedTextColor
{
	MTTextStyle *textStyle = [[MTTextStyle alloc] init];

	[textStyle setFontName:fontName];
	[textStyle setFontSize:fontSize];
	[textStyle setTextColor:textColor];
	[textStyle setShadowColor:shadowColor];
	[textStyle setShadowOffset:shadowOffset];
	[textStyle setHighlightedTextColor:highlightedTextColor];
	
	return textStyle;
}

+ (NSString*) standardFontName
{
	return @"Avenir-Book";
}

+ (MTTextStyle*) styleForStyleType:(MTTextStyleType)styleType
{
	MTTextStyle *textStyle = [[MTTextStyle alloc] init];

	NSString *fontName = nil;
	CGFloat fontSize = 0.0f;
	UIColor *textColor = nil;
	UIColor *shadowColor = nil;
	CGSize shadowOffset = CGSizeMake(0.0, 0.0);
	UIColor *highlightedTextColor = nil;
	
	switch (styleType)
	{
		case MTTextStyleTypeHeadline:
		{
			fontName = [self standardFontName];
			fontSize = 18.0f;
			textColor = [UIColor blackColor];
			shadowColor = [UIColor clearColor];
			shadowOffset = CGSizeZero;
			break;
		}
		case MTTextStyleTypeSubheadline:
		{
			fontName = [self standardFontName];
			fontSize = 15.0f;
			textColor = [UIColor lightGrayColor];
			shadowColor = [UIColor clearColor];
			shadowOffset = CGSizeZero;
			break;
		}
		case MTTextStyleTypeBody:
		{
			fontName = [self standardFontName];
			fontSize = 13.0f;
			textColor = [UIColor blackColor];
			shadowColor = [UIColor clearColor];
			shadowOffset = CGSizeZero;
			break;
		}
		case MTTextStyleTypeFootnote:
		{
			fontName = [self standardFontName];
			fontSize = 12.0f;
			textColor = [UIColor darkGrayColor];
			shadowColor = [UIColor clearColor];
			shadowOffset = CGSizeZero;
			break;
		}
		case MTTextStyleTypeCaption1:
		{
			fontName = [self standardFontName];
			fontSize = 15.0f;
			textColor = [UIColor darkGrayColor];
			shadowColor = [UIColor clearColor];
			shadowOffset = CGSizeZero;
			break;
		}
		case MTTextStyleTypeCaption2:
		{
			fontName = [self standardFontName];
			fontSize = 15.0f;
			textColor = [UIColor darkGrayColor];
			shadowColor = [UIColor clearColor];
			shadowOffset = CGSizeZero;
			break;
		}
		case MTTextStyleTypePlaceholderText:
		{
			fontName = [self standardFontName];
			fontSize = 15.0f;
			textColor = [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1.0f];
			shadowColor = [UIColor clearColor];
			shadowOffset = CGSizeZero;
			break;
		}
		case MTTextStyleTypeSectionTitle:
		{
			fontName = [self standardFontName];
			fontSize = 15.0f;
			textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
			shadowColor = [UIColor whiteColor];
			shadowOffset = CGSizeMake(0, -1);
			highlightedTextColor = [UIColor colorWithWhite:1.0 alpha:0.5];
			break;
		}
		case MTTextStyleTypeCellMainText:
		{
			fontName = [self standardFontName];
			fontSize = 15.0f;
			textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
			shadowColor = [UIColor whiteColor];
			shadowOffset = CGSizeMake(0, 0);
			highlightedTextColor = [UIColor whiteColor];
			break;
		}
		case MTTextStyleTypeCellSubtitleText:
		{
			fontName = [self standardFontName];
			fontSize = 13.0f;
			textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
			shadowColor = [UIColor whiteColor];
			shadowOffset = CGSizeMake(0, 0);
			highlightedTextColor = [UIColor whiteColor];
			break;
		}
		case MTTextStyleTypeStandardFont:
		{
			fontName = [self standardFontName];
			break;
		}
		default:
			break;
	}

	[textStyle setFontName:fontName];
	[textStyle setFontSize:fontSize];
	[textStyle setTextColor:textColor];
	[textStyle setShadowColor:shadowColor];
	[textStyle setShadowOffset:shadowOffset];
	[textStyle setHighlightedTextColor:highlightedTextColor];

	return textStyle;
}

+ (MTTextStyle*) styleForStyleType:(MTTextStyleType)styleType overrideFontSize:(CGFloat)fontSize
{
	MTTextStyle *aStyle = [self styleForStyleType:styleType];
	aStyle.fontSize = fontSize;
	return aStyle;
}

+ (CGFloat) preferredFontSizeForBaseFontSize:(CGFloat)baseFontSize
{
	if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
		return baseFontSize;

	NSDictionary *fontSizeDictionary = @{UIContentSizeCategoryExtraSmall: @(-3),
										 UIContentSizeCategorySmall : @(-2),
										 UIContentSizeCategoryMedium : @(-1),
										 UIContentSizeCategoryLarge : @(0), // Normal
										 UIContentSizeCategoryExtraLarge : @(1),
										 UIContentSizeCategoryExtraExtraLarge : @(2),
										 UIContentSizeCategoryExtraExtraExtraLarge : @(3)};

	NSDictionary *fontSizeDictionaryForAccessibility = @{UIContentSizeCategoryAccessibilityMedium: @(4),
														 UIContentSizeCategoryAccessibilityLarge : @(5),
														 UIContentSizeCategoryAccessibilityExtraLarge : @(6),
														 UIContentSizeCategoryAccessibilityExtraExtraLarge : @(7),
														 UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @(8)};
	
	CGFloat minimumFontSize = 10.0f;
	CGFloat maximumFontSize = 32.0f;
	
	CGFloat preferredFontSize = baseFontSize;
	
	NSString *contentSizeCategory = [[UIApplication sharedApplication] preferredContentSizeCategory];
	if(fontSizeDictionary[contentSizeCategory])
		preferredFontSize = baseFontSize + [fontSizeDictionary[contentSizeCategory] floatValue];
	else if(fontSizeDictionaryForAccessibility[contentSizeCategory])
		preferredFontSize = baseFontSize + [fontSizeDictionaryForAccessibility[contentSizeCategory] floatValue];
	
	return MIN(MAX(preferredFontSize, minimumFontSize), maximumFontSize);
}

#pragma mark - Return just the font of the style

- (UIFont*) font
{
	if(self.fontName && self.fontSize != 0.0f)
		return [UIFont fontWithName:self.fontName size:self.fontSize];
	
	return nil;
}

- (void) setFont:(UIFont*)aFont
{
	self.fontName = aFont.fontName;
	self.fontSize = aFont.pointSize;
}

#pragma mark - Generate an attributes dictionary for the style

- (NSDictionary*) attributesDictionary
{
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	
	if(self.fontName && self.fontSize != 0.0f)
	{
		[attributes addEntriesFromDictionary:@{NSFontAttributeName : [UIFont fontWithName:self.fontName size:self.fontSize]}];
	}
	else if(self.fontName)
	{
		[attributes addEntriesFromDictionary:@{NSFontAttributeName : [UIFont fontWithName:self.fontName size:self.font.pointSize]}];
	}
	else
	{
		[attributes addEntriesFromDictionary:@{NSFontAttributeName : [self.font fontWithSize:self.fontSize]}];
	}
	
	if(self.textColor)
		[attributes addEntriesFromDictionary:@{NSForegroundColorAttributeName : self.textColor}];
	
	if(self.shadowColor && !CGSizeEqualToSize(self.shadowOffset, CGSizeMake(NSNotFound, NSNotFound)))
	{
		NSShadow *shadow = [[NSShadow alloc] init];
		shadow.shadowColor = self.shadowColor;
		shadow.shadowBlurRadius = 0.0;
		shadow.shadowOffset = self.shadowOffset;
		
		[attributes addEntriesFromDictionary:@{NSShadowAttributeName: shadow}];
	}
	
	// No way to handle highlighted color as of yet
	
	return [attributes copy];
}

#pragma mark -

//TODO: Reapply style to context when preferred font size changes in Settings

- (void) applyStyleToContext:(CGContextRef)context
{
	if(self.textColor)
		CGContextSetStrokeColorWithColor(context, self.textColor.CGColor);
	
	CGSize shadowOffsetSize = CGSizeMake(0, 0);
	if(!CGSizeEqualToSize(self.shadowOffset, CGSizeMake(NSNotFound, NSNotFound)))
		shadowOffsetSize = self.shadowOffset;
	
	if(self.shadowColor)
		CGContextSetShadowWithColor(context, shadowOffsetSize, 2.0f, self.shadowColor.CGColor);
}

#pragma mark - Decentralized Styled-Text Locator Support

- (NSString*)fontName
{
	if(decentralizedStyledTextLocator)
		return @"Chalkduster";

	return _fontName;
}

- (CGFloat) fontSize
{
	if(decentralizedStyledTextLocator)
		return 15.0f;

	if(_fontSize == 0.0f)
		return _fontSize;

	return [MTTextStyle preferredFontSizeForBaseFontSize:_fontSize];
}

- (UIColor*) textColor
{
	if(decentralizedStyledTextLocator)
		return [[UIColor greenColor] colorWithAlphaComponent:0.3f];

	return _textColor;
}

- (UIColor*) shadowColor
{
	if(decentralizedStyledTextLocator)
		return [[UIColor blackColor] colorWithAlphaComponent:0.3f];

	return _shadowColor;
}

- (CGSize) shadowOffset
{
	if(decentralizedStyledTextLocator)
		return CGSizeMake(0.0f, 1.0f);

	return _shadowOffset;
}

- (UIColor*) highlightedTextColor
{
	if(decentralizedStyledTextLocator)
		return [[UIColor purpleColor] colorWithAlphaComponent:0.3f];

	return _highlightedTextColor;
}

- (NSString*) description
{
	NSMutableString *descriptionString = [NSMutableString string];
	[descriptionString appendFormat:@"FontName : %@\n", self.fontName];
	[descriptionString appendFormat:@"FontSize : %f\n", self.fontSize];
	[descriptionString appendFormat:@"TextColor : %@\n", self.textColor];
	[descriptionString appendFormat:@"ShadowColor : %@\n", self.shadowColor];
	[descriptionString appendFormat:@"ShadowOffset : %@\n", NSStringFromCGSize(self.shadowOffset)];
	[descriptionString appendFormat:@"ShadowOffset : %@\n", NSStringFromCGSize(self.shadowOffset)];
	[descriptionString appendFormat:@"HighlightedTextColor : %@", self.highlightedTextColor];

	return [descriptionString copy];
}

@end

#pragma mark - UI Text Element Categories for applying MTStyles

static const char *associatedTextStyleKey = "associatedTextStyleKey";

@implementation UILabel (MTStyling)

+ (void) load
{
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
		[self performDeallocSwizzle];
}

+ (void) performDeallocSwizzle
{
	Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
	Method swizzledMethod = class_getInstanceMethod(self, @selector(swizzled_Dealloc));
	method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void) swizzled_Dealloc
{
	objc_setAssociatedObject(self, associatedTextStyleKey, nil, OBJC_ASSOCIATION_RETAIN);
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIContentSizeCategoryDidChangeNotification
												  object:nil];
	
	[self swizzled_Dealloc];
}

- (void) applyMTTextStyle:(MTTextStyle*)style
{
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
	{
		// Save style as hidden property of class
		objc_setAssociatedObject(self, associatedTextStyleKey, nil, OBJC_ASSOCIATION_RETAIN);
		objc_setAssociatedObject(self, associatedTextStyleKey, style, OBJC_ASSOCIATION_RETAIN);
		
		// Receive notifications and reapply style when preferred text size changes
		[[NSNotificationCenter defaultCenter] removeObserver:self
														name:UIContentSizeCategoryDidChangeNotification
													  object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(userTextSizeDidChange)
													 name:UIContentSizeCategoryDidChangeNotification
												   object:nil];
	}

	if(style.fontName && style.fontSize != 0.0f)
	{
		[self setFont:[style font]];
	}
	else if(style.fontName)
	{
		[self setFont:[UIFont fontWithName:style.fontName size:[MTTextStyle preferredFontSizeForBaseFontSize:self.font.pointSize]]];
	}
	else
	{
		[self setFont:[self.font fontWithSize:style.fontSize]];
	}
	
	if(style.textColor)
		[self setTextColor:style.textColor];
	
	if(style.shadowColor)
		[self setShadowColor:style.shadowColor];
	
	if(!CGSizeEqualToSize(style.shadowOffset, CGSizeMake(NSNotFound, NSNotFound)))
		[self setShadowOffset:style.shadowOffset];

	if(style.highlightedTextColor)
		[self setHighlightedTextColor:style.highlightedTextColor];
}

- (void) userTextSizeDidChange
{
	MTTextStyle *textStyle = (MTTextStyle*)objc_getAssociatedObject(self, associatedTextStyleKey);
	[self applyMTTextStyle:textStyle];
}

@end

#import <objc/runtime.h>

@implementation UITextField (MTStyling)

// If SWIZZLING dealloc CAUSES PROBLEMS in the future then we have two options:
// 1) Create a UITextField subclass and...
//		a) Register for UIContentSizeCategoryDidChangeNotification notifications in init
//		b) Unregister for UIContentSizeCategoryDidChangeNotification notifications in dealloc
//		c) Use this UITextField subclass throughout the app
// 2) Don't register UIControls for UIContentSizeCategoryDidChangeNotification notification
//		a) ...Instead, register on each UIViewController and leave it up to each view controller
//			to re-apply styles and call invalidateIntrinsicContentSize when the notification is sent

+ (void) load
{
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
		[self performDeallocSwizzle];
}

+ (void) performDeallocSwizzle
{
	Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
	Method swizzledMethod = class_getInstanceMethod(self, @selector(swizzled_Dealloc));
	method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void) swizzled_Dealloc
{
	objc_setAssociatedObject(self, associatedTextStyleKey, nil, OBJC_ASSOCIATION_RETAIN);
	objc_setAssociatedObject(self, associatedPlaceholderTextStyleKey, nil, OBJC_ASSOCIATION_RETAIN);
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIContentSizeCategoryDidChangeNotification
												  object:nil];

	[self swizzled_Dealloc];
}

- (void) applyMTTextStyle:(MTTextStyle*)style
{
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
	{
		// Save style as hidden property of class
		objc_setAssociatedObject(self, associatedTextStyleKey, nil, OBJC_ASSOCIATION_RETAIN);
		objc_setAssociatedObject(self, associatedTextStyleKey, style, OBJC_ASSOCIATION_RETAIN);
		
		// Receive notifications and reapply style when preferred text size changes
		[[NSNotificationCenter defaultCenter] removeObserver:self
														name:UIContentSizeCategoryDidChangeNotification
													  object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(userTextSizeDidChange)
													 name:UIContentSizeCategoryDidChangeNotification
												   object:nil];
	}

	if(style.fontName && style.fontSize != 0.0f)
	{
		[self setFont:[UIFont fontWithName:style.fontName size:style.fontSize]];
	}
	else if(style.fontName)
	{
		[self setFont:[UIFont fontWithName:style.fontName size:self.font.pointSize]];
	}
	else
	{
		[self setFont:[self.font fontWithSize:style.fontSize]];
	}

	if(style.textColor)
		[self setTextColor:style.textColor];

	// TODO: Shadow using CALayer?
}

static const char *associatedPlaceholderTextStyleKey = "associatedPlaceholderTextStyleKey";

- (void) applyMTTextStyleForPlaceholder:(MTTextStyle *)style
{
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
	{
		// Save style as hidden property of class
		objc_setAssociatedObject(self, associatedPlaceholderTextStyleKey, nil, OBJC_ASSOCIATION_RETAIN);
		objc_setAssociatedObject(self, associatedPlaceholderTextStyleKey, style, OBJC_ASSOCIATION_RETAIN);
		
		// Receive notifications and reapply style when preferred text size changes
		[[NSNotificationCenter defaultCenter] removeObserver:self
														name:UIContentSizeCategoryDidChangeNotification
													  object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(userTextSizeDidChange)
													 name:UIContentSizeCategoryDidChangeNotification
												   object:nil];
	}

	NSDictionary *attributes = [style attributesDictionary];

	if(self.attributedPlaceholder)
		self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithString:self.attributedPlaceholder.string]
																	 attributes:attributes];
	else if(self.placeholder)
		self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithString:self.placeholder]
																	 attributes:attributes];
	else
		self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:attributes];

	// TODO: Shadow using CALayer?
}

- (void) userTextSizeDidChange
{
	MTTextStyle *textStyle = (MTTextStyle*)objc_getAssociatedObject(self, associatedTextStyleKey);
	MTTextStyle *placeholderTextStyle = (MTTextStyle*)objc_getAssociatedObject(self, associatedPlaceholderTextStyleKey);
	
	if(textStyle)
		[self applyMTTextStyle:textStyle];

	if(placeholderTextStyle)
		[self applyMTTextStyleForPlaceholder:placeholderTextStyle];
}

@end


@implementation UITextView (MTStyling)

// If SWIZZLING dealloc CAUSES PROBLEMS in the future then we have two options:
// 1) Create a UITextField subclass and...
//		a) Register for UIContentSizeCategoryDidChangeNotification notifications in init
//		b) Unregister for UIContentSizeCategoryDidChangeNotification notifications in dealloc
//		c) Use this UITextField subclass throughout the app
// 2) Don't register UIControls for UIContentSizeCategoryDidChangeNotification notification
//		a) ...Instead, register on each UIViewController and leave it up to each view controller
//			to re-apply styles and call invalidateIntrinsicContentSize when the notification is sent

+ (void) load
{
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
		[self performDeallocSwizzle];
}

+ (void) performDeallocSwizzle
{
	Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
	Method swizzledMethod = class_getInstanceMethod(self, @selector(swizzled_Dealloc));
	method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void) swizzled_Dealloc
{
	objc_setAssociatedObject(self, associatedTextStyleKey, nil, OBJC_ASSOCIATION_RETAIN);
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIContentSizeCategoryDidChangeNotification
												  object:nil];
	
	[self swizzled_Dealloc];
}

- (void) applyMTTextStyle:(MTTextStyle*)style
{
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
	{
		// Save style as hidden property of class
		objc_setAssociatedObject(self, associatedTextStyleKey, nil, OBJC_ASSOCIATION_RETAIN);
		objc_setAssociatedObject(self, associatedTextStyleKey, style, OBJC_ASSOCIATION_RETAIN);
		
		// Receive notifications and reapply style when preferred text size changes
		[[NSNotificationCenter defaultCenter] removeObserver:self
														name:UIContentSizeCategoryDidChangeNotification
													  object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(userTextSizeDidChange)
													 name:UIContentSizeCategoryDidChangeNotification
												   object:nil];
	}

	if(style.fontName && style.fontSize != 0.0f)
	{
		[self setFont:[UIFont fontWithName:style.fontName size:style.fontSize]];
	}
	else if(style.fontName)
	{
		[self setFont:[UIFont fontWithName:style.fontName size:self.font.pointSize]];
	}
	else
	{
		[self setFont:[self.font fontWithSize:style.fontSize]];
	}
	
	if(style.textColor)
		[self setTextColor:style.textColor];

	// TODO: Shadow using CALayer?
	// TODO: Apply styles as attributes to attributed text?
}

- (void) userTextSizeDidChange
{
	MTTextStyle *textStyle = (MTTextStyle*)objc_getAssociatedObject(self, associatedTextStyleKey);
	[self applyMTTextStyle:textStyle];
}

@end

@implementation UIButton (MTStyling)

// If SWIZZLING dealloc CAUSES PROBLEMS in the future then we have two options:
// 1) Create a UITextField subclass and...
//		a) Register for UIContentSizeCategoryDidChangeNotification notifications in init
//		b) Unregister for UIContentSizeCategoryDidChangeNotification notifications in dealloc
//		c) Use this UITextField subclass throughout the app
// 2) Don't register UIControls for UIContentSizeCategoryDidChangeNotification notification
//		a) ...Instead, register on each UIViewController and leave it up to each view controller
//			to re-apply styles and call invalidateIntrinsicContentSize when the notification is sent

+ (void) load
{
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
		[self performDeallocSwizzle];
}

+ (void) performDeallocSwizzle
{
	Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
	Method swizzledMethod = class_getInstanceMethod(self, @selector(swizzled_Dealloc));
	method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void) swizzled_Dealloc
{
	objc_setAssociatedObject(self, associatedTextStyleKey, nil, OBJC_ASSOCIATION_RETAIN);
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIContentSizeCategoryDidChangeNotification
												  object:nil];
	
	[self swizzled_Dealloc];
}

- (void) applyMTTextStyle:(MTTextStyle*)style
{
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
	{
		// Save style as hidden property of class
		objc_setAssociatedObject(self, associatedTextStyleKey, nil, OBJC_ASSOCIATION_RETAIN);
		objc_setAssociatedObject(self, associatedTextStyleKey, style, OBJC_ASSOCIATION_RETAIN);
		
		// Receive notifications and reapply style when preferred text size changes
		[[NSNotificationCenter defaultCenter] removeObserver:self
														name:UIContentSizeCategoryDidChangeNotification
													  object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(userTextSizeDidChange)
													 name:UIContentSizeCategoryDidChangeNotification
												   object:nil];
	}

	if(style.fontName && style.fontSize != 0.0f)
	{
		[self.titleLabel setFont:[UIFont fontWithName:style.fontName size:style.fontSize]];
	}
	else if(style.fontName)
	{
		[self.titleLabel setFont:[UIFont fontWithName:style.fontName size:self.titleLabel.font.pointSize]];
	}
	else
	{
		[self.titleLabel setFont:[self.titleLabel.font fontWithSize:style.fontSize]];
	}

	if(style.textColor)
		[self setTitleColor:style.textColor forState:UIControlStateNormal];

	if(style.shadowColor)
		[self setTitleShadowColor:style.shadowColor forState:UIControlStateNormal];

	if(!CGSizeEqualToSize(style.shadowOffset, CGSizeMake(NSNotFound, NSNotFound)))
		[self.titleLabel setShadowOffset:style.shadowOffset];

	if(style.highlightedTextColor)
		[self.titleLabel setHighlightedTextColor:style.highlightedTextColor];
}

- (void) userTextSizeDidChange
{
	MTTextStyle *textStyle = (MTTextStyle*)objc_getAssociatedObject(self, associatedTextStyleKey);
	[self applyMTTextStyle:textStyle];
}

@end
