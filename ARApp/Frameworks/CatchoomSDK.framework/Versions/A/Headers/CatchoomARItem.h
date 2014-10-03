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


#import <CatchoomSDK/CatchoomTrackingResult.h>
#import <CatchoomSDK/CatchoomCloudRecognitionItem.h>
#import <CatchoomSDK/CatchoomTrackingContentVideo.h>
#import <CatchoomSDK/CatchoomTrackingContentImage.h>
#import <CatchoomSDK/CatchoomTrackingContentImageButton.h>
#import <CatchoomSDK/CatchoomTrackingContent3dModel.h>

extern NSString* CatchoomTrackingARItemObservationContext;

/**
 * A CatchoomARItem is intended to display an augmented reality scene
 * on top of the reference image.
 */
@interface CatchoomARItem : CatchoomCloudRecognitionItem {
    ///@cond
    NSData *referenceData;
    int referenceId;
    CatchoomTrackingResult *result;
    Boolean isTracked;
}

@property (nonatomic, readonly) NSData *referenceData;
@property (nonatomic, readwrite) int referenceId;
@property (nonatomic, readwrite) CatchoomTrackingResult *result;
@property (nonatomic, readwrite) Boolean isTracked;
///@endcond


/**
 Initialize an empty AR item with tracking data to be able to create a local AR experience
 @param resource name for the resource file containing the tracking data
 @param type extension for the resource file
 */
- (id) initFromResource:(NSString *)resource ofType:(NSString *)type;

/**
 Add content to the AR item
 @param content an instance of CatchoomTrackingContent to be displayed on top ot the item's image
 */
-(void) addContent: (CatchoomTrackingContent *) content;

/**
 Remove a content from the AR item
 @param content a content that has been previously added to the AR item.
 */
-(void) removeContent: (CatchoomTrackingContent *) content;

/**
 Remove all contents for this AR item
 */
-(NSArray*) allContents;

/**
 * Set your custom content class for a content of a specified type
 * @param contentClass Must be a subclass of CatchoomTrackingContent or any of its subclasses.
 * Instantiate the class as follows: ["My"CatchoomTrackingContentImage class].
 * @param type Key for the content type (i.e. "image_button")
 */
+ (void) setContentClass: (id) contentClass forType: (NSString *) type;

@end
