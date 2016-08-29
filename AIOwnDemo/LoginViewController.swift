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

		userNameOutlet.setValue(UIColor.whiteColor(), forKeyPath: "placeholderLabel.textColor")
		passwordOutlet.setValue(UIColor.whiteColor(), forKeyPath: "placeholderLabel.textColor")
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

//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .LightContent
//    }
	override func prefersStatusBarHidden() -> Bool {
		return false
	}

	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}
}
