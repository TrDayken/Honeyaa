#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@import Firebase; // new

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//configure firebase
[FIRApp configure]; // new

[GeneratedPluginRegistrant registerWithRegistry:self];
// Override point for customization after application launch.
return [super application:application didFinishLaunchingWithOptions:launchOptions];

  }

@end
