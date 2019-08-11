//
//  Data.swift
//  Theatre Suite - Handbook
//
//  Created by Mathew Willett on 8/7/18.
//  Copyright © 2018 Mathew Willett. All rights reserved.
//

import Foundation
import Firebase


class Data {
    
    
    //Download Main Page Data
    func downloadMainData(completion: @escaping ([returnSnapshot], String) -> Void) {
        let dbRef = Firestore.firestore().collection("Data")
        var snapArray = [returnSnapshot]()
        dbRef.getDocuments { snapshot, error in
            if let error = error {
                print("Get Document Error...\(error)")
                completion(snapArray, error as! String)
                return
            }
            for docs in (snapshot?.documents)! {
                let doc = returnSnapshot(documentSnapchot: docs)
                snapArray.append(doc)
            }
        completion(snapArray, "")
        }
    }
    
    
    
    
    
    
    //Download Detail Paig Data
    func downloadDetailData(mainDocID: String, completion: @escaping ([document], [Int]) -> Void) {
        let dbRef = Firestore.firestore().collection("Data").document(mainDocID).collection("Collections")
        var docArray = [document]()
        let query = dbRef
        var detailScreenNums : [Int] = []
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Get Document Error...\(error)")
                completion(docArray, [])
                return
            }
            for docs in snapshot!.documents {
                //print(docs)
                //get the document names
                let doc = document(documentID: docs.documentID)
                docArray.append(doc)
                //Get the detail screen numbers
                for key in docs.data() {
                    if key.key == "DetailScreen" {
                        detailScreenNums.append(key.value as! Int)
                    }
                }
            }
            completion(docArray, detailScreenNums)
        }
    }
    
    
    
    func downloadMoreDetail(mainDocID: String, detailDocID: String, completion: @escaping ([document], [Int], [Int]) -> Void) {
        let dbRef = Firestore.firestore().collection("Data").document(mainDocID).collection("Collections").document(detailDocID).collection("Collections")
        var docArray = [document]()
        var detailScreenNums : [Int] = []
        var dbid : [Int] = []
        dbRef.getDocuments { snapshot, error in
            if let error = error {
                print("Get Document Error...\(error)")
                completion(docArray, [], [])
                return
            }
            for docs in snapshot!.documents {
                //print(docs)
                //get the document names
                let doc = document(documentID: docs.documentID)
                docArray.append(doc)
                //Get the detail screen numbers
                for key in docs.data() {
                    switch key.key
                    {
                    case "DetailScreen":
                        detailScreenNums.append(key.value as! Int);
                    case "DBID":
                        dbid.append(key.value as! Int);
                    default:
                        break
                    }
                }
            }
            completion(docArray, detailScreenNums, dbid)
        }
    }
    
    
    
}





//Data structure for DB downloads
struct returnSnapshot {
    var documentSnapchot : QueryDocumentSnapshot
}

struct document {
    var documentID : String
}
