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
#import "CatchoomARItem.h"
#import "CatchoomTrackingReference.h"
#import "CatchoomSDKError.h"


/*
 * The CatchoomTracking class allows to manage the tracking for the
 * augmented reality experience in the attached video capture.
 * It offers an interface for managing references and their contents and
 * the execution of the process to track the references and produce the
 * information necessary to render the augmented scene.
 */
@interface CatchoomTracking : NSObject

#pragma mark start/stop tracking

// Starts the tracking process, renders contents for
// the references that get tracked
/**
 Starts the Augmented reality experience rendering contents on top of the
 reference images that are detected.
 */
- (void) startTracking;


/**
 Stop the tracking.
 */
- (void) stopTracking;

#pragma mark -

#pragma mark Reference management (Deprecated)

///@cond
- (CatchoomSDKError *) addReference: (CatchoomTrackingReference*) reference DEPRECATED_ATTRIBUTE;

- (void) removeReferenceWithId: (CatchoomTrackingReference*) reference DEPRECATED_ATTRIBUTE;

- (void) removeAllReferencesAndContents DEPRECATED_ATTRIBUTE;

- (void) addContent: (CatchoomTrackingContent*) content forReference: (CatchoomTrackingReference*) reference DEPRECATED_ATTRIBUTE;

- (void) removeContent: (CatchoomTrackingContent*) content fromReference: (CatchoomTrackingReference*) reference DEPRECATED_ATTRIBUTE;
///@endcond

#pragma mark -


#pragma mark AR Item management

/**
 Add a Catchoom AR item to initiate a tracking augmented reality experience
 @param item to be added for tracking.
 @return CatchoomSDKError NSError indicating if there has been any problem adding the item, nil if there are no errors.
 @see CatchoomARItem
 */
- (CatchoomSDKError *) addARItem: (CatchoomARItem*) item;

/**
 Remove an AR item from the augmented reality experience.
 @param item The item to be removed from the tracking module.
 @see CatchoomARItem
 */
- (void) removeARItem: (CatchoomARItem*) item;

/**
 Removes all items
 */
- (void) removeAllARItems;

#pragma mark -

@end
