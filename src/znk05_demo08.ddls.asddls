@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 8: Union'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZNK05_DEMO08
    as select from /dmo/customer
  {
   key customer_id as CustomerId,
        first_name  as FirstName,
        last_name   as LastName,
        city        as City
  }
  where
    city = 'Berlin'
 union select from /dmo/customer as Customer
    inner join   /dmo/travel   as Travel on Travel.customer_id = Customer.customer_id
    inner join   /dmo/agency   as Agency on Agency.agency_id = Travel.agency_id
{
  key Customer.customer_id as CustomerId,
  Customer.first_name  as FirstName,
  Customer.last_name   as LastName,
  Customer.city        as City
}
where
  Agency.city = 'Berlin'
