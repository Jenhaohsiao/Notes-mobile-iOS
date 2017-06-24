//
//  ListAllTableViewController.swift
//  NotesApp
//
//  Created by Jenhao on 2016-12-09.
//  Copyright © 2016 Jenhao.ca. All rights reserved.
//

import UIKit

var NotesArray : [NotesTable] = []

class ListAllTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {

self.navigationController?.setNavigationBarHidden(false, animated: true)

        //get the data from core data
        getData()

        
        
        //reload the table view
        tableView.reloadData()
        //        ifNoTask()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NotesArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteListCell", for: indexPath) as! NotesTableViewCell
        let NotesItemShow = NotesArray[indexPath.row] as NotesTable

        if NotesItemShow.notesTitle != "" {
            cell.LabelCellSubtitle?.text = "\(NotesItemShow.notesTitle!)"
        } else if  title == "" {
            cell.LabelCellSubtitle?.text = "No Title"
        }

        if let notesImage = NotesItemShow.notesImage {
            cell.ImageCell?.image  = UIImage(data: NotesItemShow.notesImage as! Data)
        }else{
            cell.ImageCell?.image  = UIImage(named: "NoImage")
        }

        if NotesItemShow.notesDetail != "Add more detail..."{
            cell.LabelDetail.text =  "\(NotesItemShow.notesDetail!)"
        }else{
            cell.LabelDetail.text =  "(No detail)"
        }
         if let notesDate = NotesItemShow.notesCreateDate {
            cell.LabelCellDate.text =  "\(NotesItemShow.notesCreateDate!)"
        }else{
            cell.LabelCellDate.text =  "(No detail)"
        }


        if NotesItemShow.notesImageLatitude != "No Latitude" {
            cell.MapsIcon.isHidden = false
        }else{
            cell.MapsIcon.isHidden = true
        }


        // Configure the cell...
        
        return cell
    }
    
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            
            NotesArray = try context.fetch(NotesTable.fetchRequest())
            
        }
        catch {
            print("Fetching Failed")
        }
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        
        if editingStyle == .delete{
            let notes = NotesArray[indexPath.row]
            context.delete(notes)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            
            do{
                NotesArray = try context.fetch(NotesTable.fetchRequest())
                
            }
            catch {
                print("Fetching Failed")
            }
            
        }
        
        tableView.reloadData()
        
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editNotes" {
            let detail = segue.destination as! EditNoteViewController
            
            if let selectedCell = sender as? NotesTableViewCell{
                
                
                var indexPath = tableView.indexPath(for: selectedCell)
                
                let selectedNotes = NotesArray[(indexPath?.row)!]
                detail.record = selectedNotes
                detail.viewType = enumViewType.UPDATE

            }
        }
        else
        {
            // add segue
            let detail = segue.destination as! EditNoteViewController
            
                detail.viewType = enumViewType.ADD
        }
        
    }
    
}
