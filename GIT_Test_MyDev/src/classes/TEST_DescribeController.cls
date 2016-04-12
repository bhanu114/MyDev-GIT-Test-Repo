/*
*  Class to perform Describe operations
*/

public class TEST_DescribeController {
    public List<ObjNameWrapper> lstONW {set;get;} //List of wrapper classes
    private ObjNameWrapper oNW;// wrapper class instance
    private List<String> lstObjNames = new List<String>();
    public Boolean hasResult {set;get;}
    public Map<String, List<String>> mapObjResult {set;get;}
    
    /*
    *   Constructor
    */
    public TEST_DescribeController(){
        lstONW = new List<ObjNameWrapper>();//Initialize list of Wrapper classes
        hasResult = false;
        
    }
    
    /*
    *   Seach Object Description by name 
    */
    public void search(){
        //Itirate through wrapper list
        for(ObjNameWrapper c : lstONW){
            lstObjNames.add(c.objName);
        }
        mapObjResult = TEST_DescribeUtil.getObjdetails(lstObjNames);
        hasResult = (mapObjResult.keySet().size() > 0);
        System.debug('**** result = ' + String.valueOf(lstObjNames.size()) + ' ' + hasResult);
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning, String.valueOf(lstObjNames.size()) + ' ' + hasResult));
        //return null;
    }
    /*
    *   Add Object name method
    */
    public void addRow(){
        oNW = new ObjNameWrapper();
        lstONW.add(oNW);
    }
    
    /*
    *   Delete Object name method
    */
    public PageReference delRow(){
        if(lstONW.size() > 0)
            lstONW.remove(lstONW.size()-1);
        return null;
    }
    /*
    *   Object Name Wrapper class
    */

    public class ObjNameWrapper{
        public String objName {set;get;}
    }
}