//
//  FilterViewController.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/11/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterViewCellDelegate, SortByCellDelegate, DealCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterSwitch: UISwitch!
    var filtersDictionary: [Int: Bool] = [Int: Bool]()
    
    var sortBy: Int!
    
    var deals: Bool!
    
    var CATEGORIES = [ ["Afghan", "afghani"] ]
    
    override func viewWillAppear(animated: Bool) {
        CATEGORIES.append(["African", "african"])
        CATEGORIES.append(["American, New", "newamerican"])
        CATEGORIES.append(["American, Traditional", "tradamerican"])
        CATEGORIES.append(["Arabian", "arabian"])
        CATEGORIES.append(["Argentine", "argentine"])
        CATEGORIES.append(["Armenian", "armenian"])
        CATEGORIES.append(["Asian Fusion", "asianfusion"])
        CATEGORIES.append(["Asturian", "asturian"])
        CATEGORIES.append(["Australian", "australian"])
        CATEGORIES.append(["Austrian", "austrian"])
        CATEGORIES.append(["Baguettes", "baguettes"])
        CATEGORIES.append(["Bangladeshi", "bangladeshi"])
        CATEGORIES.append(["Barbeque", "bbq"])
        CATEGORIES.append(["Basque", "basque"])
        CATEGORIES.append(["Bavarian", "bavarian"])
        CATEGORIES.append(["Beer Garden", "beergarden"])
        CATEGORIES.append(["Beer Hall", "beerhall"])
        CATEGORIES.append(["Beisl", "beisl"])
        CATEGORIES.append(["Belgian", "belgian"])
        CATEGORIES.append(["Bistros", "bistros"])
        CATEGORIES.append(["Black Sea", "blacksea"])
        CATEGORIES.append(["Brasseries", "brasseries"])
        CATEGORIES.append(["Brazilian", "brazilian"])
        CATEGORIES.append(["Breakfast & Brunch", "breakfast_brunch"])
        CATEGORIES.append(["British", "british"])
        CATEGORIES.append(["Buffets", "buffets"])
        CATEGORIES.append(["Bulgarian", "bulgarian"])
        CATEGORIES.append(["Burgers", "burgers"])
        CATEGORIES.append(["Burmese", "burmese"])
        CATEGORIES.append(["Cafes", "cafes"])
        CATEGORIES.append(["Cafeteria", "cafeteria"])
        CATEGORIES.append(["Cajun/Creole", "cajun"])
        CATEGORIES.append(["Cambodian", "cambodian"])
        CATEGORIES.append(["Canadian", "New)"])
        CATEGORIES.append(["Canteen", "canteen"])
        CATEGORIES.append(["Caribbean", "caribbean"])
        CATEGORIES.append(["Catalan", "catalan"])
        CATEGORIES.append(["Chinese", "chinese"])
        CATEGORIES.append(["Cypriot", "cypriot"])
        CATEGORIES.append(["Czech", "czech"])
        CATEGORIES.append(["Czech/Slovakian", "czechslovakian"])
        CATEGORIES.append(["Danish", "danish"])
        CATEGORIES.append(["Delis", "delis"])
        CATEGORIES.append(["Diners", "diners"])
        CATEGORIES.append(["Dumplings", "dumplings"])
        CATEGORIES.append(["Eastern European", "eastern_european"])
        CATEGORIES.append(["Ethiopian", "ethiopian"])
        CATEGORIES.append(["Fast Food", "hotdogs"])
        CATEGORIES.append(["Filipino", "filipino"])
        CATEGORIES.append(["Fish & Chips", "fishnchips"])
        CATEGORIES.append(["Fondue", "fondue"])
        CATEGORIES.append(["Food Court", "food_court"])
        CATEGORIES.append(["Food Stands", "foodstands"])
        CATEGORIES.append(["French", "french"])
        CATEGORIES.append(["French Southwest", "sud_ouest"])
        CATEGORIES.append(["Galician", "galician"])
        CATEGORIES.append(["Gastropubs", "gastropubs"])
        CATEGORIES.append(["Georgian", "georgian"])
        CATEGORIES.append(["German", "german"])
        CATEGORIES.append(["Giblets", "giblets"])
        CATEGORIES.append(["Gluten-Free", "gluten_free"])
        CATEGORIES.append(["Greek", "greek"])
        CATEGORIES.append(["Halal", "halal"])
        CATEGORIES.append(["Hawaiian", "hawaiian"])
        CATEGORIES.append(["Heuriger", "heuriger"])
        CATEGORIES.append(["Himalayan/Nepalese", "himalayan"])
        CATEGORIES.append(["Hong Kong Style Cafe", "hkcafe"])
        CATEGORIES.append(["Hot Dogs", "hotdog"])
        CATEGORIES.append(["Hot Pot", "hotpot"])
        CATEGORIES.append(["Hungarian", "hungarian"])
        CATEGORIES.append(["Iberian", "iberian"])
        CATEGORIES.append(["Indian", "indpak"])
        CATEGORIES.append(["Indonesian", "indonesian"])
        CATEGORIES.append(["International", "international"])
        CATEGORIES.append(["Irish", "irish"])
        CATEGORIES.append(["Island Pub", "island_pub"])
        CATEGORIES.append(["Korean", "korean"])
        CATEGORIES.append(["Kosher", "kosher"])
        CATEGORIES.append(["Kurdish", "kurdish"])
        CATEGORIES.append(["Laos", "laos"])
        CATEGORIES.append(["Laotian", "laotian"])
        CATEGORIES.append(["Latin American", "latin"])
        CATEGORIES.append(["Live/Raw Food", "raw_food"])
        CATEGORIES.append(["Lyonnais", "lyonnais"])
        CATEGORIES.append(["Malaysian", "malaysian"])
        CATEGORIES.append(["Meatballs", "meatballs"])
        CATEGORIES.append(["Mediterranean", "mediterranean"])
        CATEGORIES.append(["Mexican", "mexican"])
        CATEGORIES.append(["Middle Eastern", "mideastern"])
        CATEGORIES.append(["Milk Bars", "milkbars"])
        CATEGORIES.append(["Modern Australian", "modern_australian"])
        CATEGORIES.append(["Modern European", "modern_european"])
        CATEGORIES.append(["Mongolian", "mongolian"])
        CATEGORIES.append(["Moroccan", "moroccan"])
        CATEGORIES.append(["New Zealand", "newzealand"])
        CATEGORIES.append(["Night Food", "nightfood"])
        CATEGORIES.append(["Norcinerie", "norcinerie"])
        CATEGORIES.append(["Open Sandwiches", "opensandwiches"])
        CATEGORIES.append(["Oriental", "oriental"])
        CATEGORIES.append(["Pakistani", "pakistani"])
        CATEGORIES.append(["Parent Cafes", "eltern_cafes"])
        CATEGORIES.append(["Parma", "parma"])
        CATEGORIES.append(["Persian/Iranian", "persian"])
        CATEGORIES.append(["Peruvian", "peruvian"])
        CATEGORIES.append(["Pita", "pita"])
        CATEGORIES.append(["Pizza", "pizza"])
        CATEGORIES.append(["Polish", "polish"])
        CATEGORIES.append(["Portuguese", "portuguese"])
        CATEGORIES.append(["Potatoes", "potatoes"])
        CATEGORIES.append(["Poutineries", "poutineries"])
        CATEGORIES.append(["Pub Food", "pubfood"])
        CATEGORIES.append(["Rice", "riceshop"])
        CATEGORIES.append(["Romanian", "romanian"])
        CATEGORIES.append(["Rotisserie Chicken", "rotisserie_chicken"])
        CATEGORIES.append(["Rumanian", "rumanian"])
        CATEGORIES.append(["Russian", "russian"])
        CATEGORIES.append(["Salad", "salad"])
        CATEGORIES.append(["Sandwiches", "sandwiches"])
        CATEGORIES.append(["Scandinavian", "scandinavian"])
        CATEGORIES.append(["Scottish", "scottish"])
        CATEGORIES.append(["Seafood", "seafood"])
        CATEGORIES.append(["Serbo Croatian", "serbocroatian"])
        CATEGORIES.append(["Signature Cuisine", "signature_cuisine"])
        CATEGORIES.append(["Singaporean", "singaporean"])
        CATEGORIES.append(["Slovakian", "slovakian"])
        CATEGORIES.append(["Soul Food", "soulfood"])
        CATEGORIES.append(["Soup", "soup"])
        CATEGORIES.append(["Southern", "southern"])
        CATEGORIES.append(["Spanish", "spanish"])
        CATEGORIES.append(["Steakhouses", "steak"])
        CATEGORIES.append(["Sushi Bars", "sushi"])
        CATEGORIES.append(["Swabian", "swabian"])
        CATEGORIES.append(["Swedish", "swedish"])
        CATEGORIES.append(["Swiss Food", "swissfood"])
        CATEGORIES.append(["Tabernas", "tabernas"])
        CATEGORIES.append(["Taiwanese", "taiwanese"])
        CATEGORIES.append(["Tapas Bars", "tapas"])
        CATEGORIES.append(["Tapas/Small Plates", "tapasmallplates"])
        CATEGORIES.append(["Tex-Mex", "tex-mex"])
        CATEGORIES.append(["Thai", "thai"])
        CATEGORIES.append(["Traditional Norwegian", "norwegian"])
        CATEGORIES.append(["Traditional Swedish", "traditional_swedish"])
        CATEGORIES.append(["Trattorie", "trattorie"])
        CATEGORIES.append(["Turkish", "turkish"])
        CATEGORIES.append(["Ukrainian", "ukrainian"])
        CATEGORIES.append(["Uzbek", "uzbek"])
        CATEGORIES.append(["Vegan", "vegan"])
        CATEGORIES.append(["Vegetarian", "vegetarian"])
        CATEGORIES.append(["Venison", "venison"])
        CATEGORIES.append(["Vietnamese", "vietnamese"])
        CATEGORIES.append(["Wok", "wok"])
        CATEGORIES.append(["Wraps", "wraps"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let sortNib = UINib(nibName: "SortByCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(sortNib, forCellReuseIdentifier: "sortbycell")
        let dealNib = UINib(nibName: "DealCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(dealNib, forCellReuseIdentifier: "dealcell")
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Sort by:"
        }else if(section == 1){
            return "Deals:"
        }else{
            return "Categories:"
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section < 2){
            return 1
        } else {
            return CATEGORIES.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section == 2){
            let cell = tableView.dequeueReusableCellWithIdentifier("filtercell", forIndexPath: indexPath) as FilterTableViewCell
            let categoryPair = CATEGORIES[indexPath.row]
            cell.categoryLabel.text = categoryPair[0]
            cell.delegate = self
            if let value = filtersDictionary[indexPath.row]{
                cell.filterSwitch.on = value
            } else {
                cell.filterSwitch.on = false
            }
            return cell
        }else if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("sortbycell", forIndexPath: indexPath) as SortByCell
            cell.delegate = self
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("dealcell", forIndexPath: indexPath) as DealCell
            cell.dealSwitch.on = false
            cell.delegate = self
            return cell
        }
    }
    
    func filterView(filterCell: FilterTableViewCell, didChangeSwitchValue value: Bool) {
        let indexPath = tableView.indexPathForCell(filterCell)!
        filtersDictionary[indexPath.row] = value
    }
    
    func sortByView(sortByCell: SortByCell, segmentValue value: Int) {
        sortBy = value
    }
    
    func dealView(dealCell: DealCell, didChangeSwitchValue value: Bool) {
        deals = value
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "searchSegue"){
            var categoriesString = ""
            for (index, value)  in filtersDictionary {
                if value {
                    if (categoriesString != "") {
                        categoriesString += ","
                    }
                    var cat = CATEGORIES[index][1] as NSString
                    categoriesString += cat
                }
            }
            println(categoriesString)
            var YVC = segue.destinationViewController as YelpViewController
            YVC.search = categoriesString
            YVC.sortBy = sortBy
            YVC.deals = deals
            println(sortBy)
        }
    }
    
}

