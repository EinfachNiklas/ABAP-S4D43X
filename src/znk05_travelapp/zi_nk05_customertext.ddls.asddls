@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Textelement'

define view entity ZI_NK05_CustomerText
  as select from ZI_NK05_Customer
{
  key CustomerId,
      concat_with_space(FirstName, LastName, 1) as CustomerName
}
