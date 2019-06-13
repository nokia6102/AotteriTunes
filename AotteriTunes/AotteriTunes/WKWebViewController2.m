

#import "WKWebViewController2.h"
#import "Settings.h"

@interface WKWebViewController2 ()

@end

@implementation WKWebViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *goURL= [[Settings sharedSettings] urlString];
    NSLog(@"g:%@",goURL);
//    self.productURL = @"https://support.apple.com/itunes";
    self.productURL = goURL;
    NSURL *url = [NSURL URLWithString:self.productURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
//     _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [_webView loadRequest:request];
//    _webView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
//    [self.view addSubview:_webView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
