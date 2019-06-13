
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebViewController2 : UIViewController
@property (nonatomic, retain) IBOutlet WKWebView *webView;
@property (strong, nonatomic) NSString *productURL;
@end

NS_ASSUME_NONNULL_END
