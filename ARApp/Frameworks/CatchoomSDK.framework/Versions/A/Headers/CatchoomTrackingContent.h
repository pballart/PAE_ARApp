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
#import "CatchoomTrackingResult.h"
#import "CatchoomSDKError.h"

///@file

///@cond
NSString *contentErrorDomain;
typedef enum CatchoomContentError : NSInteger CatchoomContentError;
enum CatchoomContentError : NSInteger {
    CATCHOOM_CONTENT_ERROR_UNKNOWN,
    CATCHOOM_CONTENT_ERROR_INVALID_TYPE,
    CATCHOOM_CONTENT_ERROR_CONTENT_DESCRIPTION,
};
///@endcond

/// Width in pixels of the reference when it is at a distance from the device where it fits the width of the screen
#define TW_REF_WIDTH 600.0

typedef enum CatchoomTrackingContentWrapMode : NSInteger CatchoomTrackingContentWrapMode;
/**
 Defines how a content is scaled relative to the reference.
 */
enum CatchoomTrackingContentWrapMode : NSInteger {
    /// The content will be drawn using its own dimensions.
    CATCHOOM_TRACKING_WRAP_NONE,
    /// The content will be drawn relative to the reference's width.
    CATCHOOM_TRACKING_WRAP_REF_WIDTH,
    /// The content will be scaled to fill the reference's dimensions (aspect ratio won't be kept, _scale will be ignored)
    CATCHOOM_TRACKING_WRAP_SCALE_FILL,
    /// The content will be scaled to fill cover the reference while keeping aspect ratio (_scale ignored)
    CATCHOOM_TRACKING_WRAP_ASPECT_FILL,
    /// The content will be scaled to fit the reference's edges while keeping aspect ratio (_scale ignored)
    CATCHOOM_TRACKING_WRAP_ASPECT_FIT,
    /// The content will be drawn relative to the reference's width, assuming the reference is always scaled to TW_REFW_WIDTH.
    CATCHOOM_TRACKING_WRAP_REF_WIDTH_FIXED,
};

typedef enum CatchoomTrackingContentDrawMode : NSInteger CatchoomTrackingContentDrawMode;
/**
 Defines how a content will be drawn.
 */
enum CatchoomTrackingContentDrawMode : NSInteger {
    /// The content will draw with default color
    DRAW_MODE_DEFAULT,
    /// The content should be drawn as a shape
    DRAW_MODE_SHAPE,
};

typedef enum CatchoomTrackingContetnStatus : NSInteger CatchoomTrackingContetnStatus;
/**
 Posible states of a content used by the renderer to decide if the content is ready to be drawn.
 */
enum CatchoomTrackingContetnStatus : NSInteger {
    /// Content is not ready to load
    CONTENT_NOT_READY = 0,
    /// content is ready to load
    CONTENT_READY,
    /// Content is loading
    CONTENT_LOADING,
    /// Content is loaded
    CONTENT_LOADED,
    /// Error while creating or loading content
    CONTENT_ERROR,
};


@protocol CatchoomTrackingContentLoadCallbacks;

/**
 * The CatchoomTrackingContent class is an abstract class with the
 * basic information for an AR content and methods to render the contents.
 * Basic implementations of contents are provided. This class or 
 * its subclasses can be extended to create new contents or modify their behaviour.
 <br><br>
 * Contents can be created manually or parsed from an item's scene description
 * from a CloudRecognitionItem object.
 */
@interface CatchoomTrackingContent : NSObject {
    ///@cond
    Boolean isTracking;
    NSString *contentId;
    NSString *hyperlinkUrl;
    CATransform3D translation;
    CATransform3D rotation;
    CATransform3D scale;
    CatchoomTrackingContentWrapMode wrapMode;
    float alpha;
    int _internalId;
    ///@endcond
}

/// Delegate for receiving content load callbacks (currently only works for 3D models)
@property (nonatomic, weak) id <CatchoomTrackingContentLoadCallbacks> delegate;

/// Tracks whether this content's reference is being tracked. If so, the content will be drawn
@property (nonatomic,readwrite) Boolean isTracking;
///@cond reference's id
@property (nonatomic,readonly) NSString *contentId;
///@endcond

/// Content's hyperlink url
@property (nonatomic,readonly) NSString *hyperlinkUrl;
/// Content's translation relative to reference's center
/**
 Translation dimensions are relative to reference's width. <br>
 1 unit translation in 'x' means the reference will be moved 1 referece's
 width times to the right of the center of the reference.<br>
 1 unit translation in 'y' means the reference will be moved 1 referece's
 width times to the top of the reference. <br>
 1 unit translation in 'z' means the reference will be moved 1 referece's
 width times to the over the reference. <br>
 @note translation is identity by default (no translation)
 */
@property (nonatomic,readwrite) CATransform3D translation;
/// Content's rotation relative to reference's center
/**
 X axis goes from the center of the reference image to its right <br>
 Y axis goes from the center of the reference image to its top <br>
 Z axis goes up from the center of the reference image <br>
 @note rotation is identity by default (no rotation)
 */
@property (nonatomic,readwrite) CATransform3D rotation;
/// Content's scale relative to reference's width
/**
 When scale is 1 in all axis, the content's width will match
 the reference's widht. Aspect ratio will be kept.
 @note scale is 1 by default
 */
@property (nonatomic,readwrite) CATransform3D scale;
/// Defines how flat contents are drawn over the reference
/**
 There are 4 wrap modes: <ul>
 <li>NONE: The content will be drawn using _scale dimensions.</li>
 <li>SCALE_FILL: The content will be scaled to fill the reference's dimensions (aspect ratio won't be kept, _scale will be ignored)</li>
 <li>ASPECT_FILL: The content will be scaled to fill cover the reference while keeping aspect ratio (_scale ignored)</li>
 <li>ASPECT_FIT: The content will be scaled to fit the reference's edges while keeping aspect ratio (_scale ignored)</li>
 </ul>
 */
@property (nonatomic,readwrite) CatchoomTrackingContentWrapMode wrapMode;
/// Draw the content with _alpha transparency
@property (nonatomic,readwrite) float alpha;
///@cond internal content id
@property (nonatomic,readonly) int _internalId;
///@endcond

@property (nonatomic, readonly) int contentVersion;



#pragma mark provided methods

// Initialize this content object with an scene item description (from the scene JSON).
/**
 Initializes the content object with a scene description item
 @param sceneDescription Description of a specific content from the Catchoom content JSON spec.
 @param error Error if the Content could not be created.
 */
- (id) initWithSceneDescriptionItem: (NSDictionary*) sceneDescription andContentVersion: (int)version withError: (NSError **) error;


///@cond
+ (CatchoomTrackingContent *) contentFromSceneDescriptionItem: (NSDictionary *) sceneItem withError: (NSError**) error DEPRECATED_ATTRIBUTE;
///@endcond

#pragma mark -


#pragma mark methods to overload for content events and behaviour

/**
 Get the content's status
 */
- (CatchoomTrackingContetnStatus) getStatus;

/**
 Called by the SDK when the reference for this content starts being tracked.
 @note When extending a content, call super if you override this method.
 */
- (void) trackingStarted;

/**
 Called by the SDK when the tracking is lost for this reference's content.
 @note When extending a content, call super if you override this method.
 */
- (void) trackingLost;

/**
 Called by the SDK when the user touches down the drawn content
 @note When extending a content, call super if you override this method.
 */
- (void) contentTouchDown;

/**
 Called by the SDK when the user touches down the drawn content
 @note When extending a content, call super if you override this method.
 */
- (void) contentTouchUp;

/**
 Called by the SDK when the user moves in the drawn content
 @note When extending a content, call super if you override this method.
 */
- (void) contentTouchIn;

/**
 Called by the SDK when the user moves out the drawn content
 @note When extending a content, call super if you override this method.
 */
- (void) contentTouchOut;
#pragma mark -


#pragma mark methods to overload to draw contents

/**
 Wil render the content with the information from  a tracking result.
 @param result Result that contains the matched reference pose in the video frame.
 */
- (void) drawWithResult: (CatchoomTrackingResult *) result;

// Content loading. Called by the SDK before rendering the content.
/**
 Content load. Called by the SDK before rendering the content.
 @param referenceSize Dimensions of the reference used to define the content scale.
 @param internalID Internal identifier for the content. Used by the renderer.
 */
- (void) loadWithReferenceSize: (CGSize) referenceSize andInternalId: (int) internalID;

/**
 Sets the draw mode.
 @param mode Draw mode the content will be drawn with.
 */
- (void) setDrawMode: (CatchoomTrackingContentDrawMode) mode;

#pragma mark -


@end

/**
 Protocol to receive feedback about the content load.
 Currently only works for contents of the type CatchoomTrackingContent3dModel
 */
@protocol CatchoomTrackingContentLoadCallbacks <NSObject>
@optional

/**
 Content download made progress
 @param content Content that  is downloading
 @param downloadPercent Percent of download finished
 */
- (void) didProgress: (float) downloadPercent onContentDownload: (CatchoomTrackingContent*) content;


/**
 Content download finished, the content from the network
 @param content Content that finished its download
 */
- (void) didFinishDownloadingContent: (CatchoomTrackingContent*) content;

/**
 Content load finished, the content will render as soon as the reference holding it gets detected
 @param content Content that finished its load
 */
- (void) didFinishLoadingContent: (CatchoomTrackingContent*) content;

/**
 Content load failed.
 @param content Content that failed loading
 @param error CatchoomSDK error cotaining a code and description with the error produced while loading the content.
 */
- (void) didFailLoadingContent: (CatchoomTrackingContent*) content withError: (CatchoomSDKError *) error;
@end
