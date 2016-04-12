public class AccountTestDataHelper {
    public static List<Account> createAccounts(){
        List<Account> lstAccs = new List<Account>();
        Account ac ;
        for(Integer i=0;i<10;i++){
            ac = new Account(Name='Test Account'+i);
            lstAccs.add(ac);
        }
        return lstAccs;
    }
    
     @InvocableMethod
     public static void call4mBuilder(){
        List<Account> accList = [SELECT Id, Name FROM Account ];
       for(Account acc :  accList){
           acc.Phone ='10101010';
       }
        update accList;
    }
}