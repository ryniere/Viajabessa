//
//  Package.swift
//  Viajabessa
//
//  Created by Ryniere dos Santos Silva on 07/12/14.
//  Copyright (c) 2014 Ryniere dos Santos Silva. All rights reserved.
//

import Foundation


class Package{
	
	var id:String!
	var title:String!
	var city:String!
	var days:Int!
	var price:Double = 0.0
	var currency:String!
	var imageUrl:String!
	
	init(id:String, title:String, city:String, days:Int, price:Double, currency:String, imageUrl:String){
		
		self.id = id
		self.title = title
		self.city = city
		self.days = days
		self.price = price
		self.currency = currency
		self.imageUrl = imageUrl
		}
}