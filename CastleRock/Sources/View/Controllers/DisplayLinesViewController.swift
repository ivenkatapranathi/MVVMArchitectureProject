//
//  DisplayLinesViewController.swift
//  CastleRock
//
//  Created by Venkata Pranathi Immaneni on 1/22/22.
//

import UIKit

/*
 ***************************************************
 *****************  DisplayLinesViewController  ****
 ***************************************************
*/
class DisplayLinesViewController: UIViewController {

    /*
     ***********  IBOutlets  ***********
    */
    @IBOutlet weak var displayText: UILabel!
    
    /*
     ***********  Internal Variables ***********
    */
    internal var display: Display?
    internal var isDisplayingStatus = false
    
    /*
     ***********  Overrides  ***********
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.printDisplayText()
    }
    
    /*
     ***********  Private Methods  ***********
    */
    
    /*
     This is the helper function to display the lines text.
     */
    private func printDisplayText() {
        if(isDisplayingStatus && display != nil) {
            self.displayText.text = display!.getDisplayLines()
        } else {
            self.displayText.text = "NOT DISPLAYING MESSAGE"
        }
    }
}
