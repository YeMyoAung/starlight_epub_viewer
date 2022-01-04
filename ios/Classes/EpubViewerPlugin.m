#import "EpubViewerPlugin.h"
#import <starlight_epub_viewer/starlight_epub_viewer-Swift.h>

@implementation EpubViewerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEpubViewerPlugin registerWithRegistrar:registrar];
}
@end
