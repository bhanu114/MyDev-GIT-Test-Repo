/*
 HISTORY                                                                  
 |                                                                           
 |   DATE            DEVELOPER        WR/Req         DESCRIPTION                               
 |   ====            =========        ======         =========== 
 |  DD-MMM-YYYY      FULL NAME                      <Short description>     
*/
public class FieldTypeCountController {
    
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public String selectedObject {get; set;}
    //public String selectedField {get; set;}
    public List<FieldTypeCountHelper.FieldTypeWrapper> ftwList {set;get;}
    public Boolean isPerformed{set;get;}
    /*
    *   Constructor
    */
    public FieldTypeCountController(){
        ftwList = new List<FieldTypeCountHelper.FieldTypeWrapper>();
        //ftwList =  FieldTypeCountHelper.perform();
    }
    /*
    * Method returns all object names
    */
    public List<SelectOption> getObjectNames() {
        List<SelectOption> objNames = new List<SelectOption>();
        List<String> entities = new List<String>(schemaMap.keySet());
        entities.sort();
        for(String name : entities) {
            objNames.add(new SelectOption(name,name));
        }
        return objNames;
     }
    /*
    *   action method to call FieldTypeCountHelper.perform method
    */
     public void doObjectFieldTypeCount() {
           if(selectedObject != null && selectedObject != ''){
                System.debug('*** in selectedObject.isNotEmpty()');
                Set<String> objNameSet = new Set<String>{selectedObject};
                ftwList =  FieldTypeCountHelper.perform(objNameSet);
           }
           //ftwList =  FieldTypeCountHelper.perform();
           
           System.debug('*** controller,  ftwList = '+ ftwList + ' : ftwList size = ' + ftwList.size());
           //return null;
      }       
}