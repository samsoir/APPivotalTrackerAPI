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
 Gets the pivotal auth token
 */
- (void)getPivotalToken:(NSURL *)url
{
	[_connection initWithRequest:[NSURLRequest requestWithURL:url] 
						delegate:self];
	
	[_connection start];
}

/*
 Initializes the library
 */
- (id)init
{
    self = [super init];
    if (self) {
		_tokenXML = [NSMutableData alloc];
		_connection = [NSURLConnection alloc];
    }
    
    return self;
}

/*
 Tidy up
 */
- (void) dealloc
{
	[_username release];
	[_password release];
	[_token release];
	[_tokenXML release];
	[_connection release];
	
	[super dealloc];
}

#pragma mark -- NSURLConnectionDelegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	NSLog(@"Did receive HTTP auth challenge: %@", challenge);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSLog(@"Did receive response: \n %@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_tokenXML appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"\n\n%@", [NSString stringWithUTF8String:[_tokenXML bytes]]);
	[_connection release];
	_connection = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"Did fail with error: \n %@", error);	
}

@end