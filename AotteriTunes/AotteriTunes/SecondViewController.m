
#import "SecondViewController.h"
#import "Settings.h"

@interface SecondViewController ()

@end

@implementation SecondViewController


-(void)showThemeSet
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *themeSet = [defaults stringForKey:@"themeset"];
    if (themeSet)
    {
        if ([themeSet isEqual: @"dark"]) {
            _lblThemeColor.text = @"深色主題";
            [[Settings sharedSettings] setThemeColor:UIColor.brownColor];
        }else{
            _lblThemeColor.text = @"淺色主題";
            [[Settings sharedSettings] setThemeColor:UIColor.greenColor];
        }
    }else
    {
        [defaults setObject:@"dark" forKey:@"themeset"];
        [defaults synchronize];
        _lblThemeColor.text = @"淺色主題";
    }
    [self.view setBackgroundColor:[Settings sharedSettings].themeColor];
}

-(void)showFavorteNumber
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favoritesLoaded = [defaults objectForKey:@"favorites"];
    if (favoritesLoaded)
        _lblCollectionNumber.text = [NSString stringWithFormat:@"%ld" , favoritesLoaded.count];
}


-(void)viewDidAppear:(BOOL)animated
{
    [self showThemeSet];
    [self showFavorteNumber];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self showThemeSet];
    [self showFavorteNumber];
}


@end
