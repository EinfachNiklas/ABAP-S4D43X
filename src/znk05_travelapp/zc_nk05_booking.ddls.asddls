@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking'
@Metadata.allowExtensions: true
define view entity ZC_NK05_BOOKING 
  as projection on ZR_NK05_BOOKING
{
  key BookingUuid,
  TravelUuid,
  BookingId,
  BookingDate,
  CustomerId,
  CarrierId,
  ConnectionId,
  FlightDate,
  FlightPrice,
  CurrencyCode,
  /* Associations */
  _Travel : redirected to parent ZC_NK05_Travel
}
