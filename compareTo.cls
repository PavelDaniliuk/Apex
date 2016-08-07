global class UniversalComparator { 
	
	public static Integer compare(Object a, Object b) {
		try {
			if(a == null || b == null) {
		 return null;
		} else {
			if(a instanceof Decimal || b instanceof Decimal) {
				 Decimal decimalA = Decimal.valueOf(String.valueOf(a));
                 Decimal decimalB =  Decimal.valueOf(String.valueOf(b));
                   
                 if(decimalA > decimalB){
                     return 1;
                 }else if(decimalA < decimalB){
                     return -1;
                 }
                 return 0;
			}

			if(a instanceof DateTime || b instanceof DateTime) {            
                DateTime dTimeA = DateTime.valueOf(a);
                DateTime dTimeB = DateTime.valueOf(b);
                   
                if(dTimeA > dTimeB){
                    return 1;
                }else if(dTimeA < dTimeB){
                    return -1;
                }
                return 0;  
            }

			 if(firstValue instanceof Date || secondValue instanceof Date) {
                 Date dateA = Date.valueOf(a);
                 Date dateB = Date.valueOf(b);
                   
                 if(dateA > dateB){
                     return 1;
                 }else if(dateA < dateB){
                     return -1;
                 }
                 return 0;  
			}
	}
		} catch (Exception e){
			return null;
		}
		

	
}