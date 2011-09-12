//
//  APPivotalTrackerAuthToken.m
//  APPivotalTrackerAPI
//
//  Created by Sam de Freyssinet on 12/09/2011.
//
//  ISC License (ISC)
//
//  Copyright 2011 Adapter Pattern. All rights reserved.
//
//  Permission to use, copy, modify, and/or distribute this software for any 
//  purpose with or without fee is hereby granted, provided that the above 
//  copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES 
//  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF 
//  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR 
//  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
//  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR 
//  IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

#import "APPivotalTrackerAuthToken.h"

@implementation APPivotalTrackerAuthToken
@synthesize token = _token;
@synthesize tokenType = _tokenType;
@synthesize username = _username;
@synthesize password = _password;

- (id)initWithUsername:(NSString *) username password:(NSString *) password
{
	self = [self init];
	
	if (self)
	{
		self.username = username;
		self.password = password;
	}
	
	return self;
}

- (NSURL *)getPivotalURLUsingEncodedAuth
{
	
	NSString *urlString = [[NSString alloc] 
						   initWithFormat:
						   @"https://%@:%@@www.pivotaltracker.com/services/v3/tokens/active",
						   [self.username getURLEncodedString], 
						   [self.password getURLEncodedString]];
	
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	
	[urlString release];
	
	return [url autorelease];
}

/*
 Initializes the library
 */
- (id)init
{
    self = [super init];
    if (self) {
		
    }
    
    return self;
}

/*
 Tidy up
 */
- (void) dealloc
{
	[_token release];
	[_username release];
	[_password release];
	
	[super dealloc];
}

@end