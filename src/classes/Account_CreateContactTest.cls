@isTest
public class Account_CreateContactTest {
    static Account account {get; set;}
    static Contact contact {get; set;} 
    
    public static testmethod void testContact() {
        account = new Account();
        account.Name = 'ABCAccount';
        insert account;
        
        account = [
            select Id
                 , Name 
              from Account 
             where Id =: account.Id
        ];
        
        contact = new Contact();
        contact.LastName = account.Name + 'Cont';
        insert contact;
        
        contact = [
            select Id
                 , Name 
              from Contact 
             where Id =: contact.Id
         ];
         
         //system.assert(true, account.Name + 'Cont',  contact.Name);
        
    }
    
	
	
    
}