//
//  main.swift
//  trackRequirement
//
//  Created by Victor de Lima on 19/08/16.
//  Copyright © 2016 Victor de Lima. All rights reserved.
//

import Foundation

print("Hello, World!")

let story = UserStory(ID: 1, title: "Estória teste", story: "Eu como um desenvolvedor ...")

UserStoryController().saveUserStory(story)