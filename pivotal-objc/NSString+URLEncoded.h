//
//  NSString+URLEncoded.h
//  Scrummage
//
//  Created by Sam de Freyssinet on 12/09/2011.
//  Copyright 2011 Adapter Pattern. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef NSSTRING_URL_ENCODINGS
	#define NSSTRING_URL_ENCODINGS @"!*'\"();@:&=+$,/?%#[]% "
#endif

@interface NSString (NSString_URLEncoded)

/* Creates a URL Encoded string from itself */
- (NSString *) getURLEncodedString;

@end
