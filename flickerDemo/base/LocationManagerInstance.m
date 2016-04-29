

#import "LocationManagerInstance.h"


@implementation LocationManagerInstance



-(void) getLocationUpdate
{
    
    self.locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    self.locationManager.delegate = self; // we set the delegate of locationManager to self.
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // setting the accuracy
    [self.locationManager startUpdatingLocation];  //requesting location updates
}

+ (id)sharedManager {
    static LocationManagerInstance *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    
    
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        if(NSClassFromString(@"UIPopoverController")) {
            [self.locationManager requestWhenInUseAuthorization];
        }
     
        

        self.latitude = @"";
        self.longitude = @"";
        
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
 
    self.latitude = @"";
    self.longitude = @"";

}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusDenied) {

        [[[UIAlertView alloc] initWithTitle:@"No LOcation Access"
                                    message:@"Looks like location access is not provided for the app, please change in settings."
                                   delegate:nil
                          cancelButtonTitle:@"Dismiss"
                          otherButtonTitles:nil] show];

        
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *crnLoc = [locations lastObject];
    self.latitude = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setValue:@"yes" forKey:@"hasGotLocation"];
    
   

    
}



@end
