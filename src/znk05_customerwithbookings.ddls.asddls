@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer with Bookings'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZNK05_CUSTOMERWITHBOOKINGS
  as select from /dmo/customer
  association [0..*] to /dmo/booking as _Bookings on /dmo/customer.customer_id = _Bookings.customer_id
{
  key /dmo/customer.customer_id as CustomerId,
  /dmo/customer.title as Title,
  /dmo/customer.first_name as FirstName,
  /dmo/customer.last_name as LastName,
  /dmo/customer.street as Street,
  /dmo/customer.postal_code as PostalCode,
  /dmo/customer.city as City,
  
  /* Associations */
  _Bookings
  }
