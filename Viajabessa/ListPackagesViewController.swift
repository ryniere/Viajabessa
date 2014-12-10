//
//  ListPackagesViewController.swift
//  Viajabessa
//
//  Created by Ryniere dos Santos Silva on 07/12/14.
//  Copyright (c) 2014 Ryniere dos Santos Silva. All rights reserved.
//

import UIKit

class ListPackagesViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate{
	
	var filteredPackages = [Package]()
	
	struct TableCellConstants {
		struct Nib {
			static let name = "ListPackagesTableCell"
		}
		
		struct TableViewCell {
			static let identifier = "listPackagesCellID"
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let nib = UINib(nibName: TableCellConstants.Nib.name, bundle: nil)
		self.tableView.registerNib(nib, forCellReuseIdentifier: TableCellConstants.TableViewCell.identifier)
		self.searchDisplayController!.searchResultsTableView.registerNib(nib, forCellReuseIdentifier: TableCellConstants.TableViewCell.identifier)
		
		
		// Package List refresh
		var refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: Selector("refreshPackages"), forControlEvents: UIControlEvents.ValueChanged)
		self.refreshControl = refreshControl
		
		//oself.tableView.tableHeaderView?.addSubview(searchBar)
		
		refreshPackages()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	// Table delegate functions
	
	func configureCell(cell: ListPackagesTableViewCell, forPackage package: Package) {
		
		cell.cityLabel.text = package.city
		cell.priceLabel.text = NSString(format:"%@%.2f", package.currency, package.price)
		
		downloadImage(NSURL(string: package.imageUrl)!, {image, error in
			
			//image.size.width = 320.0
			
			package.image = image
			cell.packageImage.image = package.image
		})
		
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 230.0
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int)->Int{
		
		return 1
	}
	
	override func numberOfSectionsInTableView( tableView: UITableView) -> Int {
		
		if tableView == self.searchDisplayController!.searchResultsTableView {
			return self.filteredPackages.count
		} else {
			return packagesList.count
		}
	}
	
	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 10
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(TableCellConstants.TableViewCell.identifier, forIndexPath: indexPath) as ListPackagesTableViewCell
		
		var package: Package
		if tableView == self.searchDisplayController!.searchResultsTableView {
			package = filteredPackages[indexPath.section]
		} else {
			package = packagesList[indexPath.section]
		}
		
		configureCell(cell, forPackage: package)
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		var selectedPackage: Package
		
		if tableView == self.searchDisplayController!.searchResultsTableView {
			selectedPackage = filteredPackages[indexPath.section]
		} else {
			selectedPackage = packagesList[indexPath.section]
		}
		
		// Set up the detail view controller to show.
		let detailViewController = PackageDetailsViewController.forPackage(selectedPackage)
		
		navigationController?.pushViewController(detailViewController, animated: true)
		
	}
	
	// Search Bar delegates
	
	func filterContentForSearchText(searchText: String) {
		
		self.filteredPackages = packagesList.filter({( package  : Package) -> Bool in
			
			var stringMatch = package.city.lowercaseString.rangeOfString(searchText.lowercaseString)
			return stringMatch != nil
			
		})
		
	}
	
	func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
		
		self.filterContentForSearchText(searchString)
		return true
		
	}
	
	func searchDisplayController(controller: UISearchDisplayController!,
		shouldReloadTableForSearchScope searchOption: Int) -> Bool {
			
			let scope = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
			self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
			return true
			
	}
	
	
	
	func refreshPackages(){
		
		getPackagesFromServer( afterDownloadPackages, {})
		
	}
	
	func afterDownloadPackages(){
		
		self.tableView.reloadData()
		refreshControl?.endRefreshing()
		
	}


}

