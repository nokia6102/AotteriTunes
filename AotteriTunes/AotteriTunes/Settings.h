
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Settings : NSObject

+ (Settings *)sharedSettings;

@property(nonatomic, strong) UIColor *themeColor;
@property(nonatomic, strong) NSString *urlString;
@end

NS_ASSUME_NONNULL_END
