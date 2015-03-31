jQuery ->
  createChart = (eventsData) ->
    lables = []
    data = []
    for object in eventsData
      lables.push object.name
      data.push object.value

    chart = {
      labels : lables,
      datasets : [
        {
          fillColor : "rgba(151,187,205,0.5)",
          strokeColor : "rgba(151,187,205,1)",
          pointColor : "rgba(151,187,205,1)",
          pointStrokeColor : "#fff",
          data : data
        }
      ]
    }

    myNewChart = new Chart($("#canvas").get(0).getContext("2d")).Bar(chart)
# --------------------------------------------------------------------------------------

  createChart($('#events-day').data('events'))

  $('#toggleInstructions').click ->
    $('#docs').toggle()
    return
  
  $('#month').click ->
    createChart($('#events-month').data('events'))
  $('#week').click ->
    createChart($('#events-week').data('events'))  
  $('#three-days').click ->
    createChart($('#events-three-days').data('events'))  
  $('#today').click ->
    createChart($('#events-day').data('events'))