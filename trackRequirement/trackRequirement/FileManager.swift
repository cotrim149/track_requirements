//
//  FileManager.swift
//  trackRequirement
//
//  Created by Victor de Lima on 19/08/16.
//  Copyright © 2016 Victor de Lima. All rights reserved.
//

import Foundation

enum FilesDirectory : String {
	case STORIES = "stories"
}


class FileManager: NSObject {

	static func getPathInDirectory(directoryNamed:FilesDirectory,projectName: String)-> String{
		var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
		path.appendContentsOf("/track_requirements/\(projectName)/\(directoryNamed)")
		
		return path
	}
	
	static func saveFile(fileName fileName:String, ofProject projectName:String, withData data:NSMutableDictionary, inDirectory directory:FilesDirectory){
		
		
		let fileDirectory = getPathInDirectory(directory,projectName: projectName)
		
		var name = ""
//		 verify if file exist
		if isFileExist(fileName+".plist", inProject: projectName,inDirectory: directory) == true {
			let copyNumber = countFilesWithName(fileName: fileName,inProject: projectName,inDirectory: directory) - 1
			name = fileName+"_copy_"+String(copyNumber)
		}else{
			name = fileName
		}
		
		do{
			try NSFileManager.defaultManager().createDirectoryAtPath(fileDirectory, withIntermediateDirectories: true, attributes: nil)
			
		}catch {
			print("Directory not created")
		}
		
		let path = fileDirectory.stringByAppendingString("/"+name+".plist")
		
		print("Saving plist in: " + path)
		
		if data.writeToFile(path, atomically: true) {
			print("Data write to file with success")
		}else{
			print("Data write failed")
		}
	}
	
	static func loadFile(fileName filename:String, inProject projectName:String, directory:FilesDirectory) -> NSDictionary{
		let directory = getPathInDirectory(directory,projectName: projectName)
		let path = directory.stringByAppendingString("/"+filename+".plist")
		let save = NSDictionary(contentsOfFile: path)
		
		return save!
	}
	
	static func removeFile(fileName fileName:String, inProject projectName:String ,directory:FilesDirectory){
		
		let fileManager = NSFileManager.defaultManager()
		
		let directory = getPathInDirectory(directory,projectName: projectName)
		
		let filePath = directory.stringByAppendingString("/"+fileName+".plist")
		
		print("Delete file: "+filePath)
		
		if fileManager.fileExistsAtPath(filePath) {
			do {
				try fileManager.removeItemAtPath(filePath)
				print("File deleted with success!");
			}catch {
				print("Could not delete file: "+filePath)
			}
			
		}
		
	}

//	static internal func editFileName(oldFileName oldFileName:String, newFileName:String, inDirectory directory:FilesDirectory){
//		do {
//			let documentDirectory = NSURL(fileURLWithPath: getPathInDirectory(directory))
//			let originPath = documentDirectory.URLByAppendingPathComponent("/\(oldFileName)")
//			let destinationPath = documentDirectory.URLByAppendingPathComponent("/\(newFileName)")
//			try NSFileManager.defaultManager().moveItemAtURL(originPath, toURL: destinationPath)
//		} catch let error as NSError {
//			print(error)
//		}
//	}
//	
	// File Manager Util
	static func countFilesWithName(fileName fileName:String, inProject projectName:String, inDirectory directory:FilesDirectory)->Int{
		
		
		var filesName : [String]!

		filesName = retriveAllFilesName(ofProject: projectName,inDirectory: directory)
		
		var count = 0
		
		for name in filesName {
			if name.containsString(fileName) {
				count += 1
			}
		}
		
		return count
	}
	
	static func retriveAllFilesName(ofProject projectName:String,inDirectory directory:FilesDirectory) -> [String]{
		
		let directory = getPathInDirectory(directory,projectName: projectName)
		
		var directoryContents : [String]!
		
		do{
			directoryContents = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(directory)
		}catch {
			print("Retrive contents fail")
			// create directory
			do {
				try NSFileManager.defaultManager().createDirectoryAtPath(directory, withIntermediateDirectories: true, attributes: nil)
			}catch {
				print("Directory not created!")
			}
			
			directoryContents = [String]()
		}
		
		return directoryContents
	}
	
	
//	static func createFolder(folderName folderName:String, inDirectory directory:String){
//		
//		
//		do {
//			try NSFileManager.defaultManager().createDirectoryAtPath(directory, withIntermediateDirectories: false, attributes: nil)
//		}catch {
//			print("Directory not created!")
//		}
//		
//	}
	
	static func isFileExist(fileName:String, inProject projectName:String ,inDirectory directory:FilesDirectory)->Bool{
		let fileManager = NSFileManager.defaultManager()
		let documentsPath = getPathInDirectory(directory,projectName: projectName)
		let filePath = documentsPath.stringByAppendingString("/"+fileName)
		
		return fileManager.fileExistsAtPath(filePath)
	}
	
//	static func removeExtension(extens extens:String, inout from fileName:String){
//		fileName = fileName.stringByReplacingOccurrencesOfString("."+extens, withString: "")
//	}
//	
//	static func addExtension(extens extens:String, inout of fileName:String){
//		fileName = fileName.stringByAppendingString("."+extens)
//	}
}
