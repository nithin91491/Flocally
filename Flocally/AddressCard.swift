//
//  AddressCard.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/29/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import Foundation

@IBDesignable class AddressCard:UIView{
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAddressLine1: UILabel!
    
    @IBOutlet weak var lblAddressLine2: UILabel!
    
    
    @IBOutlet weak var lblCityState: UILabel!
    
    @IBOutlet weak var lblPIN: UILabel!
    
    
    @IBOutlet weak var lblMobileNumber: UILabel!
    
    var view:UIView!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "AddressCard", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
}