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

	static func getPathInDirectory(directoryName:FilesDirectory)-> String{
//		var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
		var path = ""
		path.appendContentsOf("\(directoryName)")
		
		return path
	}
	
	static func saveFile(fileName fileName:String, withData data:NSMutableDictionary, inDirectory directory:FilesDirectory){
		
		let fileDirectory = getPathInDirectory(directory)
		
//		var name = ""
		// verify if file exist
//		if isFileExist(fileName+".plist",inDirectory: directory) == true {
//			let copyNumber = countFilesWithName(fileName: fileName,inDirectory: directory) - 1
//			name = fileName+"_copy_"+String(copyNumber)
//		}else{
//			name = fileName
//		}
		
		do{
			try NSFileManager.defaultManager().createDirectoryAtPath(fileDirectory, withIntermediateDirectories: false, attributes: nil)
			
		}catch {
			
		}
		
		let path = fileDirectory.stringByAppendingString("/"+fileName+".plist")
		
		print("Saving plist in: " + path)
		
		if data.writeToFile(path, atomically: true) {
			print("Data write to file with success")
		}else{
			print("Data write failed")
		}
	}
	
	static func loadFile(fileName filename:String, directory:FilesDirectory) -> NSDictionary{
		let directory = getPathInDirectory(directory)
		let path = directory.stringByAppendingString("/"+filename+".plist")
		let save = NSDictionary(contentsOfFile: path)
		
		return save!
	}
	
	
	static func removeFile(fileName fileName:String,directory:FilesDirectory){
		
		let fileManager = NSFileManager.defaultManager()
		
		let directory = getPathInDirectory(directory)
		
		let filePath = directory.stringByAppendingString("/"+fileName)
		
		print("Delete file: "+filePath)
		
		if fileManager.fileExistsAtPath(filePath) {
			do {
				try fileManager.removeItemAtPath(filePath)
				//			let removedSuccessFullyAlert = UIAlertView(title: "Congratulations!", message: "Successfully removed file", delegate: self, cancelButtonTitle: "OK")
				print("File deleted with success!");
			}catch {
				print("Could not delete file: "+filePath)
			}
			
		}
		
	}
	
	static internal func editFileName(oldFileName oldFileName:String, newFileName:String, inDirectory directory:FilesDirectory){
		do {
			let documentDirectory = NSURL(fileURLWithPath: getPathInDirectory(directory))
			let originPath = documentDirectory.URLByAppendingPathComponent("/\(oldFileName)")
			let destinationPath = documentDirectory.URLByAppendingPathComponent("/\(newFileName)")
			try NSFileManager.defaultManager().moveItemAtURL(originPath, toURL: destinationPath)
		} catch let error as NSError {
			print(error)
		}
	}
	
	// File Manager Util
//	static func countFilesWithName(fileName fileName:String, inDirectory directory:FilesDirectory)->Int{
//		
//		
//		var filesName : [String]!
//		
//		if directory == .GRAPH_DIRECTORY {
//			filesName = retriveAllFilesName(inDirectory: .GRAPH_DIRECTORY)
//		}else if directory == .EXERCISE_DIRECTORY {
//			filesName = retriveAllFilesName(inDirectory: .EXERCISE_DIRECTORY)
//		}
//		
//		var count = 0
//		
//		for name in filesName {
//			if name.containsString(fileName) {
//				count += 1
//			}
//		}
//		
//		return count
//	}
	
	static func retriveAllFilesName(inDirectory directory:FilesDirectory) -> [String]{
		
		let directory = getPathInDirectory(directory)
		
		var directoryContents : [String]!
		
		do{
			directoryContents = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(directory)
		}catch {
			print("Retrive contents fail")
			
			do {
				try NSFileManager.defaultManager().createDirectoryAtPath(directory, withIntermediateDirectories: false, attributes: nil)
			}catch {
				print("Directory not created!")
			}
			
			directoryContents = [String]()
		}
		
		return directoryContents
	}
	
	
	static func isFileExist(fileName:String, inDirectory directory:FilesDirectory)->Bool{
		let fileManager = NSFileManager.defaultManager()
		let documentsPath = getPathInDirectory(directory)
		let filePath = documentsPath.stringByAppendingString("/"+fileName)
		
		return fileManager.fileExistsAtPath(filePath)
	}
	
	static func removeExtension(extens extens:String, inout from fileName:String){
		fileName = fileName.stringByReplacingOccurrencesOfString("."+extens, withString: "")
	}
	
	static func addExtension(extens extens:String, inout of fileName:String){
		fileName = fileName.stringByAppendingString("."+extens)
	}
}
