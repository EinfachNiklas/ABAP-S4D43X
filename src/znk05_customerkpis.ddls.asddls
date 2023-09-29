@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer KPIs'

define view entity ZNK05_CustomerKPIs
  with parameters
    P_City : /dmo/city
  as select from ZNK05_BookingWithCustomer
{
  key CustomerId                       as CustomerId,
      Customer                         as Name,
      Street                           as Street,
      PostalCode                       as PostalCode,
      City                             as City,
      CountryCode                      as CountryCode,
      PhoneNumber                      as PhoneNumber,
      //EmailAddress         as EmailAddress,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      sum(FlightPrice)                 as TotalRevenue,
      CurrencyCode,
      count(distinct(CarrierId))       as NumberOfDifferentCarriers,
      avg(DaysAhead as abap.dec(16,2)) as AverageDaysAhead
}
where
  BookingDate < $session.system_date
  and City = $parameters.P_City
group by
  CustomerId,
  Customer,
  Street,
  PostalCode,
  City,
  CountryCode,
  PhoneNumber,
  CurrencyCode
//EmailAddress
