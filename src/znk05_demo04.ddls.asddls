@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 4: Arithmetic Expressions and Type Casts'

define view entity ZNK05_DEMO04
  as select from /dmo/flight
{
  key carrier_id                       as CarrierId,
  key connection_id                    as ConnectionId,
  key flight_date                      as FlightDate,
      price                            as OldPrice,
      currency_code                    as CurrencyCode,
      seats_max                        as SeatsMax,
      seats_occupied                   as SeatsOccupied,
      seats_max - seats_occupied       as SeatsFree,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price * 2                        as DoublePrice,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast( price as abap.fltp ) * 1.2 as NewPrice,
      'LH'                             as CarrierId1,
      cast ( 'LH' as /dmo/carrier_id ) as CarrierId2
}
