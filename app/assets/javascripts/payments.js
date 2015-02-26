$(document).ready(function(){

  if (typeof(Stripe) === "undefined") {
    return;
  }

  Stripe.setPublishableKey($("meta[name='stripe-key']").attr('content'));

  $('#cc-form').submit(function(){

    $('#stripe-errors').html('');
    $('input[type="submit"]').attr('disabled', true);

    card = {
      number: $('#_card_number').val(),
      cvc: $('#_cvc').val(),
      expMonth: $('#date_month').val(),
      expYear: $('#date_year').val()
    };

    Stripe.createToken(card, handleStripeResponse);

    return false;

  });

  handleStripeResponse = function(status, response) {
    if (status === 200) {
      // send token to Rails server
      $('#_stripe_token').val(response.id);
      $('#token-form').submit();
    } else {
      $('#stripe-errors').html(response.error.message);
      $('input[type="submit"]').removeAttr('disabled');
    }
  };

});