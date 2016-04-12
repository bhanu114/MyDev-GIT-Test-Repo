public with sharing class AllObjectCtrl {

 public Set<String> objNameSet{get;set;}
 public Set<String> objFleldSet{get;set;}
 public Set<String> fleldValueSet{get;set;}
 public String selectedObjectName{get;set;}
 public String selectedField {get;set;}
 public String selectedFieldValue {get;set;}
 Schema.DescribeSObjectResult objDescribe;

 private Map <String,Schema.SobjectType> schemaMap=null;
    // Set All object names set using Schema
    public AllObjectCtrl(){
        schemaMap=Schema.getGlobalDescribe();
        objNameSet = new Set<String>();
        objFleldSet = new Set<String>();
        List<Schema.SobjectType> schemaObjs=schemaMap.values();
        for(String s : schemaMap.keySet()){
            System.debug('****** keys = ' + s);
        }
        //Set Object names set
        for(Schema.SobjectType sot : schemaMap.values()){
            objNameSet.add(sot.getDescribe().getLabel());
        }
    }
    //Return Object name options
     public List<SelectOption> getObjectNameOptions() {
         
         List<SelectOption> options=new List<SelectOption>();
         options.add(new SelectOption('','None'));
         
         for(String s:objNameSet) {
             options.add(new SelectOption(s,s));
             System.debug('***** object names = ' + s);
         }

         return options;
     }
     //Set Field name set based on selected object name
     public PageReference setObjectFieldNames() {
         System.debug('**** in set object fields method, selectedObjectName = ' + objFleldSet.size());
        if(selectedObjectName != null && selectedObjectName != ''){
            Map<String, Schema.SobjectField> fields=schemaMap.get(selectedObjectName).getDescribe().fields.getMap();
             
            for(Schema.SObjectField sot : fields.values()){
                objFleldSet.add(sot.getDescribe().getLabel());
            }
        }
        return null;
    }
    //Return Field name Options
    public List<SelectOption> getObjectFieldNameList(){
        
        if(selectedObjectName != null && selectedObjectName != ''){
             List<SelectOption> options=new List<SelectOption>();
             options.add(new SelectOption('','None'));
             
             for(String s:objFleldSet) { 
                 options.add(new SelectOption(s,s));
                 System.debug('***** Field names = ' + s);
             }

             return options;
        }
        return null;
     }
     
     public PageReference setFieldValues() {
         System.debug('**** in set object fields method, selectedObjectName = ' + objFleldSet.size());
        if(selectedObjectName != null && selectedObjectName != ''){
            Schema.SobjectField fields=schemaMap.get(selectedObjectName).getDescribe().fields.getMap().get(selectedField);
            /*for(Schema.SObjectField sot : fields.values()){
                objFleldSet.add(sot.getDescribe().getLabel());
            }*/
        }
        return null;
    }
}