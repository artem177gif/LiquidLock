#import <UIKit/UIKit.h>

@interface CSCoverSheetViewController : UIViewController
@end

@interface SBFLockScreenDateView : UIView
@end

static UILabel *glassClock;

static void UpdateClock() {
    if (!glassClock) return;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";

    glassClock.text = [formatter stringFromDate:[NSDate date]];
}

%hook SBFLockScreenDateView

-(void)didMoveToWindow {
    %orig;
    self.hidden = YES;
}

%end

%hook CSCoverSheetViewController

-(void)viewDidAppear:(BOOL)animated {
    %orig;

    if (glassClock) return;

    UIView *view = self.view;

    UIVisualEffect *blur =
    [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];

    UIVisualEffectView *glass =
    [[UIVisualEffectView alloc] initWithEffect:blur];

    glass.frame = CGRectMake(
        20,
        90,
        view.bounds.size.width - 40,
        160
    );

    glass.layer.cornerRadius = 30;
    glass.clipsToBounds = YES;

    [view addSubview:glass];

    glassClock =
    [[UILabel alloc] initWithFrame:glass.bounds];

    glassClock.textAlignment = NSTextAlignmentCenter;
    glassClock.font =
    [UIFont systemFontOfSize:80 weight:UIFontWeightBold];

    glassClock.textColor =
    [[UIColor whiteColor] colorWithAlphaComponent:0.9];

    [glass.contentView addSubview:glassClock];

    UpdateClock();

    [NSTimer scheduledTimerWithTimeInterval:60
                                     repeats:YES
                                       block:^(NSTimer *timer) {
        UpdateClock();
    }];
}

%end
