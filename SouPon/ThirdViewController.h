//
//  ThirdViewController.h
//  SouPon
//
//  Created by Edward on 13-3-21.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ThirdViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    double lon;
    double lat;
}

@end
