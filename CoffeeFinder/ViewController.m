//
//  ViewController.m
//  CoffeeFinder
//
//  Created by Andrew Bihl on 5/10/16.
//  Copyright © 2016 Andrew Bihl. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CoffeeShop.h"

@interface ViewController () <CLLocationManagerDelegate>
@property CLLocationManager* locationManager;
@property CLLocation* userLocation;
@property NSArray* coffeeShops;
@property (weak, nonatomic) IBOutlet UITableView *listOfShops;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self; 
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.userLocation = locations.firstObject;
    [self.locationManager stopUpdatingLocation];
    NSLog(@"%@",self.userLocation);
    [self findCoffeeNear:self.userLocation];
}
-(void)findCoffeeNear:(CLLocation*)currentLocation{
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    request.naturalLanguageQuery = @"coffee";
    MKCoordinateSpan span = MKCoordinateSpanMake(0.5, 0.5);
    request.region = MKCoordinateRegionMake(currentLocation.coordinate, span);
    MKLocalSearch* currentSearch = [[MKLocalSearch alloc]initWithRequest:request];
    [currentSearch startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        
        NSMutableArray* tempArray = [NSMutableArray new];
        NSArray* mapItems = response.mapItems;
                
        for (int i = 0; i <5; i++){
            MKMapItem *mapItem = [mapItems objectAtIndex:i];
            CLLocationDistance distance = [mapItem.placemark.location distanceFromLocation:self.userLocation];
            float milesDistance = distance / 1609.34;
            CoffeeShop *shop = [CoffeeShop new];
            shop.mapItem = mapItem;
            shop.name = mapItem.name;
            shop.distance = milesDistance;
            [tempArray addObject:shop];
        }
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:true];
        NSArray* sortedArray = [tempArray sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
        self.coffeeShops = [NSArray arrayWithArray:sortedArray];
        for (CoffeeShop* current in self.coffeeShops){
            NSLog(@"%@",current.name);
            [UITableViewCell in
        }
    }];
    
}

@end
