//jquery finds button and clicks, gathering data-expense-id
//method takes that data, renders it through json, and sends it to the server through a post route
//upon voting, it renders a new vote count through ajax

function voteExpense(expense_id, route){
  var data = {"expense_id":expense_id}
  $.post(route, data, function(json){
      $('#upvotecountspan'+expense_id.toString()).html(json.upvote_count);
      $('#downvotecountspan'+expense_id.toString()).html(json.downvote_count);
    })
}

function addVoteButtonListeners(){
  $("button.upvote").on("click", function(){
    upvoteExpense($(this).data("expense-id"))
  })

  $("button.downvote").on("click", function(){
    downvoteExpense($(this).data("expense-id"))
  })
}

//upvote//
function upvoteExpense(expense_id){
  voteExpense(expense_id, '/users_upvote_expense');
}

//downvote//
function downvoteExpense(expense_id){
  voteExpense(expense_id, '/users_downvote_expense');
}

$(function(){
  addVoteButtonListeners();
})