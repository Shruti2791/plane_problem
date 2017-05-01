function Plane(element) {
  this.plane_element = element;
  this.plan = element.data('plan');
  this.filledSeats = element.data('filled-seats');
}

Plane.prototype = {
  init: function() {
    this.setup();
    this.onSubmitClick();
    this.markBookingOrder(this.filledSeats);
  },

  setup: function() {
    var _this = this;
    $.each(this.plan, function(index, value) {
      var lane = $('<div>').attr({ class: 'lane', id: 'lane-' + (index + 1) });
      for (var i = 1 ; i <= value[1]; i++) {
        if (index == 0) {
          lane.append(_this.alignFirstRowSeats(value[0]).attr({id: 'row-' + i}));
        } else if (index == _this.plan.length - 1) {
          lane.append(_this.alignLastRowSeats(value[0]).attr({id: 'row-' + i}));
        }else {
          lane.append(_this.alignMiddleRowSeats(value[0]).attr({id: 'row-' + i}));
        }
      }
      _this.plane_element.append(lane);
    })
  },

  alignFirstRowSeats: function(seat_count) {
    var row = $('<div>');
    for(var i = 1; i <= seat_count; i++) {
      if (i == 1) {
        row.append($('<div>').addClass('seat window').attr({ id: 'column-' + i }));
      } else if (i == seat_count) {
        row.append($('<div>').addClass('seat aisle').attr({ id: 'column-' + i }));
      } else {
        row.append($('<div>').addClass('seat center').attr({ id: 'column-' + i }));
      }
    }
    return row;
  },

  alignLastRowSeats: function(seat_count) {
    var row = $('<div>');
    for(var i = 1; i <= seat_count; i++) {
      if (i == 1) {
        row.append($('<div>').addClass('seat aisle').attr({ id: 'column-' + i }));
      } else if (i == seat_count) {
        row.append($('<div>').addClass('seat window').attr({ id: 'column-' + i }));
      } else {
        row.append($('<div>').addClass('seat center').attr({ id: 'column-' + i }));
      }
    }
    return row;
  },

  alignMiddleRowSeats: function(seat_count) {
    var row = $('<div>');
    for(var i = 1; i <= seat_count; i++) {
      if (i == 1 || i == seat_count) {
        row.append($('<div>').addClass('seat aisle').attr({ id: 'column-' + i }));
      } else {
        row.append($('<div>').addClass('seat center').attr({ id: 'column-' + i }));
      }
    }
    return row;
  },

  onSubmitClick: function() {
    var _this = this;
    $('#book').click(function(e) {
      e.preventDefault();
      $.ajax({
        type: "POST",
        url: $('form').attr('action'),
        data: $('form').serialize(),
        success: function(data, textStatus, jqXHR) {
          _this.markBookingOrder(data);
        },
        error: function(data, textStatus, jqXHR) {
          alert(JSON.parse(data.responseText).alert);
        }
      });
    });
  },

  markBookingOrder: function(filled_seats){
    $.each(filled_seats, function(index, value) {
      $('#lane-' + value.lane).children('#row-' + value.row).children('#column-' + value.column).html(value.booked_number);
    })
  }
}
