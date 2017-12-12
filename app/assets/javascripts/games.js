$( function() {

  var drag = $( ".draggable" ).children()
  
  // drag control
  drag.draggable({
    containment : 'table',
    snap :'.tile',
    snapTolerance: 32,
    snapMode: "inner",

    drag: function( event, ui ) {

    }
  })

  // drop function
  $( ".droppable").children().droppable({
    drop: function( event, ui ) {
      var dest = $(this).parent().data();

      // var origX = ui.draggable.parent().data('position_x');
      // var origY = ui.draggable.parent().data('position_y');

      var destX = $(this).parent().data('position_x')
      var destY = $(this).parent().data('position_y')

      var pieceId = ui.draggable.parent().data('piece-id')

      // var piece = {piece: {position_x: origX, position_y: origY, id: pieceId}};
      var target = {piece: {position_x : destX, position_y: destY, id: pieceId}};
      

       $.ajax({
        type: 'PUT',
        url: '/pieces/update/',
        headers: {
        'X-CSRF-Token': $("meta[name='csrf-token']").attr("content")
          },
        dataType: 'json',
        data: target
      })

      location.reload();
    }
  });

});