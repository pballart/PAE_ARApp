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

NSString *catchoomSDKErrorDomain;
typedef enum CatchoomSDKErrorCode : NSInteger CatchoomSDKErrorCode;
/**
 Error code identifiyng the problem
 */
enum CatchoomSDKErrorCode : NSInteger {
    CATCHOOM_SEARCH_UNKNOWN_ERROR,
    CATCHOOM_CLOUD_SERVER_ERROR,
    // Token errors
    CATCHOOM_TOKEN_MISSING,
    CATCHOOM_WRONG_TOKEN_FORMAT,
    CATCHOOM_INVALID_TOKEN,
    // Image errors
    CATCHOOM_IMAGE_MISSING,
    CATCHOOM_IMAGE_TOO_LARGE,
    CATCHOOM_IMAGE_DIMENSIONS_TOO_SMALL,
    CATCHOOM_IMAGE_HAS_TRANSPARENCY,
    CATCHOOM_IMAGE_NO_DETAILS,
    CATCHOOM_IMAGE_NOT_LOADED,
    // AR errors
    CATCHOOM_AR_REFERENCE_ERROR_UNKNOWN,
    CATCHOOM_AR_REFERENCE_ERROR_INTERNAL,
    CATCHOOM_AR_REFERENCE_ERROR_INVALID_DATA,
    CATCHOOM_AR_REFERENCE_ERROR_LIMIT_EXCEEDED,
    CATCHOOM_AR_REFERENCE_ERROR_WRONG_LICENSE,
    // Content erorrs
    CATCHOOM_CONTENT_ERROR_DOWNLOAD_MODEL,
};

/**
 A CatchoomSDK Error is an NSError with error codes of the type CatchoomSDKErrorCode and a message
 describing the problem.
 @see CatchoomSDKError.h for error codes.
 */
@interface CatchoomSDKError : NSError

///@cond
+ (CatchoomSDKError *) errorWithCodeString: (NSString *) errorCodeString andMessage: (NSString *) message;
+ (CatchoomSDKError *) errorWithCode: (CatchoomSDKErrorCode) errorCode andMessage: (NSString *) message;
///@endcond
@end
