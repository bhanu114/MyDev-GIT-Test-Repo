public class exampleCon {
    Integer count = 0;
    public Set<String> objNameSet{get;set;}
     public Set<String> objFleldSet{get;set;}
     public String selectedObjectName{get;set;}
     public String selectedField {get;set;}
            
    public void initObjNames() {
       
        
    }  
    //Return Object name options
     public List<SelectOption> getObjectNameOptions() {
          objNameSet = new set<String>();
        objNameSet.add('one');
        objNameSet.add('two');
        objNameSet.add('three');
         List<SelectOption> options=new List<SelectOption>();
         options.add(new SelectOption('','None'));
         
         for(String s:objNameSet) {
             options.add(new SelectOption(s,s));
             System.debug('***** object names = ' + s);
         }

         return options;
     }
     //Set Field name set based on selected object name
     public void objectFieldNames() {
         System.debug('**** in set object fields method');
         
          objFleldSet= new set<String>();
        objFleldSet.add('one');
        objFleldSet.add('two');
        objFleldSet.add('three');
             
            for(String sot : objFleldSet){
                objFleldSet.add(sot);
            }
        
    }
    public PageReference incrementCounter() {
            count++;
            return null;
    }
                    
    public Integer getCount() {
        return count;
    }
}