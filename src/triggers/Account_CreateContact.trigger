trigger Account_CreateContact on Account (after insert, before update) {
   
  // public void createCOntact () {
     if (trigger.isInsert && trigger.isAfter) {
       Contact [] contact = new Contact [] {};
       for (Account account : trigger.new) {
           Contact cont = new Contact();
           cont.LastName =account.Name + 'contact';
           cont.AccountId = account.Id;
           contact.add(cont);
       }
       insert contact;
     }
  // }
    
}