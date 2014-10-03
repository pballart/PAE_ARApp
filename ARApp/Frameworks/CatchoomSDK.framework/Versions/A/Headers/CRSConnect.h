// This file is free software. You may use it under the MIT license, which is copied
// below and available at http://opensource.org/licenses/MIT
//
// Copyright (c) 2014 Catchoom Technologies S.L.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
// Software, and to permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

#import <Foundation/Foundation.h>

@protocol CatchoomSearchProtocol;

/**
 * The CRSConnect class is used by the SDK to connect to
 * the CRS. It just manages the network connection and requests and forwards the
 * responses to the SDK to be processed. This class behaviour may be overriden in 
 * order to place a proxy between the CRS API and the SDK.
 */
@interface CRSConnect : NSObject

/// delegate  to handle search response @note CatchoomCloudRecognition, set internally
@property (nonatomic, weak) id <CatchoomSearchProtocol> delegate;

/// Returns the singleton instance of this class. @note used internally
+ (CRSConnect *)sharedCatchoom;

/// Used internally to obtain the url of the server for cloud recognition. @note override to connect to a different server (use a proxy server)
+ (NSString*) getCloudRecognitionUrl;

/**
 Creates a connection with the server using the set token. With this call, you are authenticating the
 application against catchoom service and connecting the app to a specific collection. Sends message with the
 result to the delegate (CatchoomSearchProtocol::didReceiveConnectResponse:,CatchoomSearchProtocol::didFailLoadWithError:).
 @param collectionToken Catchoom collection token.
 @see CatchoomSearchProtocol
 @see http://catchoom.com/documentation/token
 @note used to validate the collection token
 @note If you override this method, take into account how the catchooom CRS API works: http://catchoom.com/documentation/api/recognition/ (timestamp).
 */
- (void)connectForCollection: (NSString*) collectionToken;

/**
 Performs a search call for an image data. Sends message with the
 result to the delegate (CatchoomSearchProtocol::didReceiveSearchResponse:,CatchoomSearchProtocol::didFailLoadWithError:).
 @param params dictionary containing options for the CRS: <ul>
    <li> bbox: NSString (true/false) (return bounding boxes, "false" by default) </li>
    <li>  embed_custom_data: NSString (true/false) (embed custom data in resposnse, "false" by default) </li>
 </ul>
 @see CatchoomSearchProtocol
 @note If you override this method, take into account how the catchooom CRS API works: http://catchoom.com/documentation/api/recognition/
 */
- (void)searchWithData:(NSData *)imageNSData andParams: (NSDictionary*) params forCollection: (NSString*) collectionToken;

@end

/**
 The CatchoomSearchProtocol is implemented by the CatchoomCloudRecognition class to receive
 the results from the CRSConnect class.
 */
@protocol CatchoomSearchProtocol <NSObject>

@optional

/**
 Connect callback.
 @param response JSON object with a valid CRS timestamp response
 @param statusCode final HTTP status code of the request
 */
- (void)didReceiveConnectResponse:(id)response withCode: (int) statusCode;

/**
 Search callback
 @param response JSON object with a valid CRS search response.
 @param statusCode final HTTP status code of the request
 @see http://catchoom.com/documentation/api/recognition/
 */
- (void)didReceiveServerSearchResponse:(id)response withCode: (int) statusCode;

/**
 Error callbacj
 @param error NSError with description of the error in the search connect query
 @see http://catchoom.com/documentation/api/recognition/
 */
- (void)didFailLoadWithError:(NSError *)error;

@end
