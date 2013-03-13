#import "AKApplicationViewController.h"

#import <FacebookSDK/FacebookSDK.h>

#import "AKAuthenticatedViewController.h"
#import "AKLoginViewController.h"

@interface AKApplicationViewController ()
@property(nonatomic, strong) AKAuthenticatedViewController *authenticatedViewController;
@property(nonatomic, strong) AKLoginViewController *loginViewController;
@end

@implementation AKApplicationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      // Custom initialization
  }
  return self;
}

- (void)loadView {
  self.view = [[UIView alloc] init];
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initializeChildViewControllers];
	[self loadScreenIdentifier];
  [self loadRootChildViewController];
}

- (void)initializeChildViewControllers {
  self.authenticatedViewController = [[AKAuthenticatedViewController alloc] init];
  self.loginViewController = [[AKLoginViewController alloc] init];
}

- (void)loadScreenIdentifier {
  UILabel *screenIdentifier =
      [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 200.0f, 30.0f)];
  screenIdentifier.text = @"APPLICATION";
  screenIdentifier.backgroundColor = [UIColor clearColor];
  [self.view addSubview:screenIdentifier];
}

- (void)loadRootChildViewController {
  if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
    [self loadAuthenticatedView];
  } else {
    [self loadLoginView];
  }
}

- (void)loadLoginView {
  [self addChildViewController:self.loginViewController];
  [self.view addSubview:self.loginViewController.view];
}

- (void)unloadLoginView {
  [self.loginViewController.view removeFromSuperview];
  [self.loginViewController removeFromParentViewController];
}

- (void)loadAuthenticatedView {
  [self addChildViewController:self.authenticatedViewController];
  [self.view addSubview:self.authenticatedViewController.view];
}

- (void)unloadAuthenticatedView {
  [self.authenticatedViewController.view removeFromSuperview];
  [self.authenticatedViewController removeFromParentViewController];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  self.loginViewController.view.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end