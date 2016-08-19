//
//  UserStorieController.swift
//  trackRequirement
//
//  Created by Victor de Lima on 19/08/16.
//  Copyright © 2016 Victor de Lima. All rights reserved.
//

import Foundation

class UserStoryController : NSObject {
	
	
	func saveUserStory(userStory:UserStory){
				
		let dict = NSMutableDictionary()
		dict.setValue(userStory.ID, forKey: "id")
		dict.setValue(userStory.title, forKey: "title")
		dict.setValue(userStory.story, forKey: "story")
		
		FileManager.saveFile(fileName: "story1", withData: dict, inDirectory: .STORIES)
	}
	
}