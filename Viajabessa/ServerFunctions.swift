//
//  ServerFunctions.swift
//  Viajabessa
//
//  Created by Ryniere dos Santos Silva on 07/12/14.
//  Copyright (c) 2014 Ryniere dos Santos Silva. All rights reserved.
//

import Foundation

func parseJSON(inputData: NSData) -> NSDictionary{
	var error: NSError?
	
	var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
	return boardsDictionary
}


func getPackagesFromServer( onCompletation: () -> Void, onFailure: () -> Void){
	
	
	let url = NSURL(string: LIST_ALL_PACKAGES_URL)!
	let request = NSMutableURLRequest(URL: url)
	
	let session = NSURLSession.sharedSession()
	let task = session.dataTaskWithRequest(request) { (data: NSData!, response: NSURLResponse!, error: NSError!) in
		
		if error != nil {
			// Handle error...
			onFailure()
		}
		
		var json = parseJSON(data)
		
		if let packages = json["packages"] as? NSArray {
			var i:Int = 0 ;
			
			for package in packages{
				
				var id:String = package["id"] as String!
				var title:String = package["title"] as String!
				var price:Double = package["price"] as Double!
				var city:String = package["city"] as String!
				var currency:String = package["currency"] as String!
				var days:Int = package["days"] as Int!
				
				var newPackage = Package(id: id, title: title, city: city, days: days, price: price, currency: currency)
				
				packagesList.append(newPackage)
				
			}
			
			
		}
		
		dispatch_async(dispatch_get_main_queue()) {
			onCompletation()
		}
	}
	
	task.resume()
}