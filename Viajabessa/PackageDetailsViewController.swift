//
//  PackageDetailsViewController.swift
//  Viajabessa
//
//  Created by Ryniere dos Santos Silva on 09/12/14.
//  Copyright (c) 2014 Ryniere dos Santos Silva. All rights reserved.
//

import UIKit

class PackageDetailsViewController: UIViewController {
	
	@IBOutlet weak var packageImage: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!

	
	var package:Package!
	
	// Constants for Storyboard/ViewControllers
	struct StoryboardConstants {
		static let storyboardName = "Main"
		static let viewControllerIdentifier = "PackageDetailsViewController"
		
	}
	
	
	// MARK: Factory Methods
	
	class func forPackage(package: Package) -> PackageDetailsViewController {
		let storyboard = UIStoryboard(name: StoryboardConstants.storyboardName, bundle: nil)
		
		let viewController = storyboard.instantiateViewControllerWithIdentifier(StoryboardConstants.viewControllerIdentifier) as PackageDetailsViewController
		
		viewController.package = package
		
		return viewController
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		self.title = package.city
		self.packageImage.image = package.image
		self.titleLabel.text = package.title
		self.descriptionLabel.text = package.description
		self.priceLabel.text = NSString(format:"%@%.2f", package.currency, package.price)
		
		
		// Google Analytics
		var dictionaryBuilder:GAIDictionaryBuilder = GAIDictionaryBuilder.createEventWithCategory("PackageDetails",
			action:"viewPackageDeitails",
			label:package.id,
			value:nil)
		var event:NSMutableDictionary = dictionaryBuilder.build()
		GAI.sharedInstance().defaultTracker.send(event)
		GAI.sharedInstance().dispatch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	@IBAction func buyPackageButton(sender: AnyObject) {
		
		// Google Analytics
		var dictionaryBuilder:GAIDictionaryBuilder = GAIDictionaryBuilder.createEventWithCategory("BuyPackage",
			action:"viewPackageDeitails",
			label:package.id,
			value:nil)
		var event:NSMutableDictionary = dictionaryBuilder.build()
		GAI.sharedInstance().defaultTracker.send(event)
		GAI.sharedInstance().dispatch()
		
		let alert = UIAlertView()
		alert.title = "Pacote comprado"
		alert.message = "Boa viagem"
		alert.addButtonWithTitle("Ok")
		alert.delegate = self
		alert.show()
		
		
	}
	
	func alertView(view :UIAlertView, clickedButtonAtIndex :Int) -> Void {
		
		if(clickedButtonAtIndex == 0){
			self.navigationController?.popViewControllerAnimated(true)
		}
		
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
