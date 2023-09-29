@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 13: Path Expressions'

define view entity ZNK05_DEMO13
  as select from ZNK05_DEMO12
{
  key CarrierId,
  key ConnectionId,
  key FlightDate,
      Price,
      CurrencyCode,
      PlaneTypeId,
      SeatsMax,
      SeatsOccupied,
      CarrierName,
      _Connection.airport_from_id as AirportFromId,
      _Connection.airport_to_id as AirportToId,
      
      /* Associations */
      _Bookings,
      _Carrier
}
