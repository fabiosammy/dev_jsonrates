# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.loadStock = (id_chart) ->
  Highcharts.chart id_chart,
    chart:
      zoomType: 'x'
      type: 'spline'
    title:
      text: 'Comparativo Monetário com o dólar americano'
    subtitle:
      text: 'Fonte: jsonrates.com'
    xAxis:
      type: 'datetime'
    yAxis:
      title:
        text: 'Comparativo'
      labels:
        formatter: ->
          '$' + @value
    tooltip:
      crosshairs: true
      shared: true
    plotOptions:
      spline:
        marker:
          radius: 4
          lineColor: '#666666'
          lineWidth: 1
    series: $('#' + id_chart).data('stock')
