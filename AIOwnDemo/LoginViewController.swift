//
//  LoginViewController.swift
//  AIOwnDemo
//
//  Created by angcyo on 16/08/28.
//  Copyright © 2016年 angcyo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var userNameOutlet: UITextField!
	@IBOutlet weak var passwordOutlet: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.

		navigationController?.navigationBar.show()
		navigationController?.navigationBar.removeBGView()
		navigationItem.setTitleTextAndColor(UIColor.whiteColor(), title: "登录")

		userNameOutlet.setPlaceholderLabelColor(UIColor.whiteColor())
		passwordOutlet.setPlaceholderLabelColor(UIColor.whiteColor())

		userNameOutlet.delegate = self
		passwordOutlet.delegate = self

//		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onKeyboardShow), name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onKeyboardHide), name: UIKeyboardDidHideNotification, object: nil)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */

	override func prefersStatusBarHidden() -> Bool {
		return false
	}

	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}

	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		userNameOutlet.resignFirstResponder()
		passwordOutlet.resignFirstResponder()
	}

	@IBAction func onLoginTappend(sender: AnyObject) {
//		JHProgressHUD.sharedHUD.showInWindow()

		if userNameOutlet.text!.isEmpty || passwordOutlet.text!.isEmpty {
			showAlertView(title: "提示", message: "请输入用户名/密码")
			return
		}

		JHProgressHUD.sharedHUD.showInWindow(withHeader: nil, andFooter: "登录中...")
		GCD.afterDelay(0.5) {
			JHProgressHUD.sharedHUD.hide()
			let mainViewController = R.storyboard.main.mainViewControllerID()!
			mainViewController.transitioningDelegate = self
			self.presentViewController(mainViewController, animated: true, completion: nil)
		}
	}

	@IBAction func onForgetTappend(sender: AnyObject) {
//		HUD.show(HUDContentType.Progress)
//		HUD.show(HUDContentType.Success)
//		HUD.flash(HUDContentType.Success, delay: 2)
//		HUD.flash(HUDContentType.Progress)
		HUD.flash(HUDContentType.Error)
		noticeTop("忘记密码了吗?", backgroundColor: UIColor.redColor())
	}

	func addHUD() {
		let label = UILabel()
		label.text = "HUD...Test"
		label.textColor = UIColor.whiteColor()
		label.sizeToFit()
		// label.backgroundColor = UIColor.greenColor()
		label.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
		label.layer.cornerRadius = 10
		label.layer.borderWidth = 2
		label.layer.borderColor = UIColor.blueColor().CGColor
		// label.layer.backgroundColor = UIColor.greenColor().CGColor
		app.window?.addSubview(label)
	}
}

//MARK: 扩展键盘显示和隐藏
extension LoginViewController {
	/**
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 606.5}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 353.5}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 480}, {320, 253}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 227}, {320, 253}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     */

	// 键盘显示
	func onKeyboardShow(notify: NSNotification) {
//		print("Show \(NSThread.isMainThread(),notify)")
		if [UIKeyboardDidShowNotification, UIKeyboardWillShowNotification].contains(notify.name) {

			let value = notify.userInfo![UIKeyboardFrameBeginUserInfoKey] as? NSValue

			guard let keyboardRect = value?.CGRectValue() else {
				return
			}

			let keyboardHeight = keyboardRect.height
			UIView.animateWithDuration(1) {
				self.view.center.y = -keyboardHeight
			}

		}
	}

	// 键盘隐藏
	func onKeyboardHide(notify: NSNotification) {
//		print("Hide \(NSThread.isMainThread(), notify) ")
		translationViewBotton()
	}
}

extension LoginViewController: UITextFieldDelegate {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if textField.returnKeyType == UIReturnKeyType.Next && textField === userNameOutlet {
			passwordOutlet.becomeFirstResponder()
		} else if textField == passwordOutlet {
			textField.resignFirstResponder()
			if UIScreen.isSmallScreen {
				translationViewBotton()
			}
		}
		return true
	}
	func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
		if textField === passwordOutlet && UIScreen.isSmallScreen {
			translationViewTop()
		}
		return true
	}

	// MARK:视图向下平移
	func translationViewBotton() {
		var view: UIView
		if let parentViewController = parentViewController {
			view = parentViewController.view
		} else {
			view = self.view
		}

		UIView.animateWithDuration(0.3) {
			view.center.y = screenHeight / 2
		}
	}

	// MARK: 视图向上平移
	func translationViewTop() {
		var view: UIView
		if let parentViewController = parentViewController {
			view = parentViewController.view
		} else {
			view = self.view
		}

		UIView.animateWithDuration(0.3) {
			view.center.y = screenHeight / 2 - 100
		}
	}
}

//MARK: 过渡动画protocol
extension LoginViewController: UIViewControllerTransitioningDelegate {
	// 返回打开时的动画
	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return BaseTransitionAnimation()
	}

	// 返回关闭时的动画
	func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return BaseDismissTransitionAnimation()
	}
}

