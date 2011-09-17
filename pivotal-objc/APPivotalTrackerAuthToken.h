//
//  APPivotalTrackerAuthToken.h
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

#define APPT_ERROR_CONNECTION_AUTH_CHALLENGE 10000

#import <Foundation/Foundation.h>
#import "NSString+URLEncoded.h"

@interface APPivotalTrackerAuthToken : NSObject <NSXMLParserDelegate> {
	NSMutableData *_tokenXML;
	NSURLConnection *_connection;
	NSXMLParser *_xmlParser;
	NSString *_token;
	NSString *_username;
	NSString *_password;
	NSInteger _tokenType;
	NSMutableString *_xmlStringBuffer;
	NSError *_error;
}

#pragma mark -- Properties

@property (nonatomic, readonly) NSString *token;
@property (nonatomic, readonly) NSInteger tokenType;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, readonly) NSError *error;

#pragma mark -- Methods
- (id)initWithUsername:(NSString *) username password:(NSString *) password;
- (NSURL *)getPivotalURLUsingEncodedAuth;
- (void)getPivotalToken:(NSURL *)url;

#pragma mark -- NSURLConnectionDelegateMethods

/*!
 @method connection:didReceiveAuthenticationChallenge:
 @abstract Start authentication for a given challenge
 @discussion Call useCredential:forAuthenticationChallenge:,
 continueWithoutCredentialForAuthenticationChallenge: or cancelAuthenticationChallenge: on
 the challenge sender when done.
 @param connection the connection for which authentication is needed
 @param challenge The NSURLAuthenticationChallenge to start authentication for
 */
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;

/*! 
 @method connection:didFailWithError:   
 @abstract This method is called when an NSURLConnection has
 failed to load successfully.
 @discussion See the category description for information regarding
 the contract associated with the delivery of this delegate
 callback.
 @param connection an NSURLConnection that has failed to load.
 @param error The error that encapsulates information about what
 caused the load to fail.
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

/*! 
 @method connection:didReceiveData:   
 @abstract This method is called to deliver the content of a URL
 load.
 @discussion Load data is delivered incrementally. Clients can
 concatenate each successive NSData object delivered through this
 method over the course of an asynchronous load to build up the
 complete data for a URL load. It is also important to note that this
 method provides the only way for an ansynchronous delegate to find
 out about load data. In other words, it is the responsibility of the
 delegate to retain or copy this data as it is delivered through this
 method.
 <p>See the category description for information regarding
 the contract associated with the delivery of this delegate 
 callback.
 @param connection  NSURLConnection that has received data.
 @param data A chunk of URL load data.
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

/*! 
 @method connectionDidFinishLoading:   
 @abstract This method is called when an NSURLConnection has
 finished loading successfully.
 @discussion See the category description for information regarding
 the contract associated with the delivery of this delegate
 callback.
 @param connection an NSURLConnection that has finished loading
 successfully.
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

/*! 
 @method connection:didFailWithError:   
 @abstract This method is called when an NSURLConnection has
 failed to load successfully.
 @discussion See the category description for information regarding
 the contract associated with the delivery of this delegate
 callback.
 @param connection an NSURLConnection that has failed to load.
 @param error The error that encapsulates information about what
 caused the load to fail.
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

#pragma mark -- NSXMLParserDelegate Methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

@end
