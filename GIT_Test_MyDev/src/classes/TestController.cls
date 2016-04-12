/*
Used for POC
*/
public class TestController {
    public Opportunity currentOppty {set; get;}
    public  List<TestController.RowFieldsWrapper> clsLstRFW {set; get;}
    public  TestController.RowFieldsWrapper clsRFW {set;get;}
    public String dat {get;set;}
    
     public TestController(ApexPages.StandardController controller) {
        currentOppty = (Opportunity) controller.getRecord();
        System.debug('**** currentOppty = ' +currentOppty);
        clsLstRFW = new List<TestController.RowFieldsWrapper>();
    }

    /*
    *  Method to add new row of wraper class
    */
    public void addRow(){
        if(clsLstRFW.size() < 3){
            clsRFW = new TestController.RowFieldsWrapper( );
            clsLstRFW.add(clsRFW);
        } else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Maximum rows alowed is 3 only'));
        }
    }
     public PageReference delRow(){
         //System.debug('*** 
        if(clsLstRFW.size() > 0)
            clsLstRFW.remove(clsLstRFW.size()-1);
        return null;
    }
    
    public void save(){
        //update Oppty if VF page having wrapper records
        if(!clsLstRFW.isEmpty()){
            for(Integer i=0;i<clsLstRFW.size();i++){
                if(i==0){
                    currentOppty.Model_1__c = clsLstRFW[i].model;
                    currentOppty.Quantity_1__c =(Integer) Integer.valueOf(clsLstRFW[i].quantity);
                }
                if(i==1){
                    currentOppty.Model_2__c = clsLstRFW[i].model;
                    currentOppty.Quantity_2__c = (Integer)Integer.valueOf(clsLstRFW[i].quantity);
                }
                if(i==2){
                    currentOppty.Model_3__c = clsLstRFW[i].model;
                    currentOppty.Quantity_3__c = (Integer)Integer.valueOf(clsLstRFW[i].quantity);
                }
            }
        }
        update currentOppty;
    }
    /*
    *   Wrapper class to hold row fields
    */
    public class RowFieldsWrapper {
        /*RowFieldsWrapper(Integer wID, String m,String q, Boolean f){
            wrapID = wID;
            model = m;
            quantity = q;
            flag = f;
        }*/
        RowFieldsWrapper(){}
        public Integer wrapID {set;get;}
        public String model {set;get;}
        public String quantity {set;get;}
        public Boolean flag {set;get;}
    }
    public class MyAppException extends Exception{}
}