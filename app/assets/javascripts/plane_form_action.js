function PlaneFormAction(book_button) {
  this.book_button = book_button;
}

PlaneFormAction.prototype = {
  init: function() {
    this.onBookButtonClick();
  },

  onBookButtonClick: function() {
    this.book_button.click(function(e) {
      e.preventDefault();
      $('div#booking_form').toggleClass('hide');
    });
  }
}
