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
#import "CatchoomCloudRecognition.h"

#if TARGET_IPHONE_SIMULATOR && !CATCHOOM_SDK_FWK
#error We are sorry but the CatchoomSDK does not provide support for the simulator. Compile your project for an iOS device.
#endif

@protocol CatchoomSDKProtocol;

/**
  The CatchoomSDK class is the main interface to interact with the 
 SDK from your app. It allows to perform the basic operations on the
 video preview and interact with the CloudRecognition interface.
 There is a singleton instance of the SDK that is initialized the first time 
 it is accessed.
 */
@interface CatchoomSDK : NSObject

/// Delegate that will receive SDK's callbacks
@property (nonatomic, weak) id <CatchoomSDKProtocol> delegate;

/**
 Get the singleton instance of the SDK
 */
+ (CatchoomSDK *)sharedCatchoomSDK;

/**
  Get the singleton instance of the SDK with a non-default CRSConnect Class
  to allow proxies. If used, has to be called once and for the first time the
  SDK is used in the application.
  @param CRSConnect Class implementing network communication with the CRS.
 @note CRSConnectClass must be the class id for a CRSConnect subclass.
 */
+ (CatchoomSDK *)sharedCatchoomSDKWithCRSConnect: (id) CRSConnectClass;

/**
 Initialize a camera capture for a given UIView.
 @param previewView View where the camera preview will be shown. The SDK will draw the capture preview and 
 the augmented scene in this view. Any other contents added to this view will be ignored.
*/
- (void) startCaptureWithView: (UIView*) previewView;

/**
 Stops the camera capture. Call this method when the viewController that contains the previewView receives
 the viewWillDisappear message.<br><br>
 
 This method will stop the cloud recognition related processes but it will keep their
 configuration (tokens, references, contents, etc)
 */
- (void) stopCapture;

/**
 Freezes the video capture and the preview.
 */
- (void) freezeCapture;

/**
 Unfreezes the video capture and the preview.
 */
- (void) unfreezeCapture;

/**
 Take a snapshot from the camera capture. When the snap shot has been taken
 the CatchoomSDKProtocol::didGetSnapshot: message will be sent to the delegate. @see CatchoomSDKProtocol
 */
- (void) takeSnapshot;

/**
 Get a CatchoomCloudRecognition object.
 This method will return an interface to Catchoom Cloud Recognition
 that can be used at any time to send image recognition queries.
 */
- (CatchoomCloudRecognition *) getCloudRecognitionInterface;

@end


@protocol CatchoomSDKProtocol <NSObject>

/**
 Sent by the SDK after the video capture and preview have started. Before this is called for
 the first time, it is not safe to start any process using the video capture (Cloud recognition or Tracking).
 */
- (void) didStartCapture;

@optional
/**
 Sent by the SDK after the CatchoomSDK::takeSnapshot: method is called.
 @param snapshot UIImage with taken from the camera capture.
 */
- (void) didGetSnapshot: (UIImage*) snapshot;

@end

