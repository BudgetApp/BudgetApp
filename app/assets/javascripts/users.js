$(function(){
  
  var ctx = $("#donut-landing-chart").get(0).getContext("2d");
  var donutLandingChart = new Chart(ctx);

  $.get('/users/expenses/weekly', function(weeklyExpenses){
    var expenses = weeklyExpenses.expenses;

    donutLandingChart.Doughnut(expenses, {labelAlign: 'center'});

  });


});