public class OpportunityHandler { 
	private Set<Id> oppIds = new Set<Id>();
	private List<Opportunity> newAmount = new List<Opportunity>();
	private Map<Id, Decimal> amountOfTheOpp = new Map<Id, Decimal>();
	private Decimal ttlPrice;

	public void recalculateOpportunitiesAmount() {	
		Set<Id> oppIds = getOppIdWithOLI();
		Map<Id, Decimal> amountOfTheOpp = getTotalPriceProducts();

		for(Id id: amountOfTheOpp.keySet()) {
			newAmount.add(new Opportunity(Id = id, Amount = amountOfTheOpp.get(id)));
		}
		update newAmount;
	}

	private Set<Id> getOppIdWithOLI() {
	
		for(Opportunity opp: [SELECT Id, Name FROM Opportunity WHERE 
                      Id IN (SELECT OpportunityId FROM OpportunityLineItem)]){
				oppIds.add(opp.Id);     
		}
		return oppIds;		
	}

	private Map<Id, Decimal> getTotalPriceProducts () {	
	
		for(Id i: oppIds) {
			List<OpportunityLineItem> item = [SELECT TotalPrice FROM OpportunityLineItem WHERE OpportunityId = :i];
			    
			for(OpportunityLineItem price: item){

     			if(!amountOfTheOpp.containsKey(i)){
					amountOfTheOpp.put(i, price.TotalPrice);
				} else {
					 ttlPrice = amountOfTheOpp.get(i);
					 ttlPrice = ttlPrice + price.TotalPrice;
					 amountOfTheOpp.put(i, ttlPrice);
				  }
			}
		}
		return amountOfTheOpp;
	}
}