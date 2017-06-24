//
//  EditNoteViewController.swift
//  NotesApp
//
//  Created by Jenhao on 2016-12-09.
//  Copyright © 2016 Jenhao.ca. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit




class EditNoteViewController: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {


    @IBOutlet weak var TextFieldTitle: UITextField!
    @IBOutlet weak var ImageViewPictures: UIImageView!
    @IBOutlet weak var ButtonLocationTitle: UIButton!

    @IBOutlet weak var IconMaps: UIButton!
    @IBOutlet weak var LabelDate: UILabel!
    @IBOutlet weak var TextViewForEdit: UITextView!
    @IBOutlet weak var ButtonSaveOrEdit: UIBarButtonItem!

    @IBOutlet weak var LabelLatitude: UILabel!
    @IBOutlet weak var LabelLongitude: UILabel!

    var viewType:enumViewType!

    var record:NotesTable!
    var GetLatitude:Double? = nil
    var GetLongitude:Double? = nil

    var locationManager:CLLocationManager?
    var currentLocation : CLLocation?
    var EditMapTitle = ""
    var EditMapSnippet = ""



    override func viewDidLoad() {
        super.viewDidLoad()

        print("LabelLatitude.text! : \(LabelLatitude.text!)")

        LabelLatitude.text = "No Latitude"





        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()


        print("GetLatitude: \(GetLatitude)")
        print("GetLongitude: \(GetLongitude)")




        TextViewForEdit.keyboardType = .default
        TextViewForEdit.isEditable = true
        TextViewForEdit.isSelectable = true



        let currentDate = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-dd,YYYY"

        switch viewType! {
        case enumViewType.ADD:



            LabelDate.text = String(formatter.string(from: currentDate as Date))
            hideKeyborads()
            ButtonSaveOrEdit.title = "Save"
            CheckMap()

            break

        case enumViewType.UPDATE:

            TextFieldTitle.text =  record.notesTitle
            ImageViewPictures.image = UIImage(data: record.notesImage! as Data)
            LabelDate.text = record.notesCreateDate
            TextViewForEdit.text = record.notesDetail
            ButtonSaveOrEdit.title = "Edit"
            LabelLatitude.text = record.notesImageLatitude
            LabelLongitude.text = record.notesImageLongitude
                CheckMap()



            break
        }

    }

    func CheckMap() {

        if LabelLatitude.text! != "No Latitude" {
            LabelLatitude.isHidden = false
            LabelLongitude.isHidden = false
        }else {
            LabelLatitude.isHidden = true
            LabelLongitude.isHidden = true

        }

        if LabelLatitude.isHidden == false {

            ButtonLocationTitle.isHidden = false
            IconMaps.isHidden = false

        }else {

            ButtonLocationTitle.isHidden = true
            IconMaps.isHidden = true
            
        }



    }


    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations.last
        GetLatitude = location!.coordinate.latitude
        GetLongitude = location!.coordinate.longitude
        //        print("Edit Page Latitude: \(GetLatitude!)")
        //        print("Edit Page Longitude: \(GetLongitude!)")
        //


    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }


    @IBAction func ButonSave(_ sender: Any) {


        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //        let NotesItem = NotesTable(context: context)
        let imageData = UIImageJPEGRepresentation(ImageViewPictures.image!, 1)


        switch viewType! {

        case enumViewType.ADD:

            let entityDesc=NSEntityDescription.entity(forEntityName: "NotesTable", in: context)
            let managedObject=NSManagedObject(entity: entityDesc!, insertInto: context) as! NotesTable
            managedObject.notesTitle = self.TextFieldTitle.text
            managedObject.notesImage = imageData as NSData?
            managedObject.notesCreateDate = LabelDate.text!
            managedObject.notesDetail = TextViewForEdit.text!
            managedObject.notesImageLatitude = LabelLatitude.text!
            managedObject.notesImageLongitude = LabelLongitude.text!



            break

        case enumViewType.UPDATE:
            record.notesTitle=self.TextFieldTitle.text
            record.notesImage = imageData as NSData?
            record.notesCreateDate = LabelDate.text!
            record.notesDetail = TextViewForEdit.text!
            record.notesImageLatitude = TextFieldTitle.text!


            break

        }

        (UIApplication.shared.delegate as! AppDelegate).saveContext()

        navigationController!.popViewController(animated: true)



    }

    @IBAction func GestureForHideKB(_ sender: UITapGestureRecognizer) {
        hideKeyborads()
    }


    @IBAction func GestureSelectImage(_ sender: UITapGestureRecognizer) {




        locationManager?.startUpdatingLocation()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()

        print("Edit Page Latitude: \(GetLatitude!)")
        print("Edit Page Longitude: \(GetLongitude!)")

        LabelLatitude.text = "\(GetLatitude!)"
        LabelLongitude.text = "\(GetLongitude!)"


        // Hide the keyboard.
        hideKeyborads()

        let controller = UIAlertController(title: "Take picture from",
                                           message:nil, preferredStyle: .actionSheet)

        let yesAction = UIAlertAction(title: "Camera",style: .default, handler: {(action) -> Void in
            let imagePickerAndShow = UIImagePickerController()
            imagePickerAndShow.sourceType = .camera
            imagePickerAndShow.delegate = self
            self.present(imagePickerAndShow, animated: true, completion: nil)
        })

        let noAction = UIAlertAction(title: "Photo Album",style: .default, handler:  {(action) -> Void in
            let imagePickerAndShow = UIImagePickerController()
            imagePickerAndShow.sourceType = .photoLibrary
            imagePickerAndShow.delegate = self
            self.present(imagePickerAndShow, animated: true, completion: nil)
        })

        let cancelAction = UIAlertAction(title: "Cancel",style: .cancel, handler: {(action) -> Void in
            self.dismiss(animated: true, completion: nil)
        })



        controller.addAction(yesAction)
        controller.addAction(noAction)
        controller.addAction(cancelAction)


        present(controller, animated: true, completion: nil)




        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerAndShow = UIImagePickerController()
        imagePickerAndShow.sourceType = .photoLibrary
        imagePickerAndShow.delegate = self
        present(imagePickerAndShow, animated: true, completion: nil)

        CheckMap()



    }

    // MARK: UIImagePickerControllerDelegate

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // Set photoImageView to display the selected image.
        ImageViewPictures.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyborads(){
        
        TextFieldTitle.resignFirstResponder()
        TextViewForEdit.resignFirstResponder()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMap" {
            let MapDetail = segue.destination as! MapsViewController

            EditMapTitle = TextFieldTitle.text!
            EditMapSnippet = LabelDate.text!

            MapDetail.MapGetLatitude = Double(LabelLatitude.text!)
            MapDetail.MapGetLongitude = Double(LabelLongitude.text!)
            MapDetail.MapTitle = EditMapTitle
            MapDetail.MapSnippet = EditMapSnippet
        }
    }
    
    
    
}
