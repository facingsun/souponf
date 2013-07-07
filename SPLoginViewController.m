//
//  SPLoginViewController.m
//  SouPon
//
//  Created by Edward on 13-3-17.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "SPLoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SPStatic.h"

@interface SPLoginViewController (){
	CGRect f1;
	CGRect f2;
}
@end

@implementation SPLoginViewController
@synthesize phoneTextField;
@synthesize pawTextField;
@synthesize registerButton;
@synthesize loginButton;
@synthesize toRe;
@synthesize backButton;
@synthesize reView;
@synthesize fView;
@synthesize phoneTextField2;
@synthesize pawTextField2;
@synthesize checkpsdTextField;//,waitHub;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [reView setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [fView release];
    [phoneTextField release];
    [pawTextField release];
    [loginButton release];
    [reView release];
    [registerButton release];
    [phoneTextField2 release];
    [pawTextField2 release];
    [checkpsdTextField release];
    [backButton release];
    [toRe release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setFView:nil];
    [self setPhoneTextField:nil];
    [self setPawTextField:nil];
    [self setLoginButton:nil];
    [self setReView:nil];
    [self setRegisterButton:nil];
    [self setPhoneTextField2:nil];
    [self setPawTextField2:nil];
    [self setCheckpsdTextField:nil];
    [self setBackButton:nil];
    [self setToRe:nil];
    [super viewDidUnload];
}
- (IBAction)logiin:(id)sender {
    if (phoneTextField.text.length !=11) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入错误" message:@"手机号位数不等于11位，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		[alert show];
		[alert release];
		return;
	}
	if (pawTextField.text.length <6) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入错误" message:@"密码位数不能低于6位" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		[alert show];
		[alert release];
		return;
	}
	
	NSString *loginString = [NSString stringWithFormat:CHECKUSER,@"login",phoneTextField.text,pawTextField.text];
	
	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:loginString] usedEncoding:&encode error:nil];
	
	NSArray *aa  = [hotstring componentsSeparatedByString:@">"];
	
	NSString *s = [NSString stringWithFormat:@"%@%@",[aa objectAtIndex:0],@" />"];
	NSLog(@"sss%@",s);
	NSData* data = [s dataUsingEncoding:NSUTF8StringEncoding];
	[self setAll:data];
    
	if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"result"]isEqual:@"SUCCESS"]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"恭喜您" message:@"登陆成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		[alert show];
		[alert release];
		[[NSUserDefaults standardUserDefaults]setValue:phoneTextField.text forKey:@"phone"];
		[[NSUserDefaults standardUserDefaults]setValue:pawTextField.text forKey:@"psd"];
		[self bttnCancel:nil];
		return;
	}
	//[waitHub setHidden:NO];
	NSString *string = (NSString*)[[NSUserDefaults standardUserDefaults]objectForKey:@"result"];
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
	[alert show];
	[alert release];
	return;
	

}

- (IBAction)toR:(id)sender {
    [self ContextAnimation];
	[phoneTextField resignFirstResponder];
	[pawTextField resignFirstResponder];
}
- (IBAction)regist:(id)sender {
    if (phoneTextField2.text.length !=11) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入错误" message:@"手机号位数不等于11位，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		[alert show];
		[alert release];
		return;
	}
	if (pawTextField2.text.length <6) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入错误" message:@"密码位数不能低于6位" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		[alert show];
		[alert release];
		return;
	}if (![pawTextField2.text isEqualToString:checkpsdTextField.text]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入错误" message:@"两次密码输入不一致，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		[alert show];
		[alert release];
		return;
	}
	
	//[waitHub setHidden:NO];
	NSString *loginString = [NSString stringWithFormat:CHECKUSER,@"register",phoneTextField2.text,pawTextField2.text];
	
	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:loginString] usedEncoding:&encode error:nil];
	
	NSArray *aa  = [hotstring componentsSeparatedByString:@">"];
	
	NSString *s = [NSString stringWithFormat:@"%@%@",[aa objectAtIndex:0],@" />"];
	NSLog(@"sss%@",s);
	NSData* data = [s dataUsingEncoding:NSUTF8StringEncoding];
	[self setAll:data];
	
	if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"result"]isEqual:@"SUCCESS"]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"恭喜您" message:@"注册成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		[alert show];
		[alert release];
		[[NSUserDefaults standardUserDefaults]setValue:phoneTextField2.text forKey:@"phone"];
		[[NSUserDefaults standardUserDefaults]setValue:pawTextField2.text forKey:@"psd"];
		[self bttnCancel:nil];
		return;
	}
	NSString *string = (NSString*)[[NSUserDefaults standardUserDefaults]objectForKey:@"result"];
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
	[alert show];
	[alert release];
	return;

}

- (IBAction)bttnCancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)setAll:(NSData *)couponid{
    
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:couponid];
	[parser setDelegate:self];
	[parser parse];
	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString*)qName attributes:(NSDictionary *)attributeDict{
	if (qName) {
		elementName = qName;
	}
	if ([elementName isEqualToString:@"register"]) {
		for (id da in attributeDict) {
			[[NSUserDefaults standardUserDefaults]setValue:[attributeDict objectForKey:(NSString *)da] forKey:(NSString *)da];
		}
	}
	
}

- (void)ContextAnimation
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	NSInteger purple = [[self.view subviews]indexOfObject:self.fView];
	NSInteger maroon = [[self.view subviews] indexOfObject:self.reView];
	[self.view exchangeSubviewAtIndex:purple withSubviewAtIndex:maroon];
    
	
	if (!self.reView.hidden) {
		
		[self.reView setHidden:YES];
		[self.fView setHidden:NO];
	}else{
		[toRe setHidden:YES];
		[self.reView setHidden:NO];
		[self.fView setHidden:YES];
	}
    
	[UIView commitAnimations];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches] anyObject];
    if (touch.tapCount >=1) {
        [pawTextField resignFirstResponder];
		[phoneTextField resignFirstResponder];
		[phoneTextField2 resignFirstResponder];
		[pawTextField2 resignFirstResponder];
		[checkpsdTextField resignFirstResponder];
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	CGRect curFrame=self.reView.frame;
	[UIView animateWithDuration:0.3f animations:^{
		
		self.reView.frame = CGRectMake(curFrame.origin.x, curFrame.origin.y - 40, curFrame.size.width, curFrame.size.height) ;
		self.fView.frame = CGRectMake(curFrame.origin.x, curFrame.origin.y - 40, curFrame.size.width, curFrame.size.height) ;
		
	}];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
	CGRect curFrame=self.reView.frame;
	[UIView animateWithDuration:0.3f animations:^{
		
		self.reView.frame = CGRectMake(curFrame.origin.x, curFrame.origin.y + 40, curFrame.size.width, curFrame.size.height) ;
		self.fView.frame = CGRectMake(curFrame.origin.x, curFrame.origin.y + 40, curFrame.size.width, curFrame.size.height) ;
		
	}];
    
}

- (void)setUpForDismissKeyboard {
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	UITapGestureRecognizer *singleTapGR =
	[[UITapGestureRecognizer alloc] initWithTarget:self
											action:@selector(tapAnywhereToDismissKeyboard:)];
	NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
	[nc addObserverForName:UIKeyboardWillShowNotification
					object:nil
					 queue:mainQuene
				usingBlock:^(NSNotification *note){
					[self.view addGestureRecognizer:singleTapGR];
				}];
	[nc addObserverForName:UIKeyboardWillHideNotification
					object:nil
					 queue:mainQuene
				usingBlock:^(NSNotification *note){
					[self.view removeGestureRecognizer:singleTapGR];
				}];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
	//此method会将self.view里所有的subview的first responder都resign掉
	[self.view endEditing:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
