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

/**
 Corner coordinates of the Item's bounding box
 @see http://catchoom.com/documentation/api/bounding-boxes/
 */
typedef struct bbox {
    CGSize topRight;
    CGSize topLeft;
    CGSize bottomLeft;
    CGSize bottomRight;
} BoundingBox;

typedef enum CatchoomItemType : NSInteger CatchoomItemType;
/**
 Determines the Type of a CloudRecognitionItem (Recognition or Augmented Reality).
 */
enum CatchoomItemType : NSInteger {
    ///
    ITEM_TYPE_RECOGNITION,
    ///
    ITEM_TYPE_AR,
    ///
    ITEM_TYPE_UNDEFINED,
};

/**
 Class encapsulating the properties of a CRS item.
 A CatchoomoCloudRecognitionItem is obtained as a result of a search performed
 through the CatchoomCloudRecognition class.
 @see http://catchoom.com/documentation/item
 @note This class may be extended to set custom fields
 */
@interface CatchoomCloudRecognitionItem : NSObject

@property (nonatomic, readonly, getter = getType) CatchoomItemType _type;

/// Unique UUID of the item
@property (nonatomic) NSString *itemId;
/// Item name
@property (nonatomic) NSString *itemName;
/// Unique UUID of the detected image for the item
@property (nonatomic) NSString *imageId;
/// Score obtained by the image @see http://catchoom.com/documentation/api/recognition-scores/
@property (nonatomic) NSNumber *score;
/// URL of the 120px thumbnail of the image
@property (nonatomic) NSString *thumbnail120;

/// Contents of the url field of the item (nil if not set)
@property (nonatomic) NSString *url;

/// Contents of the custom field (nil if not set)
/**
 If the embedCustom property of the CatchoomCloudRecognition interface is set, 
 it will contain an NSStirng with the raw contents in the custom data field of the item from the CRS. <br>
 Otherwilse, if the embedCustom property is false, it will contain the url of the custom field (if set).
 */
@property (nonatomic) NSString *custom;

/// List of JSON objects with the AR experience or gallery contents for the item.
/**
 @note The Catchoom content creation interface, creates the contents for an AR 
 experience or item contents. It encodes this contents using a JSON format 
 specification for the Catchoom SDK to understand it.
 @see http://catchoom.com/documentation/api/custom-data
 */
@property (nonatomic) NSArray  *contents;

/// Version of the contents JSON format
/**
 The CraftAR service defines a JSON structure for specifying the contents and how
 the AR scene description is serialized. The version is used to know how the scene was created
 by the Content Creator and how it has to be rendered by the SDK.
 */
@property (nonatomic, readonly) int contentsVersion;

/// Bounding box of the found item inside the request image sent to CRS
@property (nonatomic) BoundingBox bbox;

/**
 Initializes a CatchoomCLoudRecognitionItem.
 @param obj JSON object containing an item from a CRS search response.
 @note Do not call this method directly. Use itemFromJSON insead.
 */
- (id) initWithJSONObject: (id) obj;

/**
 Determine the item type from tje JSON object obtained from the CRS
 @param json JSON object containing an item from a CRS search response.
 */
+ (CatchoomItemType) itemTypeFromJSON: (id) json;

/**
 Create an item from a JSON object
 @param json JSON object containing an item from a CRS search response.
 @note Use this function to create IR only or AR items from JSON objects obtained
 through the CRS.
 */
+ (CatchoomCloudRecognitionItem*) itemFromJSON: (id) json;

@end
