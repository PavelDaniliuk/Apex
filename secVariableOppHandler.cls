public class OpportunityHandler { 
	private static Map<Id, Decimal> amountOfTheOpp = new Map<Id, Decimal>();

	public void recalculateOpportunitiesAmount(List<Opportunity> oppList) {	

		List<OpportunityLineItem> oppLineItems = getOppLineItems(opplist);
		addIdWithTotalPriceToMap(oppLineItems);
		updateAmountFieldOnOpp(opplist);
		update oppList;
	}

	private void addIdWithTotalPriceToMap (List<OpportunityLineItem> oppLineItems) {

		for(OpportunityLineItem oppLineItem: oppLineItems) {
			if(amountOfTheOpp.containsKey(oppLineItem.OpportunityId)) {
				Decimal oopAmount = amountOfTheOpp.get(oppLineItem.OpportunityId);

				amountOfTheOpp.put(oppLineItem.OpportunityId, oopAmount + oppLineItem.TotalPrice);
			} else {
				amountOfTheOpp.put(oppLineItem.OpportunityId, oppLineItem.TotalPrice);
			}
		}
	}

	private void updateAmountFieldOnOpp (List<Opportunity> oppList) {
		
		for(Opportunity opp: oppList) {
			for(Id oppId: amountOfTheOpp.keySet()) {
				if(opp.Id == oppId) {
					opp.Amount = amountOfTheOpp.get(oppId);
				}
			}
		}
	}

	private List<OpportunityLineItem> getOppLineItems(List<Opportunity> oppList) {
		Set<Id> oppId = new Set<Id>();

		for(Opportunity opp: oppList) {
			oppId.add(opp.Id);
		}
		List<OpportunityLineItem> oppLineItems = [SELECT OpportunityId, TotalPrice FROM OpportunityLineItem 
													WHERE OpportunityId IN :oppId];
		return oppLineItems;
	}
}