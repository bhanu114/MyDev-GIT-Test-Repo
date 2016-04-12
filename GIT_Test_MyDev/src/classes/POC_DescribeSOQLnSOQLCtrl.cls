/*
*   To perform dynamic SOQL and SOSL operations
*   Status : In progress
*/
public class POC_DescribeSOQLnSOQLCtrl {
    private static Map<String,List<String>> mapObjNameNDetail;
    private static List<SObject> lstSObj;
    public static List<ObjWrapper> lstWraps {set;get;}
    public String findText {set;get;}
    
    public POC_DescribeSOQLnSOQLCtrl(){
        //findText = 'test';
        lstWraps = new List<ObjWrapper>();
    }
    
    /*
    *   Method : Perform basic SOSL query operation
    *   Status : In progress
    */
    public List<String> performSOSLSearch(){
        List<List<SObject>> searchList = Search.query(prepareSOSLQuery());
        
        lstSobj = new List<SObject>();
        for(Integer i=0;i < searchList.size();i++){
            lstSobj= searchList[i];
            perform(searchList[i],searchList[i].getSObjectType());
        }
        return null;
    }
    
    private String prepareSOSLQuery(){
        String find = findText+'*';
        //String query = 'FIND ' +'\'' + find +'\'' +'IN ALL FIELDS RETURNING Account (Id, Name), Contact(Id, Name), Opportunity(Id, Name), Lead';
        String query = 'FIND ' +'\'' + find +'\'' +'IN ALL FIELDS RETURNING ';
        for(Integer i=0;i < lstWraps.size();i++){
            query += lstWraps[i].objName + ' (Id, Name)';
            if(!(i== (lstWraps.size()-1))){
                query += ',';
            }
        }
        
        System.debug('*** query = ' + query);
        return query;
    }
    
    /*
    *   Method : Perform basic SOQL query operation 
    *   Status : In progress
    */
    public List<String> performSOQLSearch(){
        List<List<SObject>> searchList = [FIND 'Test*' IN ALL FIELDS RETURNING Account (Id, Name), Contact(Id, Name), Opportunity(Id, Name), Lead];

        lstSobj = new List<SObject>();
        for(Integer i=0;i < searchList.size();i++){
            lstSobj= searchList[i];
            perform(searchList[i],searchList[i].getSObjectType());
        }
        return null;
    }
    
    /*
    *   Method : Perform core logic
    *   Status : Done
    */
    public void perform(List<SObject> lstSobj2, Schema.SObjectType objName){
        System.debug('**** top : ' +objName+' Count = ' + lstSobj2.size());
        for(SObject s : lstSobj2){
            if(s.getSObjectType() == objName){
                //objName a = s;
                 System.debug('*** '+objName+' Name ' + s.get('Name') );
            }
        }
    }
    
    /*
    *   Method : Add new row for wrapper
    *   Status : In Progress
    */
    public void addSOSLRow(){
        lstWraps.add(new ObjWrapper(lstWraps.size()));
    }
    
    /*
    *   Method : Add new row for wrapper
    *   Status : In Progress
    */
    public void delSOSLRow(){
        Integer index = Integer.valueOf(ApexPages.currentPage().getParameters().get('delSOSLRowID'));
        lstWraps.remove(index);
    }
    
    /*
    *   Method : Wrapper to get Object and field names
    *   Status : Done
    */
    public class ObjWrapper {
        public ObjWrapper(Integer wId){
            wrapID = wId;
        }
        public Integer wrapID {set;get;}
        public String objName {set;get;}
        public List<String> objFNames {set;get;}
    }
}