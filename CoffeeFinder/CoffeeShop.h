//
//  CoffeeShop.h
//  CoffeeFinder
//
//  Created by Andrew Bihl on 5/11/16.
//  Copyright © 2016 Andrew Bihl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface CoffeeShop : NSObject

@property MKMapItem* mapItem;
@property float distance;
@property NSString* name;

@end
