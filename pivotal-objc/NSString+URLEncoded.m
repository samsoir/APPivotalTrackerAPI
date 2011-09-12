//
//  NSString+URLEncoded.m
//  Scrummage
//
//  Created by Sam de Freyssinet on 12/09/2011.
//  Copyright 2011 Adapter Pattern. All rights reserved.
//

#import "NSString+URLEncoded.h"

@implementation NSString (NSString_URLEncoded)

/*
 Creates a URL Encoded string from itself
 */
- (NSString *) getURLEncodedString
{
	NSString *encodedString = 
		(NSString *)CFURLCreateStringByAddingPercentEscapes(
			NULL, 
			(CFStringRef) self, 
			NULL, 
			(CFStringRef)NSSTRING_URL_ENCODINGS,
			kCFStringEncodingUTF8
		);

	// Close potential memory leak
	return [encodedString autorelease];
}

@end
