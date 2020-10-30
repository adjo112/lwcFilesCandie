public with sharing class OrderClass {
    @AuraEnabled
    public static Contact createContact(contact con) {
        insert con;
        return con;
    }
    
    @AuraEnabled
    public static OrderDetail__c createOrder(String status,Decimal amount,String prodId,Decimal quant){
         OrderDetail__c od=new OrderDetail__c();
         od.Status__c=status;
         od.Amount__c=amount;
         od.Product_Id__c=prodId;
         od.Order_date__c=Date.today();
         od.Quantity__c=quant;
         insert od;
         return od;
    }
    @AuraEnabled
    public static void updateOrder(String orderId,String contactId,String address,Decimal amount,String payment) {
        OrderDetail__c od=new OrderDetail__c();
        od=[Select Address__c,
        Status__c,
        Contact_Id__c 
        From OrderDetail__c
        Where Id=:orderId];
        od.Contact_Id__c=contactId;
        od.Status__c='Order Placed';
        od.Address__c=address;
        od.Payment__c=payment;
        od.Amount__c=amount;
        update od;
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact() {
        return[Select Id,
               Email 
               From Contact];
    }
}
