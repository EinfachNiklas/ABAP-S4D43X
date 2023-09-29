@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Carrier'

define view entity ZNK05_CARRIER as select from /dmo/carrier
{
  key carrier_id as CarrierId,
  name as Name
}
