$(document).ready(bindPlayerListeners);

function bindPlayerListeners(){
  $(".js-next-player").on("click", function() {
    loadPlayer("next");
  });

  $(".js-previous-player").on("click", function() {
    loadPlayer("previous");
  });

  $('#player_form').submit(function(event){
      $("#status").text("Loading new player...");

      event.preventDefault();
      
      var player_url = $(this).serialize();
      var url = $(this).attr("action");

      var posting = $.post(url, player_url);

      posting.done(function(data){
        $("#playerResult").show();

        newPlayer = new Player(data.player);
        newPlayer.setInfo();

        $("#status").text("Successfully added " + data.player.name);
        $("#playerUrl").val("");
      })
  });
}

function Player(info){
  for(var key in info){
    this[key] = info[key];
  }
};

function loadPlayer(direction){
  var url;
  if(direction === "next"){
    url = $(".js-next-player").attr("href");
  } else if (direction === "previous"){
    url = $(".js-previous-player").attr("href");
  }

  if (url === '/players/0'){
    alert("No more players that way!");
    return;
  }

  $.get(url + ".json")
    .done(function(data) {
      currentPlayer = new Player(data.player);
      currentPlayer.setButtons();
      currentPlayer.setInfo();
      history.pushState({}, '', url);      
  });
}

Player.prototype.setButtons = function(){
  $(".js-next-player").attr("data-id", this.next_id);
  $(".js-previous-player").attr("data-id", this.prev_id);
  $(".js-next-player").attr("href", "/players/" + this.next_id);
  $(".js-previous-player").attr("href", "/players/" + this.prev_id); 
}

Player.prototype.setInfo = function(){
  // Set top information
  $("#name").text(this.name + '(' + this.position + ')');
  $("#score").text('Score: ' + this.score);
  $("#salary").text('Salary: $' + this.salary.toLocaleString());
  $("#value").text('Score Per Million: ' + this.value);

  if(this.team_count === 1){
    $("#team_count").text('Num of Teams: ' + this.team_count + " team");
  } else {
    $("#team_count").text('Num of Teams: ' + this.team_count + " teams");
  }

  // Set stats
  $("#points").text(this.points);
  $("#assists").text(this.assists);
  $("#rebounds").text(this.rebounds);
  $("#blocks").text(this.blocks);
  $("#steals").text(this.steals);
  $("#games_played").text(this.games_played);
}