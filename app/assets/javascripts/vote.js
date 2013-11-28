//jquery finds button and clicks, gathering data-expense-id
//method takes that data, renders it through json, and sends it to the server through a post route
//upon voting, it renders a new vote count through ajax

//upvote//
function upvoteExpense(expense_id){
  var data = {"expense_id":expense_id}
  $.post('/users_upvote_expense', data, function(json){
      $('#upvotecountspan'+expense_id.toString()).html(json.upvote_count);
      $('#downvotecountspan'+expense_id.toString()).html(json.downvote_count);
    })
}

$(function(){
  $("button.upvote").click(function(){
    upvoteExpense($(this).data("expense-id"))
  })
})

//downvote//
function downvoteExpense(expense_id){
  var data = {"expense_id":expense_id}
  $.post('/users_downvote_expense', data, function(json){
      $('#downvotecountspan'+expense_id.toString()).html(json.downvote_count);
      $('#upvotecountspan'+expense_id.toString()).html(json.upvote_count);
    })
}

$(function(){
  $("button.downvote").click(function(){
    downvoteExpense($(this).data("expense-id"))
  })
})