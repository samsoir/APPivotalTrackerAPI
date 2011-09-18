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
@synthesize error = _error;

- (id)initWithUsername:(NSString *) username password:(NSString *) password
{
	self = [self init];
	
	if (self)
	{
		self.username = username;
		self.password = password;
		_error = nil;
		_delegate = nil;
	}
	
	return self;
}

- (id <APPivotalTrackerAuthTokenDelegate>)delegate;
{
	return (id <APPivotalTrackerAuthTokenDelegate>)_delegate;
}

- (void)setDelegate:(id <APPivotalTrackerAuthTokenDelegate>)delegate
{
	_delegate = [delegate retain];
}

- (NSURL *)getPivotalURLUsingEncodedAuth
{
	NSString *urlString = [NSString stringWithFormat:@"https://%@:%@@www.pivotaltracker.com/services/v3/tokens/active",[self.username getURLEncodedString], [self.password getURLEncodedString]];
	
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	
	return [url autorelease];
}

- (void)getPivotalToken:(NSURL *)url
{
	[_connection initWithRequest:[NSURLRequest requestWithURL:url] 
						delegate:self];
	
	[_connection start];
	
}

- (id)init
{
    self = [super init];
    if (self) {
		_tokenXML = [NSMutableData alloc];
		_connection = [NSURLConnection alloc];
		_error = nil;
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
	[_xmlStringBuffer release];
	[_connection release];
	[_xmlParser release];
	[_error release];
	[_delegate release];
	
	[super dealloc];
}

#pragma mark -- NSURLConnectionDelegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	_error = [[NSError alloc] initWithDomain:@"APPivotalTracker" 
										code:APPT_ERROR_CONNECTION_AUTH_CHALLENGE 
									userInfo:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:challenge, nil] 
																		 forKeys:[NSArray arrayWithObjects:@"challenge", nil]]];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	_error = [error retain];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_tokenXML appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	// If there has been an error, do not parse XML
	if (_error != nil) {
		[_delegate token:self failedWithError:_error];
		return;
	}
	
	// Create an XML parser with the data retrieved from Pivotal
	_xmlParser = [[NSXMLParser alloc] initWithData:_tokenXML];
	[_xmlParser	setDelegate: self];
	[_xmlParser parse];
	
	if (_error != nil)
	{
		[_delegate token:self failedWithError:_error];
	}
	else
	{
		[_delegate token:self didReceiveToken:self.token withType:self.tokenType];
	}
	
	[_connection release];
	_connection = nil;
}

#pragma mark -- NSXMLParserDelegate Methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{	
	if ([elementName isEqualToString:@"guid"])
	{
		if (_xmlStringBuffer == nil)
		{
			_xmlStringBuffer = [[NSMutableString alloc] initWithCapacity:50];
		}
	}
	else if ([elementName isEqualToString:@"id"])
	{
		if (_xmlStringBuffer == nil)
		{
			_xmlStringBuffer = [[NSMutableString alloc] initWithCapacity:10];
		}
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if ([elementName isEqualToString:@"guid"])
	{
		_token = [[NSString alloc] initWithString: _xmlStringBuffer];
		// Release the XML buffer
		[_xmlStringBuffer release];
		_xmlStringBuffer = nil;
	}
	else if ([elementName isEqualToString:@"id"])
	{
		_tokenType = [_xmlStringBuffer integerValue];
		// Release the XML buffer
		[_xmlStringBuffer release];
		_xmlStringBuffer = nil;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	// Append the found characters to the string buffer
	[_xmlStringBuffer appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	_error = [parseError retain];
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
	_error = [validationError retain];
}

@end