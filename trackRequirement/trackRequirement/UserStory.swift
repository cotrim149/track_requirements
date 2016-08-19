//
//  UserStory.swift
//  trackRequirement
//
//  Created by Victor de Lima on 19/08/16.
//  Copyright © 2016 Victor de Lima. All rights reserved.
//

import Foundation

class UserStory: NSObject {
	
	var ID:Int!
	var title:String!
	var story:String!
	
	init(ID:Int, title:String, story:String){
		self.ID = ID
		self.title = title
		self.story = story
	}
	
}
