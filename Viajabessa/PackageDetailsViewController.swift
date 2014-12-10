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

}
