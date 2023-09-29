extend view entity ZNK05_CARRIER 
with
association [0..*] to /dmo/connection as _ZZConnections on _ZZConnections.carrier_id = /dmo/carrier.carrier_id
{
//  /dmo/carrier.currency_code as ZZCurrencyCode,
_ZZConnections 
}
