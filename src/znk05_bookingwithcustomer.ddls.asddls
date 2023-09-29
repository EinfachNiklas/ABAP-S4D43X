@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking with Customer'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZNK05_BookingWithCustomer
  as select from /dmo/booking
    inner join   /dmo/customer on /dmo/booking.customer_id = /dmo/customer.customer_id
{
  key /dmo/booking.travel_id                               as TravelId,
  key /dmo/booking.booking_id                              as BookingId,
  key /dmo/customer.customer_id                            as CustomerId,
      /dmo/booking.booking_date                            as BookingDate,
      /dmo/booking.carrier_id                              as CarrierId,
      /dmo/booking.connection_id                           as ConnectionId,
      /dmo/booking.flight_date                             as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @EndUserText: {label: 'Flugpreis in Euro'}
      round(currency_conversion(
        amount => /dmo/booking.flight_price,
        source_currency => /dmo/booking.currency_code,
        target_currency => cast('EUR' as abap.cuky),
        exchange_rate_date => /dmo/booking.booking_date,
        error_handling => 'KEEP_UNCONVERTED'),-1) as FlightPrice,
      cast('EUR' as abap.cuky)                             as CurrencyCode,
      dats_days_between(/dmo/booking.booking_date, /dmo/booking.flight_date) as DaysAhead,
      case when /dmo/customer.title is initial then concat_with_space(/dmo/customer.first_name, /dmo/customer.last_name, 1)
           else concat_with_space(concat_with_space(/dmo/customer.title, /dmo/customer.first_name, 1), /dmo/customer.last_name, 1)
      end as Customer,
      /dmo/customer.street                                 as Street,
      /dmo/customer.postal_code                            as PostalCode,
      /dmo/customer.city                                   as City,
      /dmo/customer.country_code                           as CountryCode,
      /dmo/customer.phone_number                           as PhoneNumber,
      /dmo/customer.email_address                          as EmailAddress
}

where
  /dmo/customer.country_code = 'DE'
