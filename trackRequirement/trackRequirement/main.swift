//
//  main.swift
//  trackRequirement
//
//  Created by Victor de Lima on 19/08/16.
//  Copyright © 2016 Victor de Lima. All rights reserved.
//

import Foundation



while(true){
	
	print("1 - Cadastrar Estória")
	print("2 - Carregar Estória")
	print("3 - Apagar Estória")
	
	let option = Int(readLine(stripNewline: true)!)
	
	switch option?.littleEndian {
	case 1?:
		let story = UserStory(ID: 1, title: "Estória teste", story: "Eu como um desenvolvedor ...")
		UserStoryController().saveUserStory(story)
		break
	case 2?:
		let story = UserStoryController().loadUserStory(fileName: "story1")
		print(story.ID)
		print(story.title)
		print(story.story)
		break
	case 3?:
		UserStoryController().deleteUserStory(fileName: "story1")
		break
	default:
		print("Not is a choose")
	}
	
}



