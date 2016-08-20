//
//  UserStorieController.swift
//  trackRequirement
//
//  Created by Victor de Lima on 19/08/16.
//  Copyright © 2016 Victor de Lima. All rights reserved.
//

import Foundation

class UserStoryController : NSObject {
	
	func saveUserStory(userStory:UserStory, ofProject projectName:String){
				
		let dict = NSMutableDictionary()
		dict.setValue(userStory.ID, forKey: "id")
		dict.setValue(userStory.title, forKey: "title")
		dict.setValue(userStory.story, forKey: "story")
		
		FileManager.saveFile(fileName: "story1",ofProject:projectName, withData: dict, inDirectory: .STORIES)
	}
	
	func loadUserStory(fileName fileName:String, ofProject projectName:String)->UserStory{
		let dict = FileManager.loadFile(fileName: fileName, inProject: projectName,directory: .STORIES)
		
		let userStory = UserStory()
		
		userStory.ID = dict.valueForKey("id") as! Int
		userStory.title = dict.valueForKey("title") as! String
		userStory.story = dict.valueForKey("story") as! String
		
		return userStory
	}
	
	func deleteUserStory(fileName fileName:String, ofProject projectName:String){
		FileManager.removeFile(fileName: fileName, inProject: projectName,directory: .STORIES)
	}
	
}