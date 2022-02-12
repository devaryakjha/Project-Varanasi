#import "JiosaavnWrapperPlugin.h"
#if __has_include(<jiosaavn_wrapper/jiosaavn_wrapper-Swift.h>)
#import <jiosaavn_wrapper/jiosaavn_wrapper-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "jiosaavn_wrapper-Swift.h"
#endif

@implementation JiosaavnWrapperPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJiosaavnWrapperPlugin registerWithRegistrar:registrar];
}
@end
