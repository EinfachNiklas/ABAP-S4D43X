CLASS lhc_ZR_NK05_TRAVEL DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.
    METHODS show_test_message FOR MODIFY
      IMPORTING keys FOR ACTION travel~show_test_message.
    METHODS cancel_booking FOR MODIFY
      IMPORTING keys FOR ACTION travel~cancel_booking.
    METHODS maintain_booking_fees FOR MODIFY
      IMPORTING keys FOR ACTION travel~maintain_booking_fees.

ENDCLASS.

CLASS lhc_ZR_NK05_TRAVEL IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD show_test_message.
    DATA(message) = NEW zcm_nk05_travel(
      i_textid    =  zcm_nk05_travel=>test_message
      i_severity  = if_abap_behv_message=>severity-warning
      i_user_name = sy-uname
    ).
    APPEND message TO reported-%other.

  ENDMETHOD.

  METHOD cancel_booking.
    "Ausgewählte Daten (Reisen) lesen
    READ ENTITY IN LOCAL MODE zr_nk05_travel
      FIELDS ( TravelUuid Description Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    "Über Schleife über Daten (Reisen) iterieren
    LOOP AT travels REFERENCE INTO DATA(travel).

      "Validierung
      if travel->Status = 'X'.
        DATA(message) = new zcm_nk05_travel(
        i_textid    = zcm_nk05_travel=>travel_already_cancelled
        i_severity  = if_abap_behv_message=>severity-error
        i_travel    = travel->Description
        ).
        APPEND VALUE #( %tky = travel->%tky %msg = message ) TO reported-travel.
        APPEND VALUE #( %tky = travel->%tky ) TO failed-travel.
        CONTINUE.
      ENDIF.

      "Daten (Reisen) ändern und ggf. Nachrichten erzeugen
      travel->Status = 'X'.

      message = new zcm_nk05_travel(
        i_textid    = zcm_nk05_travel=>travvel_cancelled_successfully
        i_severity  = if_abap_behv_message=>severity-success
        i_travel    = travel->Description ).
      Append value #( %tky = travel->%tky %msg = message ) to reported-travel.

      "Daten (Reisen) zurückschreiben.
      MODIFY ENTITY IN LOCAL MODE zr_nk05_travel
        UPDATE FIELDS ( Status )
        WITH value #( (  %tky = travel->%tky Status = travel->Status ) ).

    ENDLOOP.
    ENDMETHOD.

  METHOD maintain_booking_fees.
    READ ENTITY IN LOCAL MODE zr_nk05_travel
      FIELDS ( TravelUuid )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

      LOOP AT travels REFERENCE INTO DATA(travel).

        travel->BookingFee = keys[ sy-tabix ]-%param-BookingFee.
        travel->CurrencyCode = keys[ sy-tabix ]-%param-CurrencyCode.

        modify entity in local mode ZR_NK05_TRAVEL
          update fields ( BookingFee CurrencyCode )
          With value #(  ( %tky = travel->%tky BookingFee = travel->BookingFee CurrencyCode = travel->CurrencyCode ) ).

      ENDLOOP.
  ENDMETHOD.

ENDCLASS.
