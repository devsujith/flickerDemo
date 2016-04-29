//Location manager class to get user current location if access is provided.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>


@interface LocationManagerInstance : NSObject<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSString  *latitude;
@property (nonatomic,strong) NSString  *longitude;
+ (id)sharedManager;
@end
